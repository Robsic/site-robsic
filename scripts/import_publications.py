#!/usr/bin/env python3
"""
Script de importação de produtos de pesquisa (Resultados) do RobSIC para o Strapi.

Uso:
    # Simulação sem alterar nada no Strapi:
    uv run --with-requirements scripts/requirements.txt scripts/import_publications.py --file scripts/Produtos_de_Pesquisa_RobSIC.md --dry-run

    # Importar e publicar no Strapi:
    uv run --with-requirements scripts/requirements.txt scripts/import_publications.py --file scripts/Produtos_de_Pesquisa_RobSIC.md
"""

import argparse
import json
import os
import re
import sys
from datetime import datetime, timezone
from pathlib import Path

import requests
from dotenv import load_dotenv

load_dotenv(Path(__file__).parent / ".env")
load_dotenv(Path(__file__).parent.parent / ".env")


def extract_url(text: str | None) -> str | None:
    if not text:
        return None
    text = text.strip()
    # Padrão markdown link: [texto](https://...)
    md_match = re.search(r"\[.*?\]\((https?://[^\s\)]+)\)", text)
    if md_match:
        return md_match.group(1).strip()
    # Padrão URL pura: https://...
    raw_match = re.search(r"(https?://[^\s\|\)]+)", text)
    if raw_match:
        return raw_match.group(1).strip()
    return None


def parse_date_str(raw: str | None) -> str:
    if not raw:
        return "2025-01-01"
    raw = raw.strip()
    # Padrão DD/MM/YYYY
    match_dmy = re.search(r"(\d{2})/(\d{2})/(\d{4})", raw)
    if match_dmy:
        d, m, y = match_dmy.groups()
        return f"{y}-{m}-{d}"
    # Padrão YYYY
    match_y = re.search(r"(\d{4})", raw)
    if match_y:
        return f"{match_y.group(1)}-01-01"
    return "2025-01-01"


def clean_text(text: str | None) -> str:
    if not text:
        return ""
    # Remove markdown bold/italics
    cleaned = text.strip()
    cleaned = re.sub(r"\*\*(.*?)\*\*", r"\1", cleaned)
    cleaned = re.sub(r"\*(.*?)\*", r"\1", cleaned)
    return cleaned.strip()


