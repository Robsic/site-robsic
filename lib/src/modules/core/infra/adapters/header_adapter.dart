import 'package:robsic/src/modules/core/domain/entities/header_section_entity.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';

class HeaderAdapter {
  HeaderAdapter._internal();

  static HeaderSectionEntity fromMap(Map<String, dynamic> map) {
    try {
      return HeaderSectionEntity(
        title: map['title'] ?? '',
        content: map['content'] ?? '',
      );
    } on FormatException catch (error, stackTrace) {
      throw (FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      ));
    }
  }
}
