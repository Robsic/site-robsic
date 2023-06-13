class PublicationEntity {
  final String title;
  final List<String> autors;
  final DateTime publicationDate;
  final String thumbUrl;
  final String abstract;
  final String urlLink;

  PublicationEntity({
    required this.title,
    required this.autors,
    required this.publicationDate,
    required this.thumbUrl,
    required this.abstract,
    required this.urlLink,
  });
}
