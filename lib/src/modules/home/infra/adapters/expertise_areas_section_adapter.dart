import '../../../core/core.dart';
import '../../domain/domain.dart';

class ExpertiseAreasSectionAdapter {
  const ExpertiseAreasSectionAdapter._internal();

  static ExpertiseAreasSectionEntity fromMap(Map<String, dynamic> map) {
    try {
      return ExpertiseAreasSectionEntity(
        title: map['title'] ?? '',
        description: map['description'] ?? map['content'],
        expertiseAreas: map['expertise_areas'] != null
            ? ExpertiseAreasAdapter.fromList(map['expertise_areas'])
            : null,
        image: map['image']?['data']?['attributes'] != null
            ? ImageAdapter.fromMap(map['image']['data']['attributes'])
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

class ExpertiseAreasAdapter {
  const ExpertiseAreasAdapter._internal();

  static String fromMap(Map<String, dynamic> map) {
    try {
      return map['expertise_area'] ?? '';
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static List<String> fromList(List list) {
    try {
      return list.map((expertiseArea) => fromMap(expertiseArea)).toList();
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
