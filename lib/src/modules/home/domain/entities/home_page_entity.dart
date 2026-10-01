import './basic_content_section_entity.dart';
import './content_with_image_section_entity.dart';
import './expertise_areas_section_entity.dart';
import './partnerships_section_entity.dart';
import '../../../core/core.dart';

class HomePageEntity {
  final HeaderSectionEntity? headerSection;
  final ExpertiseAreasSectionEntity? expertiseAreasSection;
  final ContentWithImageSectionEntity? projectsSection;
  final ContentWithImageSectionEntity? membersSection;
  final BasicContentSectionEntity? publicationsSection;
  final PartnershipsSectionEntity? partnershipsSection;

  HomePageEntity({
    this.headerSection,
    this.expertiseAreasSection,
    this.projectsSection,
    this.membersSection,
    this.publicationsSection,
    this.partnershipsSection,
  });
}
