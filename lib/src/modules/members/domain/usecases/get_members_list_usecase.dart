import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';
import 'package:robsic/src/modules/members/domain/repositories/members_repository.dart';

class GetMembersListUsecase {
  final MembersRepository _membersRepository;

  GetMembersListUsecase(this._membersRepository);

  AsyncResult<List<MemberEntity>, AppFailure> call() async {
    final result = await _membersRepository.getMembersList();
    return result;
  }
}
