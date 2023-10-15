import '../../../../resources/resources.dart';

class ContactMessageEntity {
  final String name;
  final String? recipientMemberId;
  final String senderEmail;
  final String message;

  ContactMessageEntity({
    required this.name,
    this.recipientMemberId,
    required this.senderEmail,
    required this.message,
  });

  bool validate() {
    bool isValidName = _validName();
    bool isValidRecipientMemberId = _validRecipientMemberId();
    bool isValidSenderEmail = _validSenderEmail();
    bool isValidMessage = _validMessage();

    return isValidName &&
        isValidRecipientMemberId &&
        isValidSenderEmail &&
        isValidMessage;
  }

  bool _validName() {
    if (!RegexUtils.fullNameRegex.hasMatch(name)) {
      return false;
    }
    return true;
  }

  bool _validSenderEmail() {
    return _validateEmailPattern(senderEmail);
  }

  bool _validRecipientMemberId() {
    if (recipientMemberId == null) {
      return true;
    } else {
      int? integerRecipientMemberId = int.tryParse(recipientMemberId!);
      if (integerRecipientMemberId == null) {
        return false;
      }
      return integerRecipientMemberId > 0;
    }
  }

  bool _validateEmailPattern(String email) {
    return RegexUtils.emailRegex.hasMatch(email);
  }

  bool _validMessage() {
    if (message.isEmpty) {
      return false;
    }
    return true;
  }
}
