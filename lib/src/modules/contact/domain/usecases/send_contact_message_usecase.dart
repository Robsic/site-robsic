import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../entities/entities.dart';
import '../repositories/repositories.dart';

class SendContactMessageUsecase {
  final ContactRepository _contactRepository;

  SendContactMessageUsecase(this._contactRepository);
  AsyncResult<ContactMessageEntity, AppFailure> call(
      ContactMessageEntity contactMessage) async {
    final bool isValidMessage = contactMessage.validate();
    if (!isValidMessage) {
      return const Failure(InvalidContactmessageFailure());
    } else {
      final result =
          await _contactRepository.sendContactMessage(contactMessage);
      return result;
    }
  }
}
