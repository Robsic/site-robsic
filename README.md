# 🤖 RobSIC — Portal Web Institucional

[![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Architecture](https://img.shields.io/badge/Architecture-Clean%20Dart-green)](https://github.com/Flutterando/Clean-Dart)
[![Documentation](https://img.shields.io/badge/Docs-Di%C3%A1taxis%20Framework-blueviolet)](docs/README.md)
[![Organization](https://img.shields.io/badge/Org-RobSIC%20UNIFEI-red)](https://github.com/Robsic)

Portal web oficial do **Laboratório de Robótica, Sistemas Inteligentes e Complexos (RobSIC)** da **Universidade Federal de Itajubá (UNIFEI) — Campus Itabira**.

🌐 **Acesse em Produção:** [https://robsic.unifei.edu.br](https://robsic.unifei.edu.br)

---

## 📑 Índice

- [Visão Geral](#-visão-geral)
- [Funcionalidades Principais](#-funcionalidades-principais)
- [Stack Tecnológica](#-stack-tecnológica)
- [Início Rápido](#-início-rápido)
- [Documentação Técnica (Framework Diátaxis)](#-documentação-técnica-framework-diátaxis)
- [Fluxo de Desenvolvimento e Contribuição](#-fluxo-de-desenvolvimento-e-contribuição)
- [Licença e Contato](#-licença-e-contato)

---

## 🔭 Visão Geral

O site atua como a vitrine digital do laboratório, com os objetivos de:
- Consolidar a presença digital e a identidade do grupo de pesquisa.
- Catalogar e dar visibilidade aos resultados científicos (artigos, patentes, sistemas web, softwares e vídeos de experimentos).
- Apresentar o corpo de pesquisadores, docentes, mestrandos e bolsistas do grupo.
- Facilitar a captação de novas parcerias com a indústria, instituições de fomento e comunidade acadêmica.

---

## ✨ Funcionalidades Principais

- **🏠 Landing Page Interativa:** Apresentação visual moderna do laboratório, objetivos e destaques.
- **👥 Equipe & Membros:** Listagem de pesquisadores organizada por categorias acadêmicas (Docentes, Doutorandos, Mestrandos e Bolsistas) com links diretos para Lattes, ORCID e LinkedIn.
- **🔬 Resultados & Publicações:** Catálogo dinâmico de produção científica com player modal integrado para vídeos do YouTube, agrupamento por playlists temáticas e filtros de busca.
- **🚀 Projetos de P&D:** Galeria dos projetos desenvolvidos pela equipe com fotos e resumos executivos.
- **✉️ Canal de Contato:** Formulário com envio de email direto via SMTP institucional.
- **🌐 Internacionalização (i18n):** Suporte nativo a Português (`pt-BR`) e Inglês (`en-US`) com sincronização em tempo real.

---

## 🛠️ Stack Tecnológica

| Componente | Tecnologia | Papel |
|---|---|---|
| **Frontend** | Flutter Web / Dart | Single Page Application (SPA) responsiva |
| **Backend** | Strapi CMS v4 (Node.js) | Headless CMS para gestão dinâmica de conteúdo |
| **Banco de Dados** | PostgreSQL | Persistência relacional em produção |
| **Servidor Web** | NGINX | Servidor de borda, terminação SSL e reverse proxy |
| **Automação** | Python 3.10+ | Scripts de sincronização em lote com o Strapi |

---

## ⚡ Início Rápido

### 1. Clonar e Instalar Dependências
```bash
git clone git@github.com:Robsic/site-robsic.git
cd site-robsic
flutter pub get
```

### 2. Executar Localmente
```bash
flutter run -d chrome --dart-define=BASE_URL=https://robsic.unifei.edu.br
```

Para instruções passo a passo detalhadas, veja o [Tutorial de Primeiros Passos](docs/tutorials/01-getting-started.md).

---

## 📚 Documentação Técnica (Framework Diátaxis)

A documentação do projeto está estruturada seguindo o **Framework Diátaxis** em quatro quadrantes cognitivos:

| Quadrante | Propósito | Principais Guias |
|---|---|---|
| 🎓 **[Tutoriais](docs/tutorials/)** | *Aprender* | • [Primeiros Passos](docs/tutorials/01-getting-started.md)<br/>• [Primeira Contribuição e Git](docs/tutorials/02-first-contribution.md) |
| 🛠️ **[Guias Práticos](docs/how-to-guides/)** | *Fazer* | • [Deploy em Produção (SSH/NGINX)](docs/how-to-guides/01-manual-deployment.md)<br/>• [Importação de Dados via Python](docs/how-to-guides/02-data-import-scripts.md)<br/>• [Internacionalização (i18n)](docs/how-to-guides/03-internationalization.md) |
| 🏛️ **[Explicações](docs/explanations/)** | *Entender* | • [Arquitetura Clean Dart](docs/explanations/01-clean-dart-architecture.md)<br/>• [Gerenciamento de Estado e DI](docs/explanations/02-state-management-and-di.md)<br/>• [Arquitetura Geral do Sistema](docs/explanations/03-system-architecture.md) |
| 📖 **[Referências](docs/reference/)** | *Consultar* | • [Estrutura de Pastas e Módulos](docs/reference/01-directory-structure.md)<br/>• [Variáveis de Ambiente e Flags](docs/reference/02-environment-variables.md)<br/>• [Endpoints da API Strapi](docs/reference/03-strapi-api-endpoints.md) |

Consulte o [Portal Central de Documentação](docs/README.md) para navegar por todo o acervo.

---

## 🌿 Fluxo de Desenvolvimento e Contribuição

Adotamos a especificação **Conventional Commits** e branches baseadas na `development`:

```
main (produção)  ◄──  development (integração)  ◄──  feature/* ou bugfix/*
```

### Regras de Ouro:
1. Trabalhe sempre a partir da branch `development`.
2. Escreva commits descritivos no formato: `feat: adiciona card de resultados`, `fix: corrige alinhamento do rodapé`.
3. Garanta que a suíte passe antes de abrir o Pull Request:
   ```bash
   flutter analyze
   flutter test
   ```

---

## 📄 Licença e Contato

- **Organização:** [RobSIC — Laboratório de Robótica, Sistemas Inteligentes e Complexos](https://github.com/Robsic)
- **Instituição:** Universidade Federal de Itajubá (UNIFEI) — Campus Itabira
- **Contato:** `robsic@unifei.edu.br`