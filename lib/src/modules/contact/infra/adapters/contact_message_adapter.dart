import 'package:robsic/src/modules/contact/infra/dtos/contact_message_dto.dart';

import '../../domain/domain.dart';

class ContactMessageAdapter {
  const ContactMessageAdapter._internal();

  static ContactMessageEntity fromDto(ContactMessageDto contactMessage) {
    return ContactMessageEntity(
      name: contactMessage.name ?? '',
      recipientMemberId: contactMessage.recipientMemberId,
      senderEmail: contactMessage.senderEmail ?? '',
      message: contactMessage.message ?? '',
    );
  }

  static Map<String, dynamic> toMap(ContactMessageEntity contactMessage) {
    return {
      'name': contactMessage.name,
      'recipientMemberId': contactMessage.recipientMemberId,
      'senderEmail': contactMessage.senderEmail,
      'message': contactMessage.message,
    };
  }
}
