import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'contact_states.dart';

class ContactStore extends ValueNotifier<ContactState> {
  ContactStore(this._getContactPageDataUsecase)
      : super(const ContactStateIdle());

  final GetContactPageDataUsecase _getContactPageDataUsecase;

  Future<void> getContactPageData() async {
    value = const ContactStateLoading();
    final result = await _getContactPageDataUsecase();
    result.fold(
      (entity) => value = ContactStateSuccess(entity),
      (failure) => value = ContactStateFailure(failure),
    );
  }
}
