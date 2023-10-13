abstract class AppFailure implements Exception {
  final dynamic error;
  final StackTrace? stackTrace;

  const AppFailure({this.error, this.stackTrace});
}

class ConnectionFailure extends AppFailure {
  const ConnectionFailure({super.error, super.stackTrace});
}

class FormatExceptionFailure extends AppFailure {
  const FormatExceptionFailure({super.error, super.stackTrace});
}

class UnableLaunchUrlFailure extends AppFailure {
  const UnableLaunchUrlFailure({super.error, super.stackTrace});
}

class InvalidContactmessageFailure extends AppFailure {
  const InvalidContactmessageFailure({super.error, super.stackTrace});
}
