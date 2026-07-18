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
  static const _professorRoles = {'pesquisador', 'diretor', 'professor'};
  const MembersListStateSuccess(
    super.membersEntity,
    this.members,
  );

  List<MemberEntity> get professors =>
    members.where((m) {
      final role = m.role.trim().toLowerCase();
      return _professorRoles.contains(role) || role.contains('professor');
    }).toList();

  List<MemberEntity> get phdStudents =>
    members.where((m) {
      final role = m.role.trim().toLowerCase();
      return role.contains('doutoran') || role.contains('doutorado') || role.contains('phd');
    }).toList();

  List<MemberEntity> get masterStudents =>
    members.where((m) {
      final role = m.role.trim().toLowerCase();
      return role.contains('mestran') || role.contains('mestrado') || role.contains('master');
    }).toList();

  List<MemberEntity> get undergraduateStudents =>
    members.where((m) {
      final role = m.role.trim().toLowerCase();
      final isProf = _professorRoles.contains(role) || role.contains('professor');
      final isPhd = role.contains('doutoran') || role.contains('doutorado') || role.contains('phd');
      final isMaster = role.contains('mestran') || role.contains('mestrado') || role.contains('master');
      return !isProf && !isPhd && !isMaster;
    }).toList();

  List<MemberEntity> get students =>
    members.where((m) => !_professorRoles.contains(m.role.trim().toLowerCase())).toList();
}

class MembersListStateFailure extends MembersStateSuccess {
  final AppFailure failure;
  const MembersListStateFailure(
    super.membersEntity,
    this.failure,
  );
}
