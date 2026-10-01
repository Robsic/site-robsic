# ⚙️ Referência: Variáveis de Ambiente e Flags de Configuração

> **Finalidade:** Especificação completa de todas as variáveis de ambiente, chaves e parâmetros de compilação utilizados no frontend, nos scripts de automação e no backend Strapi.

---

## 1. Frontend Flutter Web (`--dart-define`)

No Flutter Web, as variáveis de ambiente são passadas durante a compilação utilizando a flag `--dart-define`:

| Parâmetro | Tipo | Padrão | Descrição | Exemplo de Uso |
|---|---|---|---|---|
| `BASE_URL` | String | `http://localhost:1337` | URL base da API do Strapi CMS | `--dart-define=BASE_URL=https://robsic.unifei.edu.br` |

### Como é lido no código:
```dart
const baseUrl = String.fromEnvironment(
  'BASE_URL',
  defaultValue: 'http://localhost:1337',
);
```

---

## 2. Scripts de Automação Python (`scripts/.env`)

Utilizados pelos scripts `import_members.py`, `import_projects.py` e `import_publications.py`:

| Variável | Obrigatória? | Descrição | Exemplo |
|---|---|---|---|
| `STRAPI_URL` | Sim | URL pública ou local do Strapi | `https://robsic.unifei.edu.br` |
| `STRAPI_API_TOKEN` | Sim | Token de acesso da API REST com permissões de leitura e escrita | `75320af61e826f81...` |

---

## 3. Backend Strapi CMS (`.env`)

Utilizadas pela aplicação Node.js do Strapi:

### Configurações de Servidor
| Variável | Descrição | Exemplo Padrão |
|---|---|---|
| `HOST` | Interface de rede para bind | `0.0.0.0` |
| `PORT` | Porta HTTP interna da aplicação | `1337` |
| `NODE_ENV` | Modo de execução (`development` ou `production`) | `production` |

### Chaves Criptográficas e Segurança
| Variável | Descrição |
|---|---|
| `APP_KEYS` | Array de chaves em base64 para assinatura de cookies e sessões |
| `API_TOKEN_SALT` | Salt criptográfico para hashes de tokens de API |
| `ADMIN_JWT_SECRET` | Chave secreta para autenticação de administradores |
| `JWT_SECRET` | Chave secreta para autenticação de usuários da API |
| `TRANSFER_TOKEN_SALT`| Salt para tokens de transferência de dados (Strapi Data Transfer) |

### Banco de Dados (PostgreSQL)
| Variável | Descrição | Exemplo em Produção |
|---|---|---|
| `DATABASE_HOST` | Host do banco de dados | `127.0.0.1` |
| `DATABASE_PORT` | Porta do PostgreSQL | `5432` |
| `DATABASE_NAME` | Nome da base de dados | `robsic` |
| `DATABASE_USERNAME` | Usuário do banco | `robotica` |
| `DATABASE_PASSWORD` | Senha do banco | *(segredo)* |
| `DATABASE_SSL` | Habilitar conexão criptografada SSL | `false` |

### Email e Serviços de Terceiros
| Variável | Descrição | Exemplo |
|---|---|---|
| `SMTP_HOST` | Servidor SMTP para disparo de mensagens | `smtp.gmail.com` |
| `SMTP_PORT` | Porta do servidor SMTP | `587` |
| `SMTP_USERNAME` | Conta de email de envio | `robsic@unifei.edu.br` |
| `SMTP_PASSWORD` | Senha de aplicativo (App Password) do Google | *(segredo)* |
| `DEEPL_API_KEY` | Chave da API do DeepL para tradução automática i18n | `xxxx-xxxx-xxxx-xxxx:fx` |
