import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../../../app_store.dart';
import '../../../../resources/resources.dart';
import '../../domain/domain.dart';
import '../../infra/infra.dart';
import '../stores/stores.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late ContactMessageDto contactMessageDto;
  late final ContactStore _contactStore;
  late final AppStore _appStore;
  late final GlobalKey<FormState> _contactFormkey;
  late final VoidCallback _handleErrors;

  @override
  void initState() {
    super.initState();
    contactMessageDto = ContactMessageDto();
    _contactFormkey = GlobalKey<FormState>();
    _appStore = serviceLocator.get<AppStore>();
    _appStore.addListener(_reloadData);
    _contactStore = serviceLocator.get<ContactStore>();
    _handleErrors = () => _handleSendMessageStates(context);
    _contactStore.addListener(_handleErrors);
    _contactStore.getContactPageData();
  }

  void _reloadData() => _contactStore.getContactPageData();

  bool _validateForm() {
    return _contactFormkey.currentState?.validate() ?? false;
  }

  void _sendMessage() {
    bool isFormValid = _validateForm();
    if (isFormValid) {
      final ContactMessageEntity contactMessage =
          ContactMessageAdapter.fromDto(contactMessageDto);
      _contactStore.sendContactMessage(contactMessage);
    }
  }

  @override
  void dispose() {
    _appStore.removeListener(_reloadData);
    _contactStore.removeListener(_handleErrors);
    super.dispose();
  }

  void _handleSendMessageStates(BuildContext context) {
    if (_contactStore.value is SendContactMessageStateLoading) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return const Center(child: CircularLoadingAtom());
          });
    } else if (_contactStore.value is SendContactMessageStateSuccess) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          context,
          snackBarType: SnackBarType.success,
          message: AppLocalizations.of(context)!.sendMessageSuccess,
        ),
      );
    } else if (_contactStore.value is SendContactMessageStateFailure) {
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        customSnackBar(
          context,
          snackBarType: SnackBarType.error,
          message: AppLocalizations.of(context)!.sendMessageError,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveUtils.isDesktop(context);
    return DefaultPageScaffold(
      child: ValueListenableBuilder<ContactState>(
        valueListenable: _contactStore,
        builder: (context, state, _) {
          if (state is ContactStateFailure) {
            return PageError(
              errorMessage: AppLocalizations.of(context)!.errorLoadingPage,
              reloadAction: () => _contactStore.getContactPageData(),
            );
          } else if (state is ContactStateSuccess) {
            ContactPageEntity contactPageData = state.contactPage;
            HeaderSectionEntity? headerSection = contactPageData.headerSection;
            return SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DefaultHeaderSection(
                    title: headerSection?.title ?? '',
                    text: headerSection?.content ?? '',
                  ),
                  Container(
                    constraints: const BoxConstraints(maxHeight: 700.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 40.0),
                            child: FractionallySizedBox(
                              widthFactor: 0.8,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  LabelAtom(
                                    text: AppLocalizations.of(context)!
                                        .sendAMessageLabel
                                        .toUpperCase(),
                                    textStyle: TokenTextStyles.headlineSmall,
                                  ),
                                  const SpaceAtom(
                                      spaceType: SpaceType.vertical,
                                      value: TokenSpaces.lg),
                                  Form(
                                    key: _contactFormkey,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextFormField(
                                          initialValue: contactMessageDto.name,
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .nameLabel,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .yourNameLabel,
                                          onChanged: (name) => contactMessageDto
                                              .name = name.trim(),
                                          validator: (name) =>
                                              nameValidator(context, name),
                                        ),
                                        const SpaceAtom(
                                            spaceType: SpaceType.vertical,
                                            value: TokenSpaces.lg),
                                        CustomTextFormField(
                                          initialValue:
                                              contactMessageDto.senderEmail,
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .emailLabel,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .emailPlaceholder,
                                          onChanged: (senderEmail) =>
                                              contactMessageDto.senderEmail =
                                                  senderEmail.trim(),
                                          validator: (email) =>
                                              emailValidator(context, email),
                                        ),
                                        const SpaceAtom(
                                            spaceType: SpaceType.vertical,
                                            value: TokenSpaces.lg),
                                        CustomTextFormField(
                                          initialValue:
                                              contactMessageDto.message,
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .messageLabel,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .typeYourMessageHere
                                                  .toLowerCase(),
                                          maxLines: 6,
                                          onChanged: (message) =>
                                              contactMessageDto.message =
                                                  message,
                                          validator: (message) =>
                                              messageValidator(
                                                  context, message),
                                        ),
                                        const SpaceAtom(
                                            spaceType: SpaceType.vertical,
                                            value: TokenSpaces.lg),
                                        ElevatedButtonMolecule(
                                          label: LabelAtom(
                                            text: AppLocalizations.of(context)!
                                                .sendEmailLabel
                                                .toUpperCase(),
                                          ),
                                          onPressed: () => _sendMessage(),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        if (isDesktop)
                          Expanded(
                            child: SizedBox(
                              height: double.infinity,
                              child: CachedNetworkImage(
                                  imageUrl: EndPoints.baseUrl +
                                      (contactPageData.image?.url ?? ''),
                                  fit: BoxFit.fitHeight,
                                  alignment: Alignment.centerLeft,
                                  errorWidget: (context, _, __) =>
                                      const LoadImageError()),
                            ),
                          )
                      ],
                    ),
                  ),
                  const FooterOrganism(),
                ],
              ),
            );
          } else {
            return const PageLoading();
          }
        },
      ),
    );
  }

  String? nameValidator(BuildContext context, String? name) {
    FieldValidator validator = Validators.nameValidator(name);
    if (validator is EmptyField) {
      return AppLocalizations.of(context)!.emptyFieldErrorMessage;
    } else if (validator is InvalidName) {
      return AppLocalizations.of(context)!.invalidNameMessage;
    }
    return null;
  }

  String? emailValidator(BuildContext context, String? email) {
    FieldValidator validator = Validators.emailValidator(email);
    if (validator is EmptyField) {
      return AppLocalizations.of(context)!.emptyFieldErrorMessage;
    } else if (validator is InvalidEmail) {
      return AppLocalizations.of(context)!.invalidEmailMessage;
    }
    return null;
  }

  String? messageValidator(BuildContext context, String? message) {
    FieldValidator validator = Validators.messageValidator(message);
    if (validator is EmptyField) {
      return AppLocalizations.of(context)!.emptyFieldErrorMessage;
    }
    return null;
  }
}
