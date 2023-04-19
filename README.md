# RobSIC

Site web desenvolvido para a equipe RobSIC, com o objetivo de garantir a presença digital do grupo, listar artigos/projetos desenvolvidos pela equipe e captar novas parcerias.

## 1. Funcionalidades

1. Landing Page
2. Página sobre o projeto
3. Lista de membros
4. Lista de publicações
5. Lista de projetos
6. Página de contato

### 1.1 Landing Page

O site contará com uma página inicial no estilo Landing Page, com chamadas para as principais funcionalidades do site.

### 1.2 Página sobre o projeto

Irá conter textos e fotos com detalhes sobre a equipe do RobSIC.
### 1.3 Lista de membros

Irá conter uma lista com os membros participantes do projeto.
### 1.4 Lista de publicações

Irá conter uma lista com as publicações de artigos realizadas pelos membros da equipe.
### 1.5 Lista de projetos

Irá conter a lista dos projetos atualmente desenvolvidos pela equipe.
### 1.6 Página de contato

Irá conter um formulário que permita que usuários do site entre em contato com a equipe.

## 2. Experiência do Usuário

Toda interface será feita seguindo as boas práticas de UI/UX, usando componentes pré-construidos do Material Design, e componentes customizados quando necessário. Informações de mockup, fonte e assets estão disponíveis no Figma.

[Link do Figma](https://www.figma.com/file/mUrd5r0E1DmPG5qH4A0Omd/Robsic?node-id=519%3A405&t=04h0iTtWmAYK3c3N-1)

## 3. Arquitetura

Nesta seção será definida os detalhes de arquitetura a serem considerados durante o desenvolvimento.

# Regras iniciais, limite e Análise

Pontos a serem levados em consideração antes de introduzir uma nova feature:

- Todo projeto precisará respeitar as regras de Lint padrão definido no pacote flutter_lint.
- O projeto será desenvolvido com seguindo boas práticas como os princípios S.O.L.I.D. sempre que possível. Será adotado um modelo de arquitetura baseado na Proposta do [Clean Dart](https://github.com/Flutterando/Clean-Dart).
- Camadas globais devem ter um lugar específico na aplicação, por tanto, devem estar na pasta Core.
- Cada feature deverá ter sua própria pasta onde conterá todas as camadas necessárias para a execução dos casos de uso da feature.
- Todos os designs patterns usados no projeto devem estar listados na sessão “Design Patterns” desse documento, caso contrário será considerado implementação errônea.
- Packages e plugins novos só poderão ser usados nos projetos após avaliação, levando em consideração a necessidade do uso dos mesmos. Quando utilizados,deverão ser observadas questões de segurança, estabilidade, popularidade e frequência de atualizações.
- Não é permitido ter uma classe concreta como dependência de uma camada. Só será aceita coesão com classes abstratas ou interfaces. Com exceção da Store.
- Cada camada deve ter apenas uma responsabilidade.

# Entidades

# Casos de Uso

# Design Pattens

- Service Pattern: Para isolar trechos de códigos com outras responsabilidades.
- Dependency Injection: Resolver dependências das classes.
- State pattern: Padrão que auxilia no gerenciamento estados.
- Adapter: Converter um objeto em outro.
- Result: Trabalhar com retorno Múltiplo.

# Packages Externos

- result: Retorno múltiplo no formato Failure e Success.
- Mocktail: Para testes de unidade.