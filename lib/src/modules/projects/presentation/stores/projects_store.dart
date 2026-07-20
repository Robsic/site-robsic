import 'package:flutter/material.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';
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

  static const List<String> _customOrderKeywords = [
    'vision parking',
    'vr mining',
    'digital twin',
    'ferramenta de realidade virtual',
    'simod',
    'protótipo de hardware',
    'veículo terrestre',
    'prestação de contas',
  ];

  int _getSortOrderIndex(String name) {
    final lower = name.toLowerCase();
    for (int i = 0; i < _customOrderKeywords.length; i++) {
      if (lower.contains(_customOrderKeywords[i])) {
        return i;
      }
    }
    return 999;
  }

  void _sortProjects(List<ProjectEntity> list) {
    list.sort((a, b) => _getSortOrderIndex(a.name).compareTo(_getSortOrderIndex(b.name)));
  }

  void searchTerm(String searchTerm) {
    value = ProjectsListStateLoading(_entity!);
    if (searchTerm.trim().length >= 2) {
      final term = searchTerm.toLowerCase();
      _filtredProjectsBySeachTerm = _projects.where((project) {
        return project.name.toLowerCase().contains(term) ||
               project.category.toLowerCase().contains(term);
      }).toList();
      _sortProjects(_filtredProjectsBySeachTerm);
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
    final locale = serviceLocator.get<AppStore>().value.fullLanguageCode;
    final result = await _getProjectsListUsecase(preferredLocale: locale);
    result.fold(
      (projects) {
        _projects = projects;
        _sortProjects(_projects);
        value = ProjectsListStateSuccess(_entity!, _projects);
      },
      (failure) => value = ProjectsListStateFailure(_entity!, failure),
    );
  }

  /// Reprocessa a lista com o locale atual sem fazer nova requisição de rede.
  /// Chamado quando o usuário troca de idioma.
  Future<void> reprocessList() async {
    if (_entity == null) return;
    await getProjectsList();
  }
}
