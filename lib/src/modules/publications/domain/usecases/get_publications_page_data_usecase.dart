import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetPublicationsPageDataUsecase {
  final PublicationsRepository _publicationsRepository;

  GetPublicationsPageDataUsecase(this._publicationsRepository);
  AsyncResult<PublicationsPageEntity, AppFailure> call() async {
    final result = await _publicationsRepository.getPublicationsPageData();
    return result;
  }
}
