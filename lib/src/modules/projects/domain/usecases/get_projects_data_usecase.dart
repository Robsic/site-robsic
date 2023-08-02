import 'package:result_dart/result_dart.dart';

import '../../../core/domain/failures/failures.dart';
import '../entities/projects_entity.dart';
import '../repositories/projects_repository.dart';

class GetProjectsDataUsecase {
  final ProjectsRepository _projectsRepository;

  GetProjectsDataUsecase(this._projectsRepository);
  AsyncResult<ProjectsEntity, AppFailure> call() async {
    final result = await _projectsRepository.getProjectsData();
    return result;
  }
}
