import 'package:result_dart/result_dart.dart';
import 'package:robsic/src/modules/core/domain/failures/app_failures.dart';

import '../entities/about_page_entity.dart';

abstract class AboutRepository {
  AsyncResult<AboutPageEntity, AppFailure> getAboutPageData();
}
