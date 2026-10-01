import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../adapters/adapters.dart';
import '../datasources/datasources.dart';

class PublicationsRepositoryImpl implements PublicationsRepository {
  final PublicationsDatasource _publicationsDatasource;

  PublicationsRepositoryImpl(this._publicationsDatasource);

  @override
  AsyncResult<List<PublicationEntity>, AppFailure> getPublicationsList() async {
    try {
      final result = await _publicationsDatasource.getPublicationsList();
      final publicationsList = PublicationAdapter.fromList(result['data']);
      return Success(publicationsList);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }

  @override
  AsyncResult<PublicationsPageEntity, AppFailure>
      getPublicationsPageData() async {
    try {
      final result = await _publicationsDatasource.getPublicationsPageData();
      final publicationsPageEntity = PublicationsPageAdapter.fromMap(result);
      return Success(publicationsPageEntity);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }
}
