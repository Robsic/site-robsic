# 🧠 Explicação: Gerenciamento de Estado, Injeção de Dependências e Tratamento de Erros

> **Finalidade:** Compreender os padrões arquiteturais aplicados no frontend para reatividade da UI, injeção de dependências desacoplada e programação funcional com tratamento robusto de falhas.

---

## 1. Gerenciamento de Estado: O Padrão Store

No projeto RobSIC, o gerenciamento de estado é implementado através do **Padrão Store** baseado no `ValueNotifier` nativo do Flutter.

### Por que essa escolha?
- **Simplicidade e Performance:** Não exige bibliotecas pesadas e boilerplate excessivo. O `ValueNotifier` é nativo do Flutter, altamente otimizado para a Web e fácil de aprender para quem está começando.
- **Tipagem Estrita dos Estados:** Cada tela possui uma hierarquia clara de estados imutáveis:

```dart
abstract class MembersState {}

class MembersStateInitial extends MembersState {}
class MembersStateLoading extends MembersState {}
class MembersStateSuccess extends MembersState {
  final List<MemberEntity> members;
  MembersStateSuccess(this.members);
}
class MembersStateFailure extends MembersState {
  final Failure failure;
  MembersStateFailure(this.failure);
}
```

### Reatividade na Interface:
A tela escuta as mudanças da store através do widget `ValueListenableBuilder`:

```dart
ValueListenableBuilder<MembersState>(
  valueListenable: store,
  builder: (context, state, child) {
    if (state is MembersStateLoading) return CircularLoadingAtom();
    if (state is MembersStateSuccess) return MemberGridWidget(state.members);
    if (state is MembersStateFailure) return ErrorFeedbackWidget(state.failure);
    return const SizedBox.shrink();
  },
)
```

---

## 2. Injeção de Dependências com `GetIt`

O **GetIt** atua como o *Service Locator* central da aplicação. Ele é configurado no arquivo `lib/src/resources/factories/dio_factory.dart` e nas classes de inicialização de cada módulo.

### Vantagens:
- **Inversão de Controle (IoC):** A UI não sabe como construir o UseCase, o Repositório ou o Datasource. Ela apenas solicita ao GetIt:
  ```dart
  final store = getIt<MembersStore>();
  ```
- **Facilidade nos Testes:** Nos testes de unidade (`test/`), é possível substituir qualquer dependência por um mock com apenas uma linha:
  ```dart
  getIt.registerFactory<MembersRepository>(() => MockMembersRepository());
  ```

---

## 3. Tratamento Funcional de Erros com `result_dart`

Em vez de lançar exceções (`throw Exception(...)`) e espalhar blocos `try/catch` desordenados pelo código, o projeto utiliza a biblioteca **`result_dart`**.

### O Conceito de `Result<S, F>`:
Toda operação que pode falhar (como uma requisição HTTP ou conversão de dados) retorna explicitamente um tipo `Result`:
- `Success(valor)`: quando a operação foi bem-sucedida.
- `Failure(erro)`: quando ocorreu uma falha conhecida.

### Exemplo no Repositório:
```dart
Future<Result<List<MemberEntity>, Failure>> getMembers() async {
  try {
    final rawData = await datasource.getMembers();
    final entities = rawData.map(MemberAdapter.fromMap).toList();
    return Success(entities);
  } on DioException catch (e) {
    return Failure(ServerFailure(e.message));
  } catch (e) {
    return Failure(UnknownFailure(e.toString()));
  }
}
```

### Benefício:
O compilador Dart obriga a Store a verificar se o retorno foi `Success` ou `Failure` antes de acessar os dados, eliminando 100% dos erros inesperados em tempo de execução como `NoSuchMethodError: The getter 'length' was called on null`.
