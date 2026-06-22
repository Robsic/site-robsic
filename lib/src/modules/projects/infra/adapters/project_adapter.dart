import 'package:robsic/src/modules/projects/domain/entities/project_entity.dart';
import '../../../core/domain/entities/image_entity.dart';
import '../../../core/domain/failures/failures.dart';
import '../../../core/infra/adapters/image_adapter.dart';

class ProjectAdapter {
  const ProjectAdapter._internal();

  static ProjectEntity fromMap(Map<String, dynamic> map) {
    try {
      final imageList = map['images']?['data'] != null
          ? ImageAdapter.fromList(map['images']['data'])
          : <ImageEntity>[];
      return ProjectEntity(
        name: map['name'] ?? '',
        category: map['category'] ?? '',
        description: map['description'] ?? '',
        startDate: map['start_date'] != null
            ? DateTime.parse(map['start_date'])
            : DateTime.now(),
        endDate:
            map['end_date'] != null ? DateTime.parse(map['end_date']) : null,
        image: imageList.isNotEmpty ? imageList.first : null,
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

  static List<ProjectEntity> fromList(List list) {
    try {
      return list.map((project) {
        return fromMap(project['attributes']);
      }).toList();
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
