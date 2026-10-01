import 'package:robsic/src/modules/core/domain/entities/image_entity.dart';

import '../../domain/failures/app_failures.dart';

class ImageAdapter {
  const ImageAdapter._internal();

  static ImageEntity fromMap(Map<String, dynamic> map) {
    try {
      return ImageEntity(
        name: map['name'],
        alternativeText: map['alternativeText'],
        caption: map['caption'],
        thumbUrl: map['formats']?['thumbnail']?['url'],
        smallFormatUrl: map['formats']?['small']?['url'],
        mediumFormatUrl: map['formats']?['medium']?['url'],
        largeFormatUrl: map['formats']?['large']?['url'],
        url: map['url'] ?? '',
      );
    } on FormatException catch (error, stackTrace) {
      throw (FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      ));
    }
  }

  static List<ImageEntity> fromList(List list) {
    try {
      final imageList =
          list.map((image) => fromMap(image['attributes'])).toList();
      return imageList;
    } on FormatException catch (error, stackTrace) {
      throw (FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      ));
    }
  }
}
