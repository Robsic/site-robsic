import 'dart:developer';

import 'package:robsic/src/modules/core/domain/failures/failures.dart';
import 'package:robsic/src/modules/core/infra/adapters/header_adapter.dart';
import 'package:robsic/src/modules/projects/domain/entities/projects_entity.dart';

class ProjectsAdapter {
  const ProjectsAdapter._internal();

  static ProjectsEntity fromMap(Map<String, dynamic> map) {
    try {
      return ProjectsEntity(header: HeaderAdapter.fromMap(map));
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      log(error.toString());
      throw FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
