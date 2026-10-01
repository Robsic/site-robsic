import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/home/domain/entities/home_page_entity.dart';
import 'package:robsic/src/modules/home/domain/repositories/home_repository.dart';
import 'package:robsic/src/modules/home/infra/adapters/home_page_adapter.dart';
import 'package:robsic/src/modules/home/infra/datasources/home_datasource.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasource _homeDatasource;

  HomeRepositoryImpl(this._homeDatasource);
  @override
  AsyncResult<HomePageEntity, AppFailure> getHomeData() async {
    try {
      final result = await _homeDatasource.getHomeData();
      final homeEntity = HomeAdapter.fromMap(result);
      return Success(homeEntity);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }
}
