#!/usr/bin/env python3
"""
Script de importação de membros do RobSIC para o Strapi.

Credenciais via arquivo .env (recomendado):
    STRAPI_URL=https://robsic.unifei.edu.br
    STRAPI_EMAIL=admin@email.com
    STRAPI_PASSWORD=suasenha

Uso:
    # Com .env (recomendado):
    python import_members.py --file ~/Downloads/pesquisadores.md

    # Sobrescrevendo credenciais via argumento:
    python import_members.py --file pesquisadores.md --url http://... --email x --password y

    # Simulação sem alterar nada no Strapi:
    python import_members.py --file pesquisadores.md --dry-run

Fontes de dados suportadas:
    - Arquivo .md  (via --file)
    - CSV do Google Sheets (futuro, via --csv)
"""

import argparse
import json
import os
import re
import sys
from pathlib import Path

import requests
from dotenv import load_dotenv

# Carrega .env da pasta scripts/ ou da raiz do projeto
load_dotenv(Path(__file__).parent / ".env")
load_dotenv(Path(__file__).parent.parent / ".env")

# ──────────────────────────────────────────────
# Mapeamento: seção do .md → campo "role" no Strapi
# ──────────────────────────────────────────────
SECTION_TO_ROLE = {
    "Líderes do Grupo": "Diretor",
    "Professores / Pesquisadores Associados (CNPq)": "Pesquisador",
    "Estudantes - Doutorado": "Doutorando",
    "Estudantes - Mestrado": "Mestrando",
    "Estudantes - Graduação": "Bolsista",
}

SKIP_VALUES = {
    "não encontrado",
    "não encontrado com confiança",
    "pedi para preencher o forms",
}


def clean_value(value: str) -> str | None:
    """Limpa anotações e retorna None para valores inválidos."""
    if not value:
        return None
    cleaned = value.strip().strip("*").strip()
    # Remove observações entre parênteses como "*(provável, não verificado)*"
    cleaned = re.sub(r"\s*\*\(.*?\)\*", "", cleaned).strip()
    if cleaned.lower() in SKIP_VALUES:
        return None
    return cleaned or None


def parse_md(filepath: str) -> list[dict]:
    """
    Lê um .md e retorna lista de dicts com dados dos membros.
    Pula automaticamente membros que aguardam preenchimento do forms.
    """
    members = []
    current_role = None
    current_member = None

    with open(filepath, encoding="utf-8") as f:
        lines = f.readlines()

    for line in lines:
        line = line.rstrip()

        # Detecta seção (## Título da seção)
        section_match = re.match(r"^##\s+(.+)$", line)
        if section_match:
            section_title = section_match.group(1).strip()
            current_role = SECTION_TO_ROLE.get(section_title)
            # Salva membro anterior antes de mudar de seção
            if current_member and current_member.get("name"):
                members.append(current_member)
            current_member = None
            continue

        # Detecta nome do membro (### Nome Completo)
        member_match = re.match(r"^###\s+(.+)$", line)
        if member_match:
            if current_member and current_member.get("name"):
                members.append(current_member)
            current_member = {
                "name": member_match.group(1).strip(),
                "role": current_role,
                "lattes": None,
                "orcid": None,
                "linkedin": None,
                "description": None,
                "email": None,
                "can_receive_email": False,
            }
            continue

        if current_member is None:
            continue

        # Detecta linha "Pedi para preencher o forms" — descarta membro
        if re.search(r"forms", line, re.IGNORECASE):
            print(f"  ⏳ Pulando '{current_member['name']}' — aguardando forms")
            current_member = None
            continue

        # Detecta campos: - **Campo:** valor
        field_match = re.match(r"^-\s+\*\*(.+?):\*\*\s*(.*)$", line)
        if field_match:
            key = field_match.group(1).strip().lower()
            value = clean_value(field_match.group(2))
            field_map = {
                "lattes": "lattes",
                "orcid": "orcid",
                "linkedin": "linkedin",
                "resumo": "description",
            }
            if key in field_map:
                current_member[field_map[key]] = value

    # Adiciona o último membro
    if current_member and current_member.get("name"):
        members.append(current_member)

    return members


# ──────────────────────────────────────────────
# Strapi API
# ──────────────────────────────────────────────

def get_auth_token(base_url: str, email: str, password: str) -> str:
    """Autentica no Strapi e retorna o token JWT."""
    resp = requests.post(
        f"{base_url}/api/auth/local",
        json={"identifier": email, "password": password},
        timeout=15,
    )
    resp.raise_for_status()
    token = resp.json().get("jwt")
    if not token:
        raise RuntimeError(f"Login falhou: {resp.json()}")
    print("✅ Login realizado com sucesso.")
    return token


