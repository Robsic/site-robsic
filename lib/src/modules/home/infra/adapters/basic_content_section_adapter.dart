import 'package:robsic/src/modules/home/domain/entities/basic_content_section_entity.dart';

import '../../../core/domain/failures/app_failures.dart';

class BasicContentAdapter {
  const BasicContentAdapter._internal();

  static BasicContentSectionEntity fromMap(Map<String, dynamic> map) {
    try {
      return BasicContentSectionEntity(
        title: map['title'] ?? '',
        content: map['content'] ?? '',
      );
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw (FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      ));
    }
  }
}
