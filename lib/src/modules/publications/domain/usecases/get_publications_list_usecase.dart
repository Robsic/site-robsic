import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class GetPublicationsListUsecase {
  final PublicationsRepository _publicationsRepository;

  GetPublicationsListUsecase(this._publicationsRepository);
  AsyncResult<List<PublicationEntity>, AppFailure> call() async {
    final result = await _publicationsRepository.getPublicationsList();
    return result;
  }
}
