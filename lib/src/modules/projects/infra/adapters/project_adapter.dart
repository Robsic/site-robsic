import 'package:robsic/src/modules/projects/domain/entities/project_entity.dart';

import '../../../core/domain/failures/failures.dart';
import '../../../core/infra/adapters/image_adapter.dart';

class ProjectAdapter {
  const ProjectAdapter._internal();

  static ProjectEntity fromMap(Map<String, dynamic> map) {
    try {
      return ProjectEntity(
        name: map['name'],
        category: map['category'],
        description: map['description'],
        startDate: DateTime.parse(map['start_date']),
        endDate: DateTime.parse(map['end_date']),
        image: ImageAdapter.fromList(map['images']['data']['attributes']).first,
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
      return list.map((project) => fromMap(project['attributes'])).toList();
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
