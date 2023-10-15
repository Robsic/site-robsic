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
  List<PublicationEntity> _filtredPublicationsBySeachTerm = [];

  void searchTerm(String searchTerm) {
    value = PublicationsListStateLoading(_entity!);
    if (searchTerm.length > 3) {
      _filtredPublicationsBySeachTerm = _publications.where((publication) {
        String publicationName = publication.title.toLowerCase();
        return publicationName.startsWith(searchTerm.toLowerCase());
      }).toList();
      value = PublicationsListStateSuccess(
          _entity!, _filtredPublicationsBySeachTerm);
    } else {
      value = PublicationsListStateSuccess(_entity!, _publications);
    }
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
        value = PublicationsListStateSuccess(_entity!, _publications);
      },
      (failure) => value = PublicationsListStateFailure(_entity!, failure),
    );
  }
}
