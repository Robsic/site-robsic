#!/usr/bin/env python3
"""
Script de importação de projetos do RobSIC para o Strapi.

Credenciais via arquivo .env (recomendado):
    STRAPI_URL=https://robsic.unifei.edu.br
    STRAPI_EMAIL=admin@email.com
    STRAPI_PASSWORD=suasenha

Uso:
    # Com .env (recomendado):
    python import_projects.py --file ~/Downloads/projetos_robsic.md

    # Sobrescrevendo credenciais via argumento:
    python import_projects.py --file projetos_robsic.md --url http://... --email x --password y

    # Simulação sem alterar nada no Strapi:
    python import_projects.py --file projetos_robsic.md --dry-run
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime
from pathlib import Path

import requests
from dotenv import load_dotenv

# Carrega .env da pasta scripts/ ou da raiz do projeto
load_dotenv(Path(__file__).parent / ".env")
load_dotenv(Path(__file__).parent.parent / ".env")


def infer_category(description: str, partners: str) -> str:
    """Inferência simples de categoria baseada em palavras-chave."""
    text = f"{description} {partners}".lower()
    if "realidade virtual" in text or "simulador" in text or "digital twin" in text:
        return "Simulação"
    if "veículo" in text or "autônomo" in text or "mobilidade" in text:
        return "Robótica"
    if "monitoramento" in text or "disjuntor" in text or "energia" in text:
        return "Sistemas Inteligentes"
    if "software" in text or "sistema" in text:
        return "Desenvolvimento"
    return "Pesquisa"


def parse_date(raw: str) -> str | None:
    """Converte 'DD/MM/YYYY' para 'YYYY-MM-DD'."""
    raw = raw.strip()
    try:
        return datetime.strptime(raw, "%d/%m/%Y").strftime("%Y-%m-%d")
    except ValueError:
        pass
    match = re.match(r"(\d{4})", raw)
    if match:
        return f"{match.group(1)}-01-01"
    return None


def parse_vigencia(vigencia_raw: str) -> tuple[str | None, str | None]:
    """
    Extrai start_date e end_date de formatos como:
      '11/12/2024 a 11/07/2026'
      '2021–2024 (Concluído)'
      '07/2026 a 06/2028'
    """
    match = re.match(r"(\d{2}/\d{2}/\d{4})\s+a\s+(\d{2}/\d{2}/\d{4})", vigencia_raw)
    if match:
        return parse_date(match.group(1)), parse_date(match.group(2))

    match = re.match(r"(\d{2}/\d{4})\s+a\s+(\d{2}/\d{4})", vigencia_raw)
    if match:
        def my_to_date(s):
            try:
                return datetime.strptime(s, "%m/%Y").strftime("%Y-%m-%d")
            except ValueError:
                return None
        return my_to_date(match.group(1)), my_to_date(match.group(2))

    match = re.match(r"(\d{4})[–\-](\d{4})", vigencia_raw)
    if match:
        return f"{match.group(1)}-01-01", f"{match.group(2)}-12-31"

    return None, None


def parse_md(filepath: str) -> list[dict]:
    """Lê o arquivo .md de projetos e retorna lista de dicts."""
    projects = []
    current_project = None

    with open(filepath, encoding="utf-8") as f:
        lines = f.readlines()

    for line in lines:
        line = line.rstrip()

        proj_match = re.match(r"^###\s+(.+)$", line)
        if proj_match:
            if current_project and current_project.get("name"):
                projects.append(current_project)
            current_project = {
                "name": proj_match.group(1).strip(),
                "description": None,
                "start_date": None,
                "end_date": None,
                "category": None,
                "_partners": None,
            }
            continue

        if current_project is None:
            continue

        field_match = re.match(r"^-\s+\*\*(.+?):\*\*\s*(.*)$", line)
        if field_match:
            key = field_match.group(1).strip().lower()
            value = field_match.group(2).strip()

            if key in ("vigência", "vigencia"):
                start, end = parse_vigencia(value)
                current_project["start_date"] = start
                current_project["end_date"] = end
            elif key in ("parceiros", "parceiro"):
                current_project["_partners"] = value
            elif key in ("descrição", "descricao"):
                current_project["description"] = value

    if current_project and current_project.get("name"):
        projects.append(current_project)

    for p in projects:
        desc = p.get("description") or ""
        partners = p.get("_partners") or ""
        p["category"] = infer_category(desc, partners)
        del p["_partners"]

    return projects


def get_auth_token(base_url: str, email: str, password: str) -> str:
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


def get_all_project_names(base_url: str, token: str) -> set[str]:
    """Busca todos os nomes de projetos cadastrados no Strapi com paginação."""
    headers = {"Authorization": f"Bearer {token}"}
    names: set[str] = set()
    page = 1
    page_size = 100

    while True:
        url = f"{base_url}/api/projects?fields[0]=name&pagination[page]={page}&pagination[pageSize]={page_size}"
        resp = requests.get(url, headers=headers, timeout=15)
        resp.raise_for_status()
        data = resp.json()
        results = data.get("data", [])

        for item in results:
            name = item.get("attributes", {}).get("name") or item.get("name") or ""
            if name:
                names.add(name.strip().lower())

        meta = data.get("meta", {}).get("pagination", {})
        if page >= meta.get("pageCount", 1):
            break
        page += 1

    return names


def create_project(base_url: str, token: str, project: dict) -> dict:
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }
    resp = requests.post(
        f"{base_url}/api/projects",
        headers=headers,
        data=json.dumps({"data": project}),
        timeout=15,
    )
    if not resp.ok:
        print(f"    ❌ Erro {resp.status_code}: {resp.text[:200]}")
        return {}

    created = resp.json().get("data", {})
    project_id = created.get("id") or created.get("documentId")

    if project_id:
        requests.put(
            f"{base_url}/api/projects/{project_id}",
            headers=headers,
            data=json.dumps({"data": {"publishedAt": "now"}}),
            timeout=15,
        )

    return created


def main():
    parser = argparse.ArgumentParser(
        description="Importa projetos do RobSIC para o Strapi via API REST.",
        formatter_class=argparse.RawTextHelpFormatter,
    )
    parser.add_argument("--file", required=True, help="Caminho para o .md com os projetos")
    parser.add_argument("--url", default=os.getenv("STRAPI_URL"), help="URL base do Strapi")
    parser.add_argument("--email", default=os.getenv("STRAPI_EMAIL"), help="E-mail admin")
    parser.add_argument("--password", default=os.getenv("STRAPI_PASSWORD"), help="Senha admin")
    parser.add_argument("--dry-run", action="store_true", help="Simula sem criar nada")
    args = parser.parse_args()

    if not args.dry_run:
        missing = [k for k, v in {"--url": args.url, "--email": args.email, "--password": args.password}.items() if not v]
        if missing:
            print(f"❌ Credenciais faltando: {', '.join(missing)}")
            print("   Configure o arquivo scripts/.env ou passe os argumentos na linha de comando.")
            sys.exit(1)

    print(f"\n📄 Lendo arquivo: {args.file}")
    projects = parse_md(args.file)
    print(f"   → {len(projects)} projetos encontrados.\n")

    if args.dry_run:
        print("🔍 MODO DRY-RUN — Nenhuma alteração será feita no Strapi:\n")
        for p in projects:
            print(f"  • [{p['category']}] {p['name']}")
            print(f"      Vigência: {p['start_date']} → {p['end_date']}")
            if p['description']:
                print(f"      Descrição: {p['description'][:90]}...")
        return

    token = get_auth_token(args.url, args.email, args.password)

    print("\n🔍 Buscando projetos já existentes no Strapi...")
    existing_names = get_all_project_names(args.url, token)
    print(f"   → {len(existing_names)} projetos já cadastrados.\n")

    created_count = 0
    skipped_count = 0
    error_count = 0

    for project in projects:
        name = project["name"]
        print(f"  → [{project['category']}] {name[:60]}...")

        if name.strip().lower() in existing_names:
            print(f"     ⚠️  Já existe no Strapi — pulando para evitar duplicata.")
            skipped_count += 1
            continue

        result = create_project(args.url, token, project)
        if result:
            print(f"     ✅ Criado! (ID: {result.get('id', '?')})")
            created_count += 1
        else:
            error_count += 1

    print(f"\n{'='*50}")
    print(f"✅ Criados:  {created_count}")
    print(f"⏭️  Pulados:  {skipped_count} (já existiam)")
    print(f"❌ Erros:    {error_count}")
    print(f"📋 Total:    {len(projects)}")


if __name__ == "__main__":
    main()
