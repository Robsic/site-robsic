import 'package:robsic/src/modules/core/infra/adapters/image_adapter.dart';
import 'package:robsic/src/modules/home/domain/entities/content_with_image_section_entity.dart';

import '../../../core/domain/failures/app_failures.dart';

class ContentWithImageAdapter {
  const ContentWithImageAdapter._internal();

  static ContentWithImageSectionEntity fromMap(Map<String, dynamic> map) {
    try {
      return ContentWithImageSectionEntity(
        title: map['title'] ?? '',
        content: map['content'] ?? '',
        image: map['image']?['data']?['attributes'] != null
            ? ImageAdapter.fromMap(
                map['image']?['data']?['attributes'],
              )
            : null,
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
