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

  bool _isProfessor(String role) {
    final r = role.toLowerCase();
    return r.contains('profess') ||
        r.contains('pesquisad') ||
        r.contains('research') ||
        r.contains('diret') ||
        r.contains('direct') ||
        r.contains('coordenad') ||
        r.contains('coordinat') ||
        r.contains('faculty');
  }

  bool _isPhd(String role) {
    final r = role.toLowerCase();
    return r.contains('doutor') ||
        r.contains('phd') ||
        r.contains('ph.d') ||
        r.contains('postdoc') ||
        r.contains('post-doc');
  }

  bool _isMaster(String role) {
    final r = role.toLowerCase();
    return r.contains('mestra') ||
        r.contains('mestre') ||
        r.contains('master') ||
        r.contains('msc') ||
        r.contains('m.sc');
  }

  List<MemberEntity> get professors =>
      members.where((m) => _isProfessor(m.role.trim())).toList();

  List<MemberEntity> get phdStudents => members.where((m) {
        final role = m.role.trim();
        return !_isProfessor(role) && _isPhd(role);
      }).toList();

  List<MemberEntity> get masterStudents => members.where((m) {
        final role = m.role.trim();
        return !_isProfessor(role) && !_isPhd(role) && _isMaster(role);
      }).toList();

  List<MemberEntity> get undergraduateStudents => members.where((m) {
        final role = m.role.trim();
        return !_isProfessor(role) && !_isPhd(role) && !_isMaster(role);
      }).toList();

  List<MemberEntity> get students =>
      members.where((m) => !_isProfessor(m.role.trim())).toList();
}

class MembersListStateFailure extends MembersStateSuccess {
  final AppFailure failure;
  const MembersListStateFailure(
    super.membersEntity,
    this.failure,
  );
}
