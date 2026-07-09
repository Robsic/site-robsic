import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/failures.dart';
import 'package:robsic/src/modules/projects/domain/entities/project_entity.dart';
import 'package:robsic/src/modules/projects/domain/entities/projects_entity.dart';
import 'package:robsic/src/modules/projects/domain/repositories/projects_repository.dart';
import 'package:robsic/src/modules/projects/infra/adapters/projects_adapter.dart';
import 'package:robsic/src/modules/projects/infra/datasources/projects_datasource.dart';

import '../adapters/project_adapter.dart';

class ProjectsRepositoryImpl implements ProjectsRepository {
  final ProjectsDatasource _projectsDatasource;

  ProjectsRepositoryImpl(this._projectsDatasource);
  @override
  AsyncResult<ProjectsEntity, AppFailure> getProjectsData() async {
    try {
      final result = await _projectsDatasource.getProjectsData();
      final projectsEntity = ProjectsAdapter.fromMap(result);
      return Success(projectsEntity);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }

  @override
  AsyncResult<List<ProjectEntity>, AppFailure> getProjectsList({String preferredLocale = 'pt-BR'}) async {
    try {
      final result = await _projectsDatasource.getProjectsList();
      final projectsList = ProjectAdapter.fromList(result['data'], preferredLocale: preferredLocale);
      return Success(projectsList);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }
}
