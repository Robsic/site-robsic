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
