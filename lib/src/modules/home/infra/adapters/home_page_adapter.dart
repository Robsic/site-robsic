import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../infra.dart';

class HomeAdapter {
  const HomeAdapter._internal();

  static HomePageEntity fromMap(Map<String, dynamic> map) {
    try {
      return HomePageEntity(
        headerSection:
            map['header'] != null ? HeaderAdapter.fromMap(map['header']) : null,
        expertiseAreasSection: map['expertise_areas_section'] != null
            ? ExpertiseAreasSectionAdapter.fromMap(
                map['expertise_areas_section'])
            : null,
        projectsSection: map['projects_section'] != null
            ? ContentWithImageAdapter.fromMap(map['projects_section'])
            : null,
        membersSection: map['members_section'] != null
            ? ContentWithImageAdapter.fromMap(map['members_section'])
            : null,
        publicationsSection: map['publications_section'] != null
            ? BasicContentAdapter.fromMap(map['publications_section'])
            : null,
        partnershipsSection: map['partnerships_section'] != null
            ? PartnershipsSectionAdapter.fromMap(map['partnerships_section'])
            : null,
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
