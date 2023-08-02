import 'package:flutter/material.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';
import 'package:robsic/src/modules/members/domain/entities/members_entity.dart';
import 'package:robsic/src/modules/members/domain/usecases/get_members_data_usecase.dart';
import 'package:robsic/src/modules/members/domain/usecases/get_members_list_usecase.dart';
import 'package:robsic/src/modules/members/presentation/stores/members_states.dart';

class MembersStore extends ValueNotifier<MembersState> {
  MembersStore(this._getMembersDataUsecase, this._getMembersListUsecase)
      : super(const MembersStateIdle());

  final GetMembersDataUsecase _getMembersDataUsecase;
  final GetMembersListUsecase _getMembersListUsecase;

  MembersEntity? _entity;
  List<MemberEntity> _members = [];

  Future<void> getMembersData() async {
    value = const MembersStateLoading();
    final result = await _getMembersDataUsecase();
    result.fold(
      (entity) async {
        _entity = entity;
        await getMembersList();
      },
      (failure) => value = MembersStateFailure(failure),
    );
  }

  Future<void> getMembersList() async {
    value = MembersListStateLoading(_entity!);
    final result = await _getMembersListUsecase();
    result.fold(
      (members) {
        _members = members;
        value = MembersListStateSuccess(_entity!, _members);
      },
      (failure) => value = MembersListStateFailure(_entity!, failure),
    );
  }
}
