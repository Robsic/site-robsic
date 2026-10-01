import 'package:result_dart/result_dart.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../adapters/adapters.dart';
import '../datasources/datasources.dart';

class ContactRepositoryImpl implements ContactRepository {
  final ContactDatasource _contactDatasource;

  ContactRepositoryImpl(this._contactDatasource);
  @override
  AsyncResult<ContactPageEntity, AppFailure> getContactPageData() async {
    try {
      final result = await _contactDatasource.getContactpageData();
      final contactEntity = ContactPageAdapter.fromMap(result);
      return Success(contactEntity);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }

  @override
  AsyncResult<ContactMessageEntity, AppFailure> sendContactMessage(
      ContactMessageEntity contactMessage) async {
    try {
      final contactMessageData = ContactMessageAdapter.toMap(contactMessage);
      await _contactDatasource.sendContactMessage(contactMessageData);
      return Success(contactMessage);
    } on AppFailure catch (error) {
      return Failure(error);
    }
  }
}
