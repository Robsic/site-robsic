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

  int _getSortOrderIndex(String name) {
    final lower = name.toLowerCase();
    if (lower.contains('vision parking') || lower.contains('estacionamento')) return 0;
    if (lower.contains('vr mining') || lower.contains('789d')) return 1;
    if (lower.contains('digital twin')) return 2;
    if (lower.contains('ferramenta de realidade virtual') ||
        (lower.contains('realidade virtual') && !lower.contains('hardware'))) return 3;
    if (lower.contains('simod') || lower.contains('disjuntores')) return 4;
    if (lower.contains('hardware') || lower.contains('protótipo') || lower.contains('prototipo')) return 5;
    if (lower.contains('veículo terrestre') || lower.contains('veiculo terrestre') || lower.contains('autônomo') || lower.contains('autonomo')) return 6;
    if (lower.contains('contrato') || lower.contains('prestação') || lower.contains('prestacao')) return 7;
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
