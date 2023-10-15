import 'package:flutter/material.dart';
import 'package:robsic/src/modules/projects/domain/domain.dart';
import 'package:robsic/src/modules/projects/presentation/stores/projects_states.dart';

class ProjectsStore extends ValueNotifier<ProjectsState> {
  ProjectsStore(
    this._getProjectsDataUsecase,
    this._getProjectsListUsecase,
  ) : super(const ProjectsStateIdle());

  final GetProjectsDataUsecase _getProjectsDataUsecase;
  final GetProjectsListUsecase _getProjectsListUsecase;

  ProjectsEntity? _entity;
  List<ProjectEntity> _projects = [];
  List<ProjectEntity> _filtredProjectsBySeachTerm = [];

  void searchTerm(String searchTerm) {
    value = ProjectsListStateLoading(_entity!);
    if (searchTerm.length > 3) {
      _filtredProjectsBySeachTerm = _projects.where((project) {
        String projectName = project.name.toLowerCase();
        return projectName.startsWith(searchTerm.toLowerCase());
      }).toList();
      value = ProjectsListStateSuccess(_entity!, _filtredProjectsBySeachTerm);
    } else {
      value = ProjectsListStateSuccess(_entity!, _projects);
    }
  }

  Future<void> getProjectsPageData() async {
    value = const ProjectsStateLoading();
    final result = await _getProjectsDataUsecase();
    result.fold(
      (entity) async {
        _entity = entity;
        await getProjectsList();
      },
      (failure) => value = ProjectsStateFailure(failure),
    );
  }

  Future<void> getProjectsList() async {
    value = ProjectsListStateLoading(_entity!);
    final result = await _getProjectsListUsecase();
    result.fold(
      (projects) {
        _projects = projects;
        value = ProjectsListStateSuccess(_entity!, _projects);
      },
      (failure) => value = ProjectsListStateFailure(_entity!, failure),
    );
  }
}
