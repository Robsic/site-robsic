# 🤝 Tutorial: Sua Primeira Contribuição e Fluxo Git Profissional

> **Objetivo:** Ensinar o fluxo padrão de trabalho, padronização de commits e submissão de alterações no repositório do Site RobSIC.
> **Alinhamento:** Metodologia de versionamento profissional abordada nas diretrizes de engenharia de software do laboratório RobSIC (Dr. Wendell Diniz).
> **Tempo estimado:** 10 minutos de leitura.

---

## 1. Estratégia de Branches (Branching Model)

O projeto adota uma variação simplificada e robusta do GitFlow para desenvolvimento contínuo:

```
main (produção estável)
  │
  └── development (integração contínua e homologação)
        ├── feature/minha-nova-funcionalidade
        ├── bugfix/correcao-do-problema
        └── docs/atualizacao-da-documentacao
```

### Regras Fundamentais:
1. **Nunca faça commits diretos na branch `main`**. A branch `main` reflete o código que está em produção no servidor da UNIFEI.
2. Todas as branches de trabalho partem da **`development`** e retornam para ela via **Pull Request (PR)**.
3. Quando a branch `development` atinge maturidade ou marco de entrega, ela é integrada à `main`.

---

## 2. Passo a Passo para Criar uma Branch

Sempre sincronize a branch `development` antes de criar sua branch de trabalho:

```bash
git checkout development
git pull origin development
```

Crie sua branch nomeada com o prefixo apropriado:

```bash
# Para uma nova funcionalidade:
git checkout -b feature/filtro-pesquisa-publicacoes

# Para a correção de um defeito:
git checkout -b bugfix/responsividade-card-membros

# Para melhorias de documentação:
git checkout -b docs/guia-deploy-ssh
```

---

## 3. Padrão de Mensagens: Conventional Commits

Todo commit deve seguir a especificação **Conventional Commits**:

```
<tipo>[escopo opcional]: <descrição concisa no presente do indicativo>

[corpo opcional explicando o motivo da alteração]

[rodapé opcional com referências a issues ou breaking changes]
```

### Tabela de Tipos Permitidos

| Tipo | Finalidade | Exemplo de Commit |
|---|---|---|
| `feat` | Uma nova funcionalidade ou recurso para o usuário | `feat: adiciona modal de reprodução de vídeo do YouTube` |
| `fix` | Correção de um bug ou comportamento inesperado | `fix: corrige overflow vertical no card de publicações` |
| `docs` | Alterações e melhorias exclusivamente em documentação | `docs: adiciona tutorial de primeiros passos com Diátaxis` |
| `style` | Formatação, ponto e vírgula, espaçamento (sem afetar lógica) | `style: reordena colunas do rodapé institucional` |
| `refactor` | Refatoração interna de código que não altera comportamento | `refactor: extrai lógica de formatação de datas para adapter` |
| `perf` | Melhoria que eleva performance de processamento ou renderização | `perf: otimiza carregamento lazy de fotos dos membros` |
| `test` | Inclusão, correção ou refatoração de testes automatizados | `test: adiciona testes unitários para a store de projetos` |
| `chore` | Manutenção em scripts, build, `.gitignore`, dependências | `chore: atualiza pacotes no pubspec.yaml e limpa gitignore` |

> [!TIP]
> **Boas Práticas de Commit:**
> - Escreva descrições em minúsculas logo após os dois pontos.
> - Seja claro e direto: prefira `fix: ajusta altura máxima do card` a `fix: ajustes`.
> - Faça commits atômicos: resolva um problema por commit.

---

## 4. Verificação de Qualidade Antes de Enviar

Antes de enviar seus commits para o GitHub, rode obrigatoriamente a análise estática e a suíte de testes:

```bash
# 1. Análise estática (deve retornar "No issues found!")
flutter analyze

# 2. Testes unitários (todos devem passar)
flutter test
```

Se houver alertas de lint ou falhas de teste, corrija-os antes de avançar.

---

## 5. Enviando Alterações e Abrindo o Pull Request

Envie sua branch para o repositório da organização:

```bash
git push -u origin minha-branch
```

No GitHub:
1. Acesse o repositório [github.com/Robsic/site-robsic](https://github.com/Robsic/site-robsic).
2. O GitHub exibirá um botão verde **"Compare & pull request"**.
3. Certifique-se de que a branch base (destino) seja **`development`** (e não `main`).
4. Preencha o título seguindo o padrão Conventional Commits (ex: `feat: suporte a badges interativos de patentes`).
5. Descreva brevemente o que foi feito e os testes realizados.
6. Solicite revisão e aguarde a validação.
