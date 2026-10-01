import 'package:robsic/src/modules/core/domain/entities/image_entity.dart';

class ContentWithImageSectionEntity {
  final String title;
  final String content;
  final ImageEntity? image;

  ContentWithImageSectionEntity({
    required this.title,
    required this.content,
    this.image,
  });
}
