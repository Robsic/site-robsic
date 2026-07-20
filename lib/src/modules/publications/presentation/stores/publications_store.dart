import 'package:flutter/foundation.dart';

import '../../domain/domain.dart';
import 'publications_state.dart';

class PublicationsStore extends ValueNotifier<PublicationsState> {
  PublicationsStore(
    this._getPublicationsPageDataUsecase,
    this._getPublicationsListUsecase,
  ) : super(const PublicationsStateIdle());

  final GetPublicationsPageDataUsecase _getPublicationsPageDataUsecase;
  final GetPublicationsListUsecase _getPublicationsListUsecase;

  PublicationsPageEntity? _entity;
  List<PublicationEntity> _publications = [];
  ResultType? _activeFilter;
  String _searchTerm = '';

  void filterByType(ResultType? type) {
    _activeFilter = type;
    _applyFilters();
  }

  void searchTerm(String searchTerm) {
    _searchTerm = searchTerm;
    _applyFilters();
  }

  void _applyFilters() {
    value = PublicationsListStateLoading(_entity!);
    List<PublicationEntity> filtered = _publications;

    if (_activeFilter != null) {
      filtered =
          filtered.where((p) => p.resultType == _activeFilter).toList();
    }

    if (_searchTerm.length > 3) {
      final term = _searchTerm.toLowerCase();
      filtered = filtered.where((p) {
        return p.title.toLowerCase().startsWith(term);
      }).toList();
    }

    value = PublicationsListStateSuccess(_entity!, filtered);
  }

  Future<void> getPublicationsPageData() async {
    value = const PublicationsStateLoading();
    final result = await _getPublicationsPageDataUsecase();
    result.fold(
      (entity) async {
        _entity = entity;
        await getPublicationsList();
      },
      (failure) => value = PublicationsStateFailure(failure),
    );
  }

  Future<void> getPublicationsList() async {
    value = PublicationsListStateLoading(_entity!);
    final result = await _getPublicationsListUsecase();
    result.fold(
      (publications) {
        _publications = publications;
        _activeFilter = null;
        _searchTerm = '';
        value = PublicationsListStateSuccess(_entity!, _publications);
      },
      (failure) => value = PublicationsListStateFailure(_entity!, failure),
    );
  }
}
