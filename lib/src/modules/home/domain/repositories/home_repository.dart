import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';
import 'package:robsic/src/modules/home/domain/entities/home_page_entity.dart';

abstract class HomeRepository {
  AsyncResult<HomePageEntity, AppFailure> getHomeData();
}
