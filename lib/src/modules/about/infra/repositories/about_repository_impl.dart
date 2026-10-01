import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/about/domain/entities/about_page_entity.dart';
import 'package:robsic/src/modules/about/domain/repositories/about_repository.dart';
import 'package:robsic/src/modules/about/infra/adapters/about_page_adapter.dart';
import 'package:robsic/src/modules/about/infra/datasources/about_datasource.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';

class AboutRepositoryImpl implements AboutRepository {
  final AboutDatasource _aboutDatasource;

  AboutRepositoryImpl(this._aboutDatasource);
  @override
  AsyncResult<AboutPageEntity, AppFailure> getAboutPageData() async {
    try {
      final result = await _aboutDatasource.getAboutPageData();
      final aboutEntity = AboutPageAdapter.fromMap(result);
      return Success(aboutEntity);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }
}
