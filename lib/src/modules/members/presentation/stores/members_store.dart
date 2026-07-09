import 'package:flutter/material.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';
import 'package:robsic/src/modules/members/domain/entities/members_entity.dart';
import 'package:robsic/src/modules/members/domain/usecases/get_members_data_usecase.dart';
import 'package:robsic/src/modules/members/domain/usecases/get_members_list_usecase.dart';
import 'package:robsic/src/modules/members/presentation/stores/members_states.dart';
import 'package:diacritic/diacritic.dart';
class MembersStore extends ValueNotifier<MembersState> {
  MembersStore(this._getMembersDataUsecase, this._getMembersListUsecase)
      : super(const MembersStateIdle());

  final GetMembersDataUsecase _getMembersDataUsecase;
  final GetMembersListUsecase _getMembersListUsecase;

  MembersEntity? _entity;
  List<MemberEntity> _members = [];
  List<MemberEntity> _filtredMembersBySeachTerm = [];

  void searchTerm(String searchTerm) {
    value = MembersListStateLoading(_entity!);
    if (searchTerm.length > 3) {
      _filtredMembersBySeachTerm = _members.where((member) {
        String memberName = member.name.toLowerCase();
        return memberName.startsWith(searchTerm.toLowerCase());
      }).toList();
      value = MembersListStateSuccess(_entity!, _filtredMembersBySeachTerm);
    } else {
      value = MembersListStateSuccess(_entity!, _members);
    }
  }

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
    final locale = serviceLocator.get<AppStore>().value.fullLanguageCode;
    final result = await _getMembersListUsecase(preferredLocale: locale);
    result.fold(
      (members) {
        members.sort((a, b) {
          final nameA = removeDiacritics(a.name).toLowerCase();
          final nameB = removeDiacritics(b.name).toLowerCase();
          return nameA.compareTo(nameB);
        });
        _members = members;
        value = MembersListStateSuccess(_entity!, _members);
      },
      (failure) => value = MembersListStateFailure(_entity!, failure),
    );
  }

  /// Reprocessa a lista com o locale atual sem fazer nova requisição de rede.
  /// Chamado quando o usuário troca de idioma.
  Future<void> reprocessList() async {
    if (_entity == null) return;
    await getMembersList();
  }
}
