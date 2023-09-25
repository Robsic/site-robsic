import 'package:robsic/src/modules/projects/domain/domain.dart';

import '../../../core/core.dart';

abstract class ProjectsState {
  const ProjectsState();
}

class ProjectsStateIdle extends ProjectsState {
  const ProjectsStateIdle();
}

class ProjectsStateLoading extends ProjectsState {
  const ProjectsStateLoading();
}

class ProjectsStateSuccess extends ProjectsState {
  final ProjectsEntity projectsEntity;
  const ProjectsStateSuccess(this.projectsEntity);
}

class ProjectsStateFailure extends ProjectsState {
  final AppFailure failure;
  const ProjectsStateFailure(this.failure);
}

class ProjectsListStateLoading extends ProjectsStateSuccess {
  const ProjectsListStateLoading(super.projectsEntity);
}

class ProjectsListStateSuccess extends ProjectsStateSuccess {
  final List<ProjectEntity> projects;
  const ProjectsListStateSuccess(
    super.projectsEntity,
    this.projects,
  );
}

class ProjectsListStateFailure extends ProjectsStateSuccess {
  final AppFailure failure;
  const ProjectsListStateFailure(
    super.projectsEntity,
    this.failure,
  );
}
