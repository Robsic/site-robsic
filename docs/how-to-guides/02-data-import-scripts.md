# 🐍 Guia Prático: Automação e Importação de Dados via Scripts Python

> **Finalidade:** Instruções para cadastrar e sincronizar em lote Membros, Projetos e Publicações/Resultados no Strapi CMS utilizando os utilitários Python do projeto.
> **Localização dos scripts:** Diretório `scripts/` na raiz do projeto.

---

## 1. Configuração Inicial do Ambiente

Os scripts requerem Python 3.10+ e bibliotecas declaradas em `scripts/requirements.txt` (`requests`, `python-dotenv`).

1. Acesse o diretório `scripts/`:
   ```bash
   cd scripts
   ```
2. Crie e ative um ambiente virtual:
   ```bash
   python3 -m venv .venv
   source .venv/bin/activate
   pip install -r requirements.txt
   ```
3. Crie seu arquivo `scripts/.env` baseado no exemplo `scripts/.env.example`:
   ```env
   STRAPI_URL=https://robsic.unifei.edu.br
   STRAPI_API_TOKEN=seu_token_aqui
   ```

### Como gerar um API Token no Strapi:
1. Acesse o painel administrativo: [https://robsic.unifei.edu.br/admin](https://robsic.unifei.edu.br/admin)
2. No menu lateral, navegue até **Settings** → **API Tokens**.
3. Clique em **Create new API Token**.
4. Configure:
   - **Name:** `Import Scripts CLI`
   - **Token duration:** Unlimited
   - **Token type:** **Full Access**
5. Copie o token gerado e cole no seu `scripts/.env`.

---

## 2. Importação de Membros (`import_members.py`)

O script oferece suporte a:
- **Planilhas CSV** exportadas do Google Forms / Google Sheets de cadastro de novos membros.
- Arquivos de texto formatados em **Markdown (`.md`)**.
- **Prevenção inteligente de duplicatas:** verifica nomes já cadastrados no Strapi (inclusive rascunhos) antes de criar novos registros.

### Casos de Uso Comuns:

#### 1. Simulação sem alterar nada (Dry-Run):
Sempre rode primeiro em modo `--dry-run` para auditar os dados que serão enviados:
```bash
python import_members.py --file ~/Downloads/membros.csv --dry-run
```

#### 2. Importação oficial (Publicando imediatamente no site):
```bash
python import_members.py --file ~/Downloads/membros.csv
```

#### 3. Importação como Rascunho (Draft):
Se você preferir revisar os dados pelo painel do Strapi antes de torná-los visíveis ao público:
```bash
python import_members.py --file ~/Downloads/membros.csv --draft
```

#### 4. Definir cargo padrão quando a planilha não tiver coluna de cargo:
```bash
python import_members.py --file ~/Downloads/membros.csv --default-role "Bolsista"
```

---

## 3. Importação de Publicações e Resultados (`import_publications.py`)

Importa artigos científicos, patentes, produtos de software, sistemas web e vídeos do YouTube a partir de arquivos Markdown estruturados (ex: `Produtos_de_Pesquisa_RobSIC.md`).

### Tipos de Resultados Suportados:
- **`article`**: Artigos em periódicos e anais de conferências científicas.
- **`patent`**: Depósitos de patentes de invenção e registros de programa de computador.
- **`video`**: Demonstrações experimentais e vídeos do canal do YouTube com player modal.
- **`software` / `web_system`**: Softwares desenvolvidos pelo laboratório e links para repositórios.

### Comandos:
```bash
# Simulação dos dados:
python import_publications.py --file scripts/Produtos_de_Pesquisa_RobSIC.md --dry-run

# Importação e publicação:
python import_publications.py --file scripts/Produtos_de_Pesquisa_RobSIC.md
```

---

## 4. Importação de Projetos (`import_projects.py`)

Importa os projetos de pesquisa e desenvolvimento (P&D) do laboratório:

```bash
python import_projects.py --file scripts/projetos.md
```

---

## 5. Boas Práticas e Resolução de Problemas

- **Campos nulos ou incompletos:** O script automaticamente descarta chaves com valores vazios para não disparar erros de validação do Strapi.
- **Erro 401 / 403 (Unauthorized / Forbidden):** Verifique se o `STRAPI_API_TOKEN` no arquivo `.env` possui permissões de **Full Access** e se o token não expirou.
- **Erro de Conexão:** Confirme se a URL `https://robsic.unifei.edu.br` está acessível em sua rede.
