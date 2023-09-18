import 'package:robsic/src/modules/core/domain/entities/header_section_entity.dart';
import 'package:robsic/src/modules/core/domain/entities/image_entity.dart';

class AboutPageEntity {
  final HeaderSectionEntity? headerSection;
  final String? title;
  final String? introduction;
  final List<ImageEntity>? images;
  final String? moreAbout;

  const AboutPageEntity({
    this.headerSection,
    this.title,
    this.introduction,
    this.images,
    this.moreAbout,
  });
}
