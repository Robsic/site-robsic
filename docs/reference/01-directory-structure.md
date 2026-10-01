# 📁 Referência: Estrutura de Diretórios e Módulos do Frontend

> **Finalidade:** Mapeamento técnico detalhado de todas as pastas e arquivos do repositório `site-robsic`.

---

## 1. Visão Geral da Raiz

```
site-robsic/
├── .github/              ← Workflows de CI/CD do GitHub Actions
├── assets/               ← Imagens estáticas, logotipos e fontes tipográficas
├── docs/                 ← Documentação técnica viva (Framework Diátaxis)
│   ├── tutorials/        ← Guias orientados a aprendizado (Passo a passo inicial)
│   ├── how-to-guides/    ← Guias práticos para tarefas específicas
│   ├── explanations/     ← Explicações arquiteturais e conceituais
│   └── reference/        ← Tabelas, especificações e referências técnicas
├── lib/                  ← Código-fonte em Dart/Flutter
│   ├── l10n/             ← Arquivos de tradução (.arb) e classes geradas
│   ├── main.dart         ← Ponto de entrada (Entrypoint) da aplicação
│   └── src/              ← Código modularizado da aplicação
├── scripts/              ← Utilitários Python para importação de dados no Strapi
├── test/                 ← Suíte de testes unitários e de integração
├── pubspec.yaml          ← Declaração de dependências e assets
└── analysis_options.yaml ← Regras de lint estático (flutter_lints)
```

---

## 2. Estrutura Interna de `lib/src/`

```
lib/src/
├── app.dart              ← Configuração do MaterialApp.router e tema visual
├── app_store.dart        ← Store global de idioma (AppLocale: ptBR, enUS)
│
├── modules/              ← Features de negócio da aplicação
│   ├── core/             ← Módulo base compartilhado (layouts, menus, erros)
│   ├── home/             ← Landing Page inicial com destaques
│   ├── about/            ← Página institucional sobre o laboratório RobSIC
│   ├── members/          ← Lista de integrantes (docentes, bolsistas, alunos)
│   ├── publications/     ← Publicações científicas, patentes, vídeos e resultados
│   ├── projects/         ← Projetos de P&D desenvolvidos pelo grupo
│   └── contact/          ← Formulário de envio de mensagem / contato
│
└── resources/            ← Design System e utilitários transversais
    ├── constants/        ← Cores, dimensões, rotas e URLs de endpoints
    ├── factories/        ← Configuração do cliente HTTP Dio e injeção de dependência
    ├── ui/               ← Componentes atômicos do Design System
    │   ├── atoms/        ← Componentes indivisíveis (textos, botões, ícones, badges)
    │   ├── molecules/    ← Agrupamento de átomos (itens de menu, cards compactos)
    │   ├── organisms/    ← Estruturas completas (AppBar, Drawer, Rodapé, Header)
    │   ├── templates/    ← Layouts de página reaproveitáveis
    │   └── tokens/       ← Design tokens (paleta de cores, tipografia, espaçamentos)
    └── utils/            ← Utilitários de responsividade, validação e regex
```

---

## 3. Padrão Interno de Cada Módulo

Todo módulo dentro de `lib/src/modules/<nome>/` segue rigorosamente a divisão em 4 camadas Clean Dart:

```
<modulo>/
├── domain/
│   ├── entities/          ← Entidades imutáveis do negócio
│   ├── repositories/      ← Interfaces abstratas de acesso a dados
│   └── usecases/          ← Regras de negócio encapsuladas em classes executáveis
│
├── infra/
│   ├── adapters/          ← Conversores JSON ↔ Entity
│   ├── datasources/       ← Interfaces abstratas dos datasources
│   └── repositories/      ← Implementações concretas das interfaces de repositório
│
├── external/
│   └── datasources/       ← Implementações concretas de chamada HTTP com Dio
│
└── presentation/
    ├── pages/             ← Widgets de tela inteira
    ├── stores/            ← Controladores de estado (ValueNotifier)
    └── widgets/           ← Componentes visuais exclusivos do módulo
```
