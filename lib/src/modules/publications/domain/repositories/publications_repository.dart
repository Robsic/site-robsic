import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../entities/entities.dart';

abstract class PublicationsRepository {
  AsyncResult<PublicationsPageEntity, AppFailure> getPublicationsPageData();
  AsyncResult<List<PublicationEntity>, AppFailure> getPublicationsList();
}
