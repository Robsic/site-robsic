import 'package:robsic/src/modules/core/core.dart';

enum ResultType {
  publicacao,
  dataset,
  software,
  sistemaWeb,
  video,
  prototipo,
  patente,
  demonstracao;

  static ResultType fromString(String? value) {
    switch (value) {
      case 'dataset':
        return ResultType.dataset;
      case 'software':
        return ResultType.software;
      case 'sistema_web':
        return ResultType.sistemaWeb;
      case 'video':
        return ResultType.video;
      case 'prototipo':
        return ResultType.prototipo;
      case 'patente':
        return ResultType.patente;
      case 'demonstracao':
        return ResultType.demonstracao;
      case 'publicacao':
      default:
        return ResultType.publicacao;
    }
  }
}

class PublicationEntity {
  final String title;
  final String autors;
  final DateTime publicationDate;
  final String resume;
  final String urlLink;
  final ImageEntity? image;
  final ResultType resultType;

  PublicationEntity({
    required this.title,
    required this.autors,
    required this.publicationDate,
    required this.resume,
    required this.urlLink,
    this.image,
    this.resultType = ResultType.publicacao,
  });
}
