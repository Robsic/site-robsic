import '../../../../core/core.dart';

class ContactMessageEntity {
  final String name;
  final String? recipientEmail;
  final String senderEmail;
  final String message;

  ContactMessageEntity({
    required this.name,
    this.recipientEmail,
    required this.senderEmail,
    required this.message,
  });

  bool validate() {
    bool isValidName = _validName();
    bool isValidRecipientEmail = _validRecipientEmail();
    bool isValidSenderEmail = _validSenderEmail();
    bool isValidMessage = _validMessage();

    return isValidName &&
        isValidRecipientEmail &&
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

  bool _validRecipientEmail() {
    if (recipientEmail == null) {
      return true;
    } else {
      return _validateEmailPattern(recipientEmail!);
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
