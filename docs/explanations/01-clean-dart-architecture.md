# 🏛️ Explicação: Arquitetura Clean Dart no Frontend

> **Finalidade:** Compreender os fundamentos conceituais, a separação de responsabilidades e as motivações técnicas por trás da arquitetura adotada no site do RobSIC.

---

## 1. Por Que Clean Dart?

A arquitetura do projeto é baseada na proposta **Clean Dart** (inspirada na *Clean Architecture* de Robert C. Martin / Uncle Bob). Em um ambiente acadêmico como o RobSIC, onde desenvolvedores (estudantes e estagiários) passam por ciclos de formação e transição, essa abordagem oferece:

- **Desacoplamento Rigoroso:** A lógica de negócio e as entidades do laboratório são totalmente independentes de pacotes externos, bibliotecas de UI e de frameworks como o Flutter.
- **Testabilidade:** Cada caso de uso, adapter e repositório pode ser testado unitariamente de forma isolada com mocks (usando `mocktail`).
- **Facilidade de Manutenção:** Novas funcionalidades são encapsuladas em módulos próprios, evitando efeitos colaterais em outras páginas.

---

## 2. As Camadas do Clean Dart

Cada módulo da aplicação (ex: `members`, `publications`, `projects`) é dividido internamente em quatro camadas bem delimitadas:

```
┌────────────────────────────────────────────────────────┐
│                   PRESENTATION                         │
│         (Pages, Widgets, Stores, States)               │
└──────────────────────────┬─────────────────────────────┘
                           │ Consome UseCases
┌──────────────────────────▼─────────────────────────────┐
│                      DOMAIN                            │  ◄── Núcleo da Lógica
│     (Entities, UseCases, Repository Interfaces)        │      Puro Dart
└──────────────────────────▲─────────────────────────────┘
                           │ Implementa Interfaces
┌──────────────────────────┴─────────────────────────────┐
│                      INFRA                             │
│     (Repository Implementations, Adapters,             │
│      Datasource Interfaces)                            │
└──────────────────────────▲─────────────────────────────┘
                           │ Implementa Datasources
┌──────────────────────────┴─────────────────────────────┐
│                    EXTERNAL                            │
│        (Datasources REST com Dio, APIs, Cache)         │
└────────────────────────────────────────────────────────┘
```

---

### 1. Camada de Domínio (`domain/`)
- **É o coração da aplicação.** Contém apenas código Dart puro, sem dependências do Flutter ou de bibliotecas de terceiros.
- **Entities:** Objetos de negócio (ex: `MemberEntity`, `PublicationEntity`, `ProjectEntity`). São imutáveis.
- **UseCases:** Casos de uso específicos que executam uma regra de negócio (ex: `GetMembersListUsecase`, `GetPublicationsPageDataUsecase`).
- **Repositories (Interfaces):** Contratos abstratos que definem quais operações de dados existem, sem se preocupar de onde eles vêm.

### 2. Camada de Infraestrutura (`infra/`)
- Faz a ponte entre a camada de domínio e o mundo externo.
- **Repositories (Implementações):** Implementam as interfaces do domínio, coordenando os datasources e tratando falhas com `result_dart`.
- **Adapters:** Classes puras responsáveis por serializar e deserializar dados (converter JSON/Maps do Strapi em Entities do domínio).
- **Datasources (Interfaces):** Contratos que definem os métodos de acesso a dados brutos.

### 3. Camada Externa (`external/`)
- É a camada que fala com serviços externos.
- **Datasources (Implementações):** Fazem as chamadas HTTP via cliente `Dio` para a API REST do Strapi CMS.
- Lida com paginação, headers de autorização e tratamento de exceções HTTP.

### 4. Camada de Apresentação (`presentation/`)
- Onde vive a interface do usuário.
- **Pages:** Telas principais da rota.
- **Widgets:** Componentes visuais atômicos e moléculas da tela.
- **Stores:** Controladores de estado que acionam os UseCases e notificam a UI sobre mudanças (`Loading`, `Success`, `Failure`).

---

## 3. Regra de Dependência

A regra mais sagrada da arquitetura é a **Regra da Dependência**:
> *O código das camadas internas nunca pode depender de classes das camadas externas.*

- `Domain` não conhece `Infra`, `External` nem `Presentation`.
- `Presentation` depende apenas das abstrações de `Domain` (UseCases e Entities).
- `External` depende apenas das interfaces de `Infra`.

Todas as conexões entre interfaces e implementações concretas são resolvidas em tempo de inicialização pelo injetor de dependências **GetIt**.