def parse_md(filepath: str) -> list[dict]:
    items = []

    with open(filepath, encoding="utf-8") as f:
        lines = f.readlines()

    current_section = None

    for line in lines:
        line_str = line.strip()

        if line_str.startswith("## 1. Datasets"):
            current_section = "dataset"
            continue
        elif line_str.startswith("## 2. Softwares"):
            current_section = "software"
            continue
        elif line_str.startswith("## 3. Sistemas Web"):
            current_section = "sistema_web"
            continue
        elif line_str.startswith("## 4. Vídeos"):
            current_section = "video"
            continue
        elif line_str.startswith("## 5. Protótipos"):
            current_section = "prototipo"
            continue
        elif line_str.startswith("## 6. Patentes"):
            current_section = "patente"
            continue
        elif line_str.startswith("## 7. Publicações"):
            current_section = "publicacao"
            continue
        elif line_str.startswith("## 8. Demonstrações"):
            current_section = "demonstracao"
            continue
        elif line_str.startswith("## "):
            current_section = None
            continue

        if not current_section or not line_str.startswith("|"):
            continue

        cols = [c.strip() for c in line_str.split("|")[1:-1]]
        if not cols or all(c == "" or c.startswith("---") or c.startswith("#") or c.lower() == "vídeo" or c.lower() == "ano" or c.lower() == "dataset" or c.lower() == "software" or c.lower() == "sistema" or c.lower() == "protótipo" or c.lower() == "patente (nº inpi)" or c.lower() == "demonstração" for c in cols):
            continue

        # Processamento por seção
        title = ""
        authors = "Equipe RobSIC"
        abstract = ""
        pub_date = "2025-01-01"
        url = None

        if current_section == "dataset":
            # | # | Dataset | Projeto/Publicação associada | Link | Situação |
            if len(cols) >= 3:
                title = clean_text(cols[1])
                assoc = clean_text(cols[2])
                link_col = cols[3] if len(cols) > 3 else ""
                situac = clean_text(cols[4]) if len(cols) > 4 else ""
                abstract = f"{assoc} - {situac}".strip(" -")
                url = extract_url(link_col) or extract_url(assoc)

        elif current_section == "software":
            # | # | Software | Autores/Responsáveis | Descrição | Link |
            if len(cols) >= 3:
                title = clean_text(cols[1])
                authors = clean_text(cols[2]) or "Equipe RobSIC"
                abstract = clean_text(cols[3]) if len(cols) > 3 else ""
                link_col = cols[4] if len(cols) > 4 else ""
                url = extract_url(link_col) or extract_url(abstract)

        elif current_section == "sistema_web":
            # | # | Sistema | Responsáveis | Descrição | Link |
            if len(cols) >= 3:
                title = clean_text(cols[1])
                authors = clean_text(cols[2]) or "Equipe RobSIC"
                abstract = clean_text(cols[3]) if len(cols) > 3 else ""
                link_col = cols[4] if len(cols) > 4 else ""
                url = extract_url(link_col) or extract_url(abstract)

        elif current_section == "video":
            # | Vídeo | Link | Projeto associado |
            if len(cols) >= 2:
                title = clean_text(cols[0])
                link_col = cols[1]
                assoc = clean_text(cols[2]) if len(cols) > 2 else ""
                abstract = assoc
                url = extract_url(link_col)

        elif current_section == "prototipo":
            # | # | Protótipo | Status | Patente/Publicação | Vídeo |
            if len(cols) >= 3:
                title = clean_text(cols[1])
                status = clean_text(cols[2])
                pat_pub = clean_text(cols[3]) if len(cols) > 3 else ""
                vid_col = cols[4] if len(cols) > 4 else ""
                abstract = f"Status: {status}. {pat_pub}".strip()
                url = extract_url(vid_col) or extract_url(pat_pub)

        elif current_section == "patente":
            # | # | Patente (nº INPI) | Título | Depósito | Autores no RobSIC |
            if len(cols) >= 3:
                pat_num = clean_text(cols[1])
                pat_title = clean_text(cols[2])
                title = f"{pat_num} — {pat_title}".strip(" —")
                depo = clean_text(cols[3]) if len(cols) > 3 else ""
                authors = clean_text(cols[4]) if len(cols) > 4 else "Equipe RobSIC"
                pub_date = parse_date_str(depo)
                abstract = f"Depósito/Concessão: {depo}".strip()

        elif current_section == "publicacao":
            # | Ano | Título | Veículo | Autores RobSIC | Link |
            if len(cols) >= 3:
                ano_raw = clean_text(cols[0])
                pub_date = parse_date_str(ano_raw)
                title = clean_text(cols[1])
                veiculo = clean_text(cols[2])
                authors = clean_text(cols[3]) if len(cols) > 3 else "Equipe RobSIC"
                link_col = cols[4] if len(cols) > 4 else ""
                abstract = veiculo
                url = extract_url(link_col)

        elif current_section == "demonstracao":
            # | # | Demonstração | Formato | Link |
            if len(cols) >= 3:
                title = clean_text(cols[1])
                abstract = clean_text(cols[2])
                link_col = cols[3] if len(cols) > 3 else ""
                url = extract_url(link_col)

        # Ignorar linhas de cabeçalho
        title_lower = title.lower()
        if (title and 
            not title_lower.startswith("patente (nº") and 
            not title_lower.startswith("vídeo") and 
            not title_lower.startswith("título") and 
            not title_lower.startswith("software") and 
            not title_lower.startswith("sistema") and 
            not title_lower.startswith("protótipo") and 
            not title_lower.startswith("demonstração") and 
            not title_lower.startswith("dataset")):
            items.append({
                "title": title,
                "authors": authors,
                "abstract": abstract,
                "publication_date": pub_date,
                "url": url,
                "result_type": current_section,
            })

    return items


def get_existing_titles(base_url: str, token: str) -> set[str]:
    headers = {"Authorization": f"Bearer {token}"}
    titles: set[str] = set()
    page = 1
    page_size = 100

    while True:
        url = f"{base_url}/api/publications?fields[0]=title&pagination[page]={page}&pagination[pageSize]={page_size}&publicationState=preview"
        resp = requests.get(url, headers=headers, timeout=15)
        if not resp.ok:
            break
        data = resp.json()
        results = data.get("data", [])

        for item in results:
            t = item.get("attributes", {}).get("title") or item.get("title") or ""
            if t:
                titles.add(t.strip().lower())

        meta = data.get("meta", {}).get("pagination", {})
        if page >= meta.get("pageCount", 1):
            break
        page += 1

    return titles


