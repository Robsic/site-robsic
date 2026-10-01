# 🌐 Guia Prático: Internacionalização (i18n) e Idiomas

> **Finalidade:** Como gerenciar textos traduzidos no frontend (Português e Inglês) e compreender a integração com as traduções do Strapi CMS.
> **Idiomas suportados:** Português do Brasil (`pt-BR`) e Inglês (`en-US`).

---

## 1. Como a Internacionalização Funciona

O ecossistema de internacionalização do RobSIC opera em duas pontas:
1. **Frontend (Textos da Interface):** Gerenciado nativamente pelo Flutter via arquivos `.arb` (Application Resource Bundle) localizados em `lib/l10n/`.
2. **Backend (Conteúdo Dinâmico):** Gerenciado pelo Strapi CMS através do plugin oficial `@strapi/plugin-i18n` e tradução automatizada via `strapi-plugin-translate` integrado ao DeepL.

---

## 2. Passo a Passo: Adicionando um Novo Texto no Frontend

### Passo 1: Adicionar a chave em `lib/l10n/app_pt.arb` (Português)
Abra `lib/l10n/app_pt.arb` e inclua a nova chave:
```json
{
  "meuNovoBotao": "Acessar Projeto"
}
```

### Passo 2: Adicionar a tradução em `lib/l10n/app_en.arb` (Inglês)
Abra `lib/l10n/app_en.arb` com a descrição correspondente:
```json
{
  "meuNovoBotao": "Access Project"
}
```

### Passo 3: Compilar as classes de localização
No terminal, execute o gerador:
```bash
flutter gen-l10n
```
*O Flutter atualizará os arquivos `app_localizations.dart`, `app_localizations_pt.dart` e `app_localizations_en.dart` automaticamente.*

---

## 3. Utilizando o Texto nos Widgets

No seu widget Flutter, recupere o texto utilizando o contexto:

```dart
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Widget build(BuildContext context) {
  final l10n = AppLocalizations.of(context)!;

  return ElevatedButton(
    onPressed: () {},
    child: Text(l10n.meuNovoBotao),
  );
}
```

---

## 4. Como Funciona a Troca de Idioma em Tempo Real

A troca de idioma é reativa e gerenciada pelo **`AppStore`** (`lib/src/app_store.dart`):

- **Estado Global:** `AppStore` estende `ValueNotifier<AppLocale>`, contendo o idioma ativo (`AppLocale.ptBR` ou `AppLocale.enUS`).
- **Botão na AppBar:** Quando o usuário clica no seletor de idioma, o método `appStore.changeLocale(AppLocale.enUS)` é acionado.
- **Requisições à API Strapi:** Ao trocar o idioma, as stores de dados (Membros, Publicações, Projetos) refazem a consulta HTTP ao Strapi passando o parâmetro de locale correspondente (`?locale=en` ou `?locale=pt-BR`), garantindo renderização instantânea do conteúdo traduzido.
