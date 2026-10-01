# 🔌 Referência: Endpoints da API Strapi Consumidos pelo Frontend

> **Finalidade:** Especificação dos endpoints REST fornecidos pelo Strapi CMS e consumidos pelo cliente HTTP Dio no Flutter Web.

---

## 1. Padrões de Requisição

Todas as requisições utilizam a URL base definida por `--dart-define=BASE_URL`.

### Parâmetros Globais Utilizados:
- **`populate=*`**: Inclui mídias anexadas (imagens, fotos dos membros, capas de projetos) e componentes aninhados.
- **`locale=<código>`**: Define o idioma do conteúdo (`pt-BR` ou `en`).
- **`pagination[pageSize]=<limite>`**: Define a quantidade máxima de itens retornados por página (padrão utilizado: `pageSize=500` para evitar truncamento em listas completas).
- **`sort[0]=<campo>:<ordem>`**: Ordenação de resultados (ex: `sort[0]=createdAt:desc`).

---

## 2. Tabela de Endpoints

| Método | Endpoint | Módulo Frontend | Descrição |
|---|---|---|---|
| `GET` | `/api/home-page?populate=*` | `home` | Textos da seção inicial, banners e destaques da Landing Page |
| `GET` | `/api/about-page?populate=*` | `about` | História do laboratório, missão, visão e infraestrutura |
| `GET` | `/api/contact-page?populate=*` | `contact` | Informações de contato, endereço e dados do rodapé |
| `GET` | `/api/members-page?populate=*` | `members` | Título e textos de cabeçalho da página de membros |
| `GET` | `/api/members?populate=*&pagination[pageSize]=500` | `members` | Lista completa de integrantes com fotos, cargos e links |
| `GET` | `/api/projects-page?populate=*` | `projects` | Textos institucionais da página de projetos |
| `GET` | `/api/projects?populate=*&pagination[pageSize]=500` | `projects` | Lista de projetos de P&D (título, descrição, foto, status) |
| `GET` | `/api/publications-page?populate=*` | `publications` | Cabeçalho e filtros da página de resultados e publicações |
| `GET` | `/api/publications?populate=*&pagination[pageSize]=500` | `publications` | Artigos, patentes, sistemas web, softwares e vídeos |
| `POST` | `/api/send-email` | `contact` | Envio de formulário de contato via email |

---

## 3. Estrutura de Retorno do Strapi v4

O Strapi v4 encapsula os dados em um objeto `data` contendo `id` e `attributes`:

### Exemplo de Resposta de Item Único:
```json
{
  "data": {
    "id": 1,
    "attributes": {
      "name": "Laboratório RobSIC",
      "description": "Texto institucional...",
      "createdAt": "2026-07-10T12:00:00.000Z",
      "updatedAt": "2026-08-01T15:30:00.000Z",
      "publishedAt": "2026-08-01T15:30:00.000Z",
      "locale": "pt-BR"
    }
  },
  "meta": {}
}
```

### Exemplo de Resposta de Coleção (Lista):
```json
{
  "data": [
    {
      "id": 70,
      "attributes": {
        "name": "André Ribeiro de Brito",
        "role": "Pesquisador",
        "email": "andre.brito@unifei.edu.br",
        "lattes": "http://lattes.cnpq.br/8676076486184629",
        "orcid": "https://orcid.org/0000-0002-8843-5388",
        "linkedin": "https://www.linkedin.com/in/andrerb1992/",
        "photo": {
          "data": null
        }
      }
    }
  ],
  "meta": {
    "pagination": {
      "page": 1,
      "pageSize": 500,
      "pageCount": 1,
      "total": 36
    }
  }
}
```

No frontend, a conversão dessa estrutura para a `MemberEntity` é feita de forma pura e segura pelo `MemberAdapter` em `lib/src/modules/members/infra/adapters/member_adapter.dart`.
