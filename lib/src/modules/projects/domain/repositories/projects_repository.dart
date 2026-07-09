import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/projects/domain/entities/project_entity.dart';
import 'package:robsic/src/modules/projects/domain/entities/projects_entity.dart';

import '../../../core/domain/failures/failures.dart';

abstract class ProjectsRepository {
  AsyncResult<ProjectsEntity, AppFailure> getProjectsData();
  AsyncResult<List<ProjectEntity>, AppFailure> getProjectsList({String preferredLocale = 'pt-BR'});
}
