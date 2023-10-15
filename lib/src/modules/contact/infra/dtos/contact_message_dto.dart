class ContactMessageDto {
  String? name;
  String? recipientMemberId;
  String? senderEmail;
  String? message;

  ContactMessageDto({
    this.name,
    this.senderEmail,
    this.recipientMemberId,
    this.message,
  });
}