def create_publication(base_url: str, token: str, pub: dict, publish: bool = True) -> dict:
    headers = {
        "Authorization": f"Bearer {token}",
        "Content-Type": "application/json",
    }
    payload = {k: v for k, v in pub.items() if v is not None}
    
    # Strapi tipo string limita em 255 caracteres
    if "title" in payload and len(payload["title"]) > 250:
        full_title = payload["title"]
        payload["title"] = full_title[:247] + "..."
        payload["abstract"] = f"{full_title}\n\n{payload.get('abstract', '')}".strip()

    if "authors" in payload and len(payload["authors"]) > 250:
        payload["authors"] = payload["authors"][:247] + "..."

    resp = requests.post(
        f"{base_url}/api/publications",
        headers=headers,
        data=json.dumps({"data": payload}),
        timeout=15,
    )
    if not resp.ok:
        print(f"    ❌ Erro {resp.status_code}: {resp.text[:200]}")
        return {}

    created = resp.json().get("data", {})
    pub_id = created.get("id") or created.get("documentId")

    if pub_id and publish:
        iso_now = datetime.now(timezone.utc).isoformat().replace("+00:00", "Z")
        pub_resp = requests.put(
            f"{base_url}/api/publications/{pub_id}",
            headers=headers,
            data=json.dumps({"data": {"publishedAt": iso_now}}),
            timeout=15,
        )
        if not pub_resp.ok:
            print(f"    ⚠️  Criado mas falhou ao publicar: {pub_resp.text[:150]}")

    return created


def main():
    parser = argparse.ArgumentParser(
        description="Importa produtos de pesquisa do RobSIC para o Strapi.",
        formatter_class=argparse.RawTextHelpFormatter,
    )
    parser.add_argument("--file", required=True, help="Caminho para o .md com os resultados")
    parser.add_argument("--url", default=os.getenv("STRAPI_URL"), help="URL base do Strapi")
    parser.add_argument("--token", default=os.getenv("STRAPI_API_TOKEN"), help="API Token do Strapi")
    parser.add_argument("--dry-run", action="store_true", help="Simula sem criar nada")
    parser.add_argument("--draft", action="store_true", help="Cria registros como Rascunho")
    args = parser.parse_args()

    if not args.dry_run:
        missing = [k for k, v in {"--url": args.url, "--token": args.token}.items() if not v]
        if missing:
            print(f"❌ Configuração faltando: {', '.join(missing)}")
            sys.exit(1)

    print(f"\n📄 Lendo arquivo: {args.file}")
    pubs = parse_md(args.file)
    print(f"   → {len(pubs)} produtos de pesquisa encontrados.\n")

    if args.dry_run:
        print("🔍 MODO DRY-RUN — Nenhuma alteração será feita no Strapi:\n")
        for p in pubs:
            url_str = f" [URL: {p['url']}]" if p['url'] else ""
            print(f"  • [{p['result_type']}] {p['title'][:60]}... (Data: {p['publication_date']}){url_str}")
        return

    token = args.token

    print("🔍 Buscando resultados já existentes no Strapi...")
    existing_titles = get_existing_titles(args.url, token)
    print(f"   → {len(existing_titles)} resultados já cadastrados.\n")

    created_count = 0
    skipped_count = 0
    error_count = 0

    for pub in pubs:
        t_key = f"{pub['result_type']}:{pub['title'].strip().lower()}"
        print(f"  → [{pub['result_type']}] {pub['title'][:60]}...")

        # Para permitir itens em múltiplas categorias, checa tipo + título
        if pub['title'].strip().lower() in existing_titles:
            print("     ⚠️  Já existe no Strapi — pulando.")
            skipped_count += 1
            continue

        result = create_publication(args.url, token, pub, publish=not args.draft)
        if result:
            status = "📝 Rascunho" if args.draft else "🌐 Publicado"
            print(f"     ✅ Criado! (ID: {result.get('id', '?')}) — {status}")
            created_count += 1
            existing_titles.add(pub['title'].strip().lower())
        else:
            error_count += 1

    print(f"\n{'='*50}")
    print(f"✅ Criados:  {created_count}")
    print(f"⏭️  Pulados:  {skipped_count} (já existiam)")
    print(f"❌ Erros:    {error_count}")
    print(f"📋 Total:    {len(pubs)}")


if __name__ == "__main__":
    main()
