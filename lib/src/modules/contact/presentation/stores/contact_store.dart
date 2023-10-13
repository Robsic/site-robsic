import 'package:flutter/material.dart';

import '../../domain/domain.dart';
import 'contact_states.dart';

class ContactStore extends ValueNotifier<ContactState> {
  ContactStore(this._getContactPageDataUsecase, this._sendContactMessageUsecase)
      : super(const ContactStateIdle());

  final GetContactPageDataUsecase _getContactPageDataUsecase;
  final SendContactMessageUsecase _sendContactMessageUsecase;

  ContactPageEntity? _entity;

  Future<void> getContactPageData() async {
    value = const ContactStateLoading();
    final result = await _getContactPageDataUsecase();
    result.fold(
      (entity) {
        _entity = entity;
        value = ContactStateSuccess(_entity!);
      },
      (failure) => value = ContactStateFailure(failure),
    );
  }

  Future<void> sendContactMessage(ContactMessageEntity contactMessage) async {
    value = SendContactMessageStateLoading(_entity!);
    await Future.delayed(const Duration(seconds: 2));
    final result = await _sendContactMessageUsecase(contactMessage);
    result.fold(
      (_) => value = SendContactMessageStateSuccess(_entity!),
      (failure) => value = SendContactMessageStateFailure(_entity!, failure),
    );
  }
}
