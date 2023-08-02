import 'package:robsic/src/modules/core/domain/entities/header_section_entity.dart';
import 'package:robsic/src/modules/core/domain/entities/image_entity.dart';

class AboutPageEntity {
  final HeaderSectionEntity? headerSection;
  final String? title;
  final String? intoduction;
  final List<ImageEntity>? images;
  final String? moreAbout;

  const AboutPageEntity({
    this.headerSection,
    this.title,
    this.intoduction,
    this.images,
    this.moreAbout,
  });
}
