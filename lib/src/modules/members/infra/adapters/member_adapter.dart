import 'package:robsic/src/modules/core/infra/adapters/image_adapter.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';

import '../../../core/domain/failures/app_failures.dart';

class MemberAdapter {
  MemberAdapter._internal();

  static MemberEntity fromMap(Map<String, dynamic> map) {
    try {
      return MemberEntity(
        name: map['name'],
        role: map['role'],
        description: map['description'],
        lattesUrl: map['lattes'] ?? '',
        orcidUrl: map['orcid'] ?? '',
        linkedinUrl: map['linkedin'] ?? '',
        email: map['email'] ?? '',
        canReceiveEmail: map['can_receive_email'] ?? false,
        photo: map['photo']?['data']?['attibutes'] != null
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

  static List<MemberEntity> fromList(List list) {
    try {
      return list.map((member) => fromMap(member['attributes'])).toList();
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
