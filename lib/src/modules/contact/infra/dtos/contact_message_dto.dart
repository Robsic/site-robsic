class ContactMessageDto {
  String? name;
  String? recipientEmail;
  String? senderEmail;
  String? message;

  ContactMessageDto({
    this.name,
    this.senderEmail,
    this.recipientEmail,
    this.message,
  });
}
