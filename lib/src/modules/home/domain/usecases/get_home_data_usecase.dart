import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/home/domain/entities/home_page_entity.dart';
import 'package:robsic/src/modules/home/domain/repositories/home_repository.dart';

class GetHomeDataUsecase {
  final HomeRepository _homeRepository;

  GetHomeDataUsecase(this._homeRepository);

  AsyncResult<HomePageEntity, AppFailure> call() async {
    final result = await _homeRepository.getHomeData();
    return result;
  }
}
