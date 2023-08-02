import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';
import 'package:robsic/src/modules/members/domain/entities/members_entity.dart';

abstract class MembersRepository {
  AsyncResult<MembersEntity, AppFailure> getMembersData();
  AsyncResult<List<MemberEntity>, AppFailure> getMembersList();
}
