import 'package:robsic/src/modules/core/core.dart';

class PublicationEntity {
  final String title;
  final String autors;
  final DateTime publicationDate;
  final String resume;
  final String urlLink;
  final ImageEntity? image;

  PublicationEntity({
    required this.title,
    required this.autors,
    required this.publicationDate,
    required this.resume,
    required this.urlLink,
    this.image,
  });
}
