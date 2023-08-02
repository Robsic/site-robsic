import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../entities/entities.dart';

abstract class ContactRepository {
  AsyncResult<ContactPageEntity, AppFailure> getContactPageData();
}
