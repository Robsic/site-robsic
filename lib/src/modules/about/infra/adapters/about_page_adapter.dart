import 'package:robsic/src/modules/about/domain/entities/about_page_entity.dart';
import 'package:robsic/src/modules/core/infra/adapters/image_adapter.dart';

import '../../../core/domain/failures/app_failures.dart';
import '../../../core/infra/adapters/header_adapter.dart';

class AboutPageAdapter {
  const AboutPageAdapter._internal();

  static AboutPageEntity fromMap(Map<String, dynamic> map) {
    try {
      return AboutPageEntity(
        headerSection:
            map['header'] != null ? HeaderAdapter.fromMap(map['header']) : null,
        title: map['title'],
        introduction: map['introduction'],
        images: map['images']?['data'] != null
            ? ImageAdapter.fromList(map['images']['data'])
            : null,
        moreAbout: map['more_about'],
      );
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
