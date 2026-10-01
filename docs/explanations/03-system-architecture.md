# 🌐 Explicação: Visão Geral da Arquitetura do Sistema RobSIC

> **Finalidade:** Apresentar a visão macro do ecossistema de software do RobSIC, mapeando servidores, protocolos, bancos de dados e fluxo de dados entre os componentes.

---

## 1. Diagrama de Arquitetura da Solução

```mermaid
graph TD
    User["🌐 Usuário Final (Navegador Web)"] -->|HTTPS / Porta 443| Nginx["🛡️ NGINX (Servidor Web & Proxy Reverso)"]
    
    subgraph "Servidor UNIFEI (robsic.unifei.edu.br)"
        Nginx -->|Entrega Arquivos Estáticos| StaticWeb["📦 /var/www/web/<br/>(Flutter Web SPA: HTML/JS/Wasm)"]
        Nginx -->|Proxy Reverso /api e /admin| Strapi["🚀 Strapi CMS v4 (Node.js)<br/>Porta interna 1337"]
        Strapi -->|Armazenamento de Dados| Postgres["🐘 PostgreSQL (Porta 5432)<br/>Banco: robsic"]
        Strapi -->|Uploads de Imagens e Mídia| UploadsDir["📁 public/uploads/"]
    end

    subgraph "Serviços Externos"
        Strapi -->|Tradução Automática i18n| DeepL["🤖 DeepL Translation API"]
        Strapi -->|Envio de Mensagens de Contato| Smtp["📧 Gmail SMTP (robsic@unifei.edu.br)"]
        User -->|Player de Vídeo Modal| YouTube["▶️ YouTube Embed API"]
    end
```

---

## 2. Componentes do Sistema

### 1. NGINX (Servidor de Borda & Reverse Proxy)
- **Localização:** `/etc/nginx/sites-available/` no servidor de produção.
- **Funções:**
  - Terminação SSL/HTTPS com certificados válidos.
  - Servir os arquivos compilados do Flutter Web de `/var/www/web/` com cache headers adequados e suporte a rotas do GoRouter (`try_files $uri $uri/ /index.html;`).
  - Encaminhar requisições das rotas `/api/` e `/admin/` para a instância local do Strapi (Node.js rodando via PM2 ou systemd).

### 2. Frontend — Flutter Web SPA
- **Repositório:** [Robsic/site-robsic](https://github.com/Robsic/site-robsic)
- **Tecnologia:** Dart / Flutter Web compilado em modo CanvasKit / HTML.
- **Comportamento:** É uma Single Page Application (SPA). Uma vez carregada no navegador do usuário, ela consome os dados dinâmicos do Strapi via requisições HTTP REST assíncronas utilizando o cliente `Dio`.

### 3. Backend — Strapi Headless CMS v4
- **Repositório:** [Robsic/strapi-robsic](https://github.com/Robsic/strapi-robsic)
- **Tecnologia:** Node.js (v18 LTS), framework Strapi v4.9.2.
- **Funções:**
  - Painel administrativo intuitivo para docentes e coordenadores cadastrarem membros, fotos, notícias e artigos sem precisar alterar código.
  - API REST com suporte a paginação, filtros, ordenação e publicação imediata (`draftAndPublish`).
  - Internacionalização via `@strapi/plugin-i18n` com tradução assistida pelo provedor DeepL.

### 4. Banco de Dados — PostgreSQL
- Armazena todas as tabelas relacionais de membros, publicações, projetos, permissões de usuários e metadados de arquivos.

### 5. Serviços Externos
- **DeepL API:** Traduz automaticamente textos cadastrados em português para o inglês, economizando tempo dos pesquisadores.
- **Gmail SMTP:** Roteia as mensagens preenchidas no formulário de contato do site diretamente para a caixa de entrada institucional `robsic@unifei.edu.br`.
