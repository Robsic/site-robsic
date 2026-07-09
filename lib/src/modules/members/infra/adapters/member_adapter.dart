import 'package:robsic/src/modules/core/infra/adapters/image_adapter.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';

import '../../../core/domain/failures/app_failures.dart';

class MemberAdapter {
  MemberAdapter._internal();

  static MemberEntity fromMap(Map<String, dynamic> map) {
    try {
      return MemberEntity(
        name: map['name'] ?? '',
        role: map['role'] ?? '',
        description: map['description'] ?? '',
        lattesUrl: map['lattes'] ?? '',
        orcidUrl: map['orcid'] ?? '',
        linkedinUrl: map['linkedin'] ?? '',
        email: map['email'] ?? '',
        canReceiveEmail: map['can_receive_email'] ?? false,
        photo: map['photo']?['data']?['attributes'] != null
            ? ImageAdapter.fromMap(map['photo']['data']['attributes'])
            : null,
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

  static List<MemberEntity> fromList(List list, {String preferredLocale = 'pt-BR'}) {
    try {
      return list.map((item) {
        final baseAttributes = item['attributes'] as Map<String, dynamic>;

        // Se o locale preferido for pt-BR, usa a base diretamente
        if (preferredLocale == 'pt-BR') return fromMap(baseAttributes);

        // Procura a tradução no idioma preferido dentro de localizations
        final localizations =
            baseAttributes['localizations']?['data'] as List? ?? [];
        final translated = localizations.cast<Map<String, dynamic>>().firstWhere(
              (loc) => loc['attributes']['locale'] == preferredLocale,
              orElse: () => <String, dynamic>{},
            );

        if (translated.isNotEmpty) {
          // Mescla: campos traduzíveis vêm da tradução; campos não-localizáveis
          // (photo, lattes, orcid, linkedin, email) vêm da base (pt-BR)
          final translatedAttrs =
              translated['attributes'] as Map<String, dynamic>;
          return fromMap({
            ...baseAttributes,
            'name': translatedAttrs['name'] ?? baseAttributes['name'],
            'role': translatedAttrs['role'] ?? baseAttributes['role'],
            'description':
                translatedAttrs['description'] ?? baseAttributes['description'],
          });
        }

        // Fallback: usa pt-BR
        return fromMap(baseAttributes);
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
