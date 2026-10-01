import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';

import '../entities/about_page_entity.dart';
import '../repositories/about_repository.dart';

class GetAboutPageDataUsecase {
  final AboutRepository _aboutRepository;

  const GetAboutPageDataUsecase(this._aboutRepository);

  AsyncResult<AboutPageEntity, AppFailure> call() async {
    final result = await _aboutRepository.getAboutPageData();
    return result;
  }
}
