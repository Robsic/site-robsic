import 'package:robsic/src/modules/members/domain/entities/members_entity.dart';

import '../../../core/domain/failures/app_failures.dart';
import '../../../core/infra/adapters/header_adapter.dart';

class MembersAdapter {
  MembersAdapter._internal();

  static MembersEntity fromMap(Map<String, dynamic> map) {
    try {
      return MembersEntity(
        header: HeaderAdapter.fromMap(map['header']),
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
}
