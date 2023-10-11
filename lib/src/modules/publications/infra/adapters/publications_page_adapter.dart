import 'package:robsic/src/modules/publications/domain/domain.dart';

import '../../../core/core.dart';

class PublicationsPageAdapter {
  const PublicationsPageAdapter._internal();

  static PublicationsPageEntity fromMap(Map<String, dynamic> map) {
    try {
      return PublicationsPageEntity(
          header: HeaderAdapter.fromMap(map['header']));
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
