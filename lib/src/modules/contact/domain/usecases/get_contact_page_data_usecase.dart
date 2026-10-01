import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../domain.dart';

class GetContactPageDataUsecase {
  final ContactRepository _contactRepository;

  GetContactPageDataUsecase(this._contactRepository);
  AsyncResult<ContactPageEntity, AppFailure> call() async {
    final result = await _contactRepository.getContactPageData();
    return result;
  }
}
