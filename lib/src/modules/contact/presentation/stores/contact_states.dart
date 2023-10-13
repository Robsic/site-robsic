import 'package:robsic/src/modules/core/core.dart';

import '../../domain/domain.dart';

abstract class ContactState {
  const ContactState();
}

class ContactStateIdle extends ContactState {
  const ContactStateIdle();
}

class ContactStateLoading extends ContactState {
  const ContactStateLoading();
}

class ContactStateSuccess extends ContactState {
  final ContactPageEntity contactPage;

  const ContactStateSuccess(this.contactPage);
}

class ContactStateFailure extends ContactState {
  final AppFailure failure;
  const ContactStateFailure(this.failure);
}

class SendContactMessageStateLoading extends ContactStateSuccess {
  const SendContactMessageStateLoading(super.contactPage);
}

class SendContactMessageStateSuccess extends ContactStateSuccess {
  const SendContactMessageStateSuccess(super.contactPage);
}

class SendContactMessageStateFailure extends ContactStateSuccess {
  final AppFailure failure;
  const SendContactMessageStateFailure(super.contactPage, this.failure);
}
