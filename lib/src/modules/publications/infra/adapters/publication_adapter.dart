import 'package:robsic/src/modules/publications/domain/domain.dart';

import '../../../core/core.dart';

class PublicationAdapter {
  const PublicationAdapter._internal();

  static PublicationEntity fromMap(Map<String, dynamic> map) {
    try {
      return PublicationEntity(
        title: map['title'] ?? '',
        autors: map['authors'] ?? '',
        resume: map['abstract'] ?? '',
        publicationDate: DateTime.parse(map['publication_date']),
        image: map['image']?['data']?['attributes'] != null
            ? ImageAdapter.fromMap(map['image']?['data']?['attributes'])
            : null,
        urlLink: map['url'] ?? '',
      );
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  static List<PublicationEntity> fromList(List list) {
    try {
      return list.map((publication) {
        return fromMap(publication['attributes']);
      }).toList();
    } on AppFailure {
      rethrow;
    } on FormatException catch (error, stackTrace) {
      throw FormatExceptionFailure(
        error: error,
        stackTrace: stackTrace,
      );
    }
  }
}
