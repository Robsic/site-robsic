import 'package:robsic/src/modules/core/domain/entities/image_entity.dart';

class ExpertiseAreasSectionEntity {
  final String title;
  final String? description;
  final List<String>? expertiseAreas;
  final ImageEntity? image;

  ExpertiseAreasSectionEntity({
    required this.title,
    this.description,
    this.expertiseAreas,
    this.image,
  });
}