def get_all_member_names(base_url: str, token: str) -> set[str]:
    """
    Busca todos os nomes de membros já cadastrados no Strapi.
    Suporta paginação para bases grandes.
    """
    headers = {"Authorization": f"Bearer {token}"}
    names: set[str] = set()
    page = 1
    page_size = 100

    while True:
        url = f"{base_url}/api/members?fields[0]=name&pagination[page]={page}&pagination[pageSize]={page_size}"
        resp = requests.get(url, headers=headers, timeout=15)
        resp.raise_for_status()
        data = resp.json()
        results = data.get("data", [])

        for item in results:
            # Suporta Strapi v4 (atributos aninhados) e v5 (campos no nível raiz)
            name = (
                item.get("attributes", {}).get("name")
                or item.get("name")
                or ""
            )
            if name:
                names.add(name.strip().lower())

        meta = data.get("meta", {}).get("pagination", {})
        if page >= meta.get("pageCount", 1):
            break
        page += 1

    return names


def create_member(base_url: str, token: str, member: dict) -> dict:
    """Cria um membro no Strapi e tenta publicá-lo."""
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }
    resp = requests.post(
        f"{base_url}/api/members",
        headers=headers,
        data=json.dumps({"data": member}),
        timeout=15,
    )
    if not resp.ok:
        print(f"    ❌ Erro {resp.status_code}: {resp.text[:200]}")
        return {}

    created = resp.json().get("data", {})
    member_id = created.get("id") or created.get("documentId")

    # Publica o registro recém-criado
    if member_id:
        requests.put(
            f"{base_url}/api/members/{member_id}",
            headers=headers,
            data=json.dumps({"data": {"publishedAt": "now"}}),
            timeout=15,
        )

    return created


# ──────────────────────────────────────────────
# Main
# ──────────────────────────────────────────────

def main():
    parser = argparse.ArgumentParser(
        description="Importa membros do RobSIC para o Strapi via API REST.",
        formatter_class=argparse.RawTextHelpFormatter,
    )
    parser.add_argument("--file", required=True, help="Caminho para o .md com os membros")
    parser.add_argument("--url", default=os.getenv("STRAPI_URL"), help="URL base do Strapi (ou STRAPI_URL no .env)")
    parser.add_argument("--email", default=os.getenv("STRAPI_EMAIL"), help="E-mail admin (ou STRAPI_EMAIL no .env)")
    parser.add_argument("--password", default=os.getenv("STRAPI_PASSWORD"), help="Senha (ou STRAPI_PASSWORD no .env)")
    parser.add_argument("--dry-run", action="store_true", help="Simula sem criar nada no Strapi")
    args = parser.parse_args()

    # Valida credenciais
    if not args.dry_run:
        missing = [k for k, v in {"--url": args.url, "--email": args.email, "--password": args.password}.items() if not v]
        if missing:
            print(f"❌ Credenciais faltando: {', '.join(missing)}")
            print("   Configure o arquivo scripts/.env ou passe os argumentos na linha de comando.")
            sys.exit(1)

    print(f"\n📄 Lendo arquivo: {args.file}")
    members = parse_md(args.file)
    print(f"   → {len(members)} membros encontrados para importar.\n")

    if args.dry_run:
        print("🔍 MODO DRY-RUN — Nenhuma alteração será feita no Strapi:\n")
        for m in members:
            print(f"  • [{m['role']}] {m['name']}")
            for k, v in m.items():
                if k not in ("name", "role", "can_receive_email", "email") and v:
                    print(f"      {k}: {str(v)[:90]}")
        return

    token = get_auth_token(args.url, args.email, args.password)

    print("\n🔍 Buscando membros já existentes no Strapi...")
    existing_names = get_all_member_names(args.url, token)
    print(f"   → {len(existing_names)} membros já cadastrados.\n")

    created_count = 0
    skipped_count = 0
    error_count = 0

    for member in members:
        name = member["name"]
        print(f"  → [{member['role']}] {name}")

        # Checagem de duplicata por nome (case-insensitive)
        if name.strip().lower() in existing_names:
            print(f"     ⚠️  Já existe no Strapi — pulando para evitar duplicata.")
            skipped_count += 1
            continue

        result = create_member(args.url, token, member)
        if result:
            print(f"     ✅ Criado! (ID: {result.get('id', '?')})")
            created_count += 1
        else:
            error_count += 1

    print(f"\n{'='*50}")
    print(f"✅ Criados:  {created_count}")
    print(f"⏭️  Pulados:  {skipped_count} (já existiam)")
    print(f"❌ Erros:    {error_count}")
    print(f"📋 Total:    {len(members)}")


if __name__ == "__main__":
    main()
