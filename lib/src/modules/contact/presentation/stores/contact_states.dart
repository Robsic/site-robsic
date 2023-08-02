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

  ContactStateSuccess(this.contactPage);
}

class ContactStateFailure extends ContactState {
  final AppFailure failure;
  const ContactStateFailure(this.failure);
}
