# 📚 Documentação Técnica — Site RobSIC

Bem-vindo à documentação oficial do **Site RobSIC**!

Esta documentação é organizada segundo o **Framework Diátaxis**, uma arquitetura cognitiva para documentação técnica estruturada em **quatro quadrantes**, separando claramente as necessidades do leitor entre **aprender**, **fazer**, **entender** e **consultar**.

---

## 🧭 Mapa de Navegação Diátaxis

```
                          ESTUDO (Teórico)
                                 │
                 ┌───────────────┼───────────────┐
                 │               │               │
                 │   TUTORIAIS   │  EXPLICAÇÕES  │
                 │  (Aprender)   │  (Entender)   │
                 │               │               │
PRÁTICA (Ação) ──┼───────────────┼───────────────┼── CONCEITO (Reflexão)
                 │               │               │
                 │     GUIAS     │  REFERÊNCIAS  │
                 │    PRÁTICOS   │  (Consultar)  │
                 │    (Fazer)    │               │
                 │               │               │
                 └───────────────┼───────────────┘
                                 │
                          TRABALHO (Aplicado)
```

---

### 1. 🎓 Tutoriais (Orientados a Aprendizado)
*Para quem está começando agora e quer ver a aplicação funcionando pela primeira vez:*
- [01. Primeiros Passos e Execução Local](tutorials/01-getting-started.md) — Clone o repositório, configure o Flutter Web e execute localmente.
- [02. Primeira Contribuição e Fluxo Git](tutorials/02-first-contribution.md) — Modelo de branches, padronização de Conventional Commits e Pull Requests.

---

### 2. 🛠️ Guias Práticos / How-To (Orientados a Resolução de Problemas)
*Passo a passo direto ao ponto para tarefas frequentes da rotina de desenvolvimento:*
- [01. Deploy Manual em Produção](how-to-guides/01-manual-deployment.md) — Compilação, compactação e publicação no servidor Apache via SSH/SCP.
- [02. Automação e Importação de Dados](how-to-guides/02-data-import-scripts.md) — Scripts Python para cadastrar membros (via Google Forms/CSV), publicações e projetos no Strapi.
- [03. Internacionalização (i18n)](how-to-guides/03-internationalization.md) — Como adicionar novas strings de tradução (PT/EN) no frontend e Strapi.

---

### 3. 🏛️ Explicações (Orientadas a Entendimento e Arquitetura)
*Discussões aprofundadas sobre as decisões técnicas, design de software e arquitetura:*
- [01. Arquitetura Clean Dart](explanations/01-clean-dart-architecture.md) — Camadas Domain, Infra, External e Presentation, princípios S.O.L.I.D. e desacoplamento.
- [02. Gerenciamento de Estado, DI e Result](explanations/02-state-management-and-di.md) — Reatividade com Stores/ValueNotifier, GetIt Service Locator e programação funcional com `result_dart`.
- [03. Arquitetura Geral do Sistema](explanations/03-system-architecture.md) — Diagrama do ecossistema: Apache2, Flutter Web, Strapi CMS v4, PostgreSQL e serviços externos.

---

### 4. 📖 Referências (Orientadas a Informação Precisa)
*Tabelas, especificações técnicas, contratos de API e variáveis de ambiente:*
- [01. Estrutura de Diretórios e Módulos](reference/01-directory-structure.md) — Mapeamento detalhado de pastas e responsabilidades de cada componente.
- [02. Variáveis de Ambiente e Flags](reference/02-environment-variables.md) — Especificação completa de `--dart-define`, `.env` do Strapi e variáveis dos scripts.
- [03. Endpoints da API Strapi](reference/03-strapi-api-endpoints.md) — Tabela com todas as rotas consumidas pelo frontend, parâmetros e formatos de resposta.
