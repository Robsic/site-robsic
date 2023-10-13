import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/core/constants/constants.dart';
import 'package:robsic/src/core/ui/atoms/atoms.dart';
import 'package:robsic/src/core/ui/molecules/elevated_button_molecule.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';
import 'package:robsic/src/core/ui/tokens/tokens.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';
import 'package:robsic/src/modules/contact/domain/domain.dart';
import 'package:robsic/src/modules/contact/infra/dtos/contact_message_dto.dart';
import 'package:robsic/src/modules/contact/presentation/stores/stores.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../../../app_store.dart';
import '../widgets/custom_text_form_field.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  late ContactMessageDto contactMessage;
  late final ContactStore _contactStore;
  late final AppStore _appStore;

  @override
  void initState() {
    super.initState();
    contactMessage = ContactMessageDto();
    _appStore = serviceLocator.get<AppStore>();
    _appStore.addListener(_reloadData);
    _contactStore = serviceLocator.get<ContactStore>();
    _contactStore.addListener(() => _showCustomDialog(context));
    _contactStore.getContactPageData();
  }

  void _reloadData() => _contactStore.getContactPageData();

  @override
  void dispose() {
    _appStore.removeListener(_reloadData);
    super.dispose();
  }

  void _showCustomDialog(BuildContext context) {
    Navigator.popUntil(context, ModalRoute.withName(Routes.contact));
    if (_contactStore.value is SendContactMessageStateLoading) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
    } else if (_contactStore.value is SendContactMessageStateFailure) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              title: Text('Erro'),
              content: BodyTextAtom(text: 'Erro ao enviar o email!'),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveUtils.isDesktop(context);
    return DefaultPageScaffold(
      child: ValueListenableBuilder(
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
                    constraints: const BoxConstraints(maxHeight: 650.0),
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomTextFormField(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .nameLabel,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .yourNameLabel,
                                        ),
                                        const SpaceAtom(
                                            spaceType: SpaceType.vertical,
                                            value: TokenSpaces.lg),
                                        CustomTextFormField(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .emailLabel,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .emailPlaceholder,
                                        ),
                                        const SpaceAtom(
                                            spaceType: SpaceType.vertical,
                                            value: TokenSpaces.lg),
                                        CustomTextFormField(
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .messageLabel,
                                          hintText:
                                              AppLocalizations.of(context)!
                                                  .typeYourMessageHere
                                                  .toLowerCase(),
                                          maxLines: 6,
                                        ),
                                        const SpaceAtom(
                                            spaceType: SpaceType.vertical,
                                            value: TokenSpaces.lg),
                                        ElevatedButtonMolecule(
                                          label: state
                                                  is SendContactMessageStateLoading
                                              ? const CircularProgressIndicator()
                                              : LabelAtom(
                                                  text: AppLocalizations.of(
                                                          context)!
                                                      .sendEmailLabel
                                                      .toUpperCase(),
                                                ),
                                          onPressed: state
                                                  is SendContactMessageStateLoading
                                              ? null
                                              : () {
                                                  _contactStore.sendContactMessage(
                                                      ContactMessageEntity(
                                                          name: 'Nilson Soares',
                                                          senderEmail:
                                                              'nilsonsoares2011@outlook.com',
                                                          message:
                                                              'Olá, esta é uma mensagem de teste!'));
                                                },
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
                              ),
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
}
