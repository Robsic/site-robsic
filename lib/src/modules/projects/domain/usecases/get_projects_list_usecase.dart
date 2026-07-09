import 'package:result_dart/result_dart.dart';

import '../../../core/domain/failures/failures.dart';
import '../entities/project_entity.dart';
import '../repositories/projects_repository.dart';

class GetProjectsListUsecase {
  final ProjectsRepository _projectsRepository;

  GetProjectsListUsecase(this._projectsRepository);
  AsyncResult<List<ProjectEntity>, AppFailure> call({String preferredLocale = 'pt-BR'}) async {
    final result = await _projectsRepository.getProjectsList(preferredLocale: preferredLocale);
    return result;
  }
}
