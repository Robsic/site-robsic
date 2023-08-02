import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';
import 'package:robsic/src/modules/members/domain/entities/members_entity.dart';

abstract class MembersState {
  const MembersState();
}

class MembersStateIdle extends MembersState {
  const MembersStateIdle();
}

class MembersStateLoading extends MembersState {
  const MembersStateLoading();
}

class MembersStateSuccess extends MembersState {
  final MembersEntity membersEntity;
  const MembersStateSuccess(this.membersEntity);
}

class MembersStateFailure extends MembersState {
  final AppFailure failure;
  const MembersStateFailure(this.failure);
}

class MembersListStateLoading extends MembersStateSuccess {
  const MembersListStateLoading(super.membersEntity);
}

class MembersListStateSuccess extends MembersStateSuccess {
  final List<MemberEntity> members;
  const MembersListStateSuccess(
    super.membersEntity,
    this.members,
  );
}

class MembersListStateFailure extends MembersStateSuccess {
  final AppFailure failure;
  const MembersListStateFailure(
    super.membersEntity,
    this.failure,
  );
}
