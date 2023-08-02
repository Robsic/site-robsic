import 'dart:developer';

import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/members/domain/entities/members_entity.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/members/domain/repositories/members_repository.dart';
import 'package:robsic/src/modules/members/infra/adapters/member_adapter.dart';
import 'package:robsic/src/modules/members/infra/adapters/members_adapter.dart';
import 'package:robsic/src/modules/members/infra/datasources/members_datasource.dart';

class MembersRepositoryImpl implements MembersRepository {
  final MembersDatasource _membersDatasource;

  MembersRepositoryImpl(this._membersDatasource);

  @override
  AsyncResult<MembersEntity, AppFailure> getMembersData() async {
    try {
      final result = await _membersDatasource.getMembersData();
      final entity = MembersAdapter.fromMap(result);
      return Success(entity);
    } on AppFailure catch (error) {
      log(error.toString());
      return Failure(error);
    }
  }

  @override
  AsyncResult<List<MemberEntity>, AppFailure> getMembersList() async {
    try {
      final result = await _membersDatasource.getMembersList();
      final membersList = MemberAdapter.fromList(result['data']);
      return Success(membersList);
    } on AppFailure catch (error) {
      log(error.toString());
      return Failure(error);
    }
  }
}
