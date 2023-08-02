import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/members/domain/entities/members_entity.dart';
import 'package:robsic/src/modules/members/domain/repositories/members_repository.dart';

class GetMembersDataUsecase {
  final MembersRepository _membersRepository;

  GetMembersDataUsecase(this._membersRepository);
  AsyncResult<MembersEntity, AppFailure> call() async {
    final result = await _membersRepository.getMembersData();
    return result;
  }
}
