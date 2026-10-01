# 🚀 Tutorial: Primeiros Passos no Site RobSIC

> **Objetivo:** Configurar o ambiente de desenvolvimento e executar a aplicação Flutter Web localmente na sua máquina pela primeira vez.
> **Público:** Novos estagiários, bolsistas, alunos e pesquisadores do laboratório RobSIC.
> **Tempo estimado:** 15 a 20 minutos.

---

## 1. Pré-requisitos

Antes de iniciar, certifique-se de possuir instalado em sua máquina:

1. **Git** (versão 2.30 ou superior)
2. **Flutter SDK** (`>= 3.0.0` compatível com Dart `3.x`)
   - Verifique sua instalação rodando:
     ```bash
     flutter doctor
     ```
   - O suporte para **Chrome / Web** deve estar habilitado (`[✓] Chrome - develop for the web`).
3. **Google Chrome** ou qualquer navegador baseado em Chromium.
4. **VS Code** (com extensões *Flutter* e *Dart*) ou **Android Studio**.

---

## 2. Clonando o Repositório

Clone o repositório oficial da organização:

```bash
git clone git@github.com:Robsic/site-robsic.git
cd site-robsic
```

Por padrão, a branch ativa de desenvolvimento é a `development`:

```bash
git checkout development
```

---

## 3. Instalando as Dependências

Na raiz do projeto, instale os pacotes declarados no `pubspec.yaml`:

```bash
flutter pub get
```

Este comando baixa as dependências (Dio, GoRouter, GetIt, Flutter Localizations, etc.) e compila as ferramentas de suporte na pasta `.dart_tool/`.

---

## 4. Gerando Código de Internacionalização (i18n)

O site possui suporte a múltiplos idiomas (Português e Inglês). Os arquivos de tradução ficam em `lib/src/modules/core/presentation/l10n/` ou são configurados via `l10n.yaml`.

Rode a geração automática de l10n se necessário:

```bash
flutter gen-l10n
```

---

## 5. Executando Localmente

Para rodar a aplicação em modo de desenvolvimento web, é fundamental especificar a URL base da API do Strapi CMS através da variável de compilação `--dart-define=BASE_URL`:

### Conectando ao Strapi de Produção (UNIFEI):
```bash
flutter run -d chrome --dart-define=BASE_URL=https://robsic.unifei.edu.br
```

### Conectando a uma instância local do Strapi (caso esteja rodando o backend na máquina):
```bash
flutter run -d chrome --dart-define=BASE_URL=http://localhost:1337
```

> [!TIP]
> Se você utiliza o VS Code, crie um arquivo `.vscode/launch.json` para facilitar a depuração (pressione `F5`):
> ```json
> {
>   "version": "0.2.0",
>   "configurations": [
>     {
>       "name": "Site RobSIC (Web)",
>       "request": "launch",
>       "type": "dart",
>       "args": [
>         "-d", "chrome",
>         "--dart-define=BASE_URL=https://robsic.unifei.edu.br"
>       ]
>     }
>   ]
> }
> ```

---

## 6. O que Você Deve Ver

1. Uma nova janela do Chrome será aberta.
2. A tela inicial (Landing Page) do RobSIC será carregada exibindo:
   - Seção de Apresentação / Header
   - Áreas de Atuação do Laboratório
   - Projetos Recentes
   - Membros da Equipe
   - Publicações e Resultados de Pesquisa
   - Rodapé Institucional com links e contatos

---

## 7. Próximos Passos

Agora que seu ambiente está rodando, consulte o tutorial [02-first-contribution.md](./02-first-contribution.md) para aprender o fluxo de branches, Conventional Commits e como submeter alterações com qualidade.
