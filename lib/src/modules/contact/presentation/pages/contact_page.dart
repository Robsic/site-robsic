import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/src/core/ui/atoms/atoms.dart';
import 'package:robsic/src/core/ui/molecules/elevated_button_molecule.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';
import 'package:robsic/src/core/ui/tokens/tokens.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../widgets/custom_text_form_field.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveUtils.isDesktop(context);
    return DefaultPageScaffold(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const DefaultHeaderSection(
              title: 'Contact Us',
              text: 'Questions or partnerships? Send a message to our team.',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextFormFIeld(
                                    labelText:
                                        AppLocalizations.of(context)!.nameLabel,
                                    hintText: AppLocalizations.of(context)!
                                        .yourNameLabel,
                                  ),
                                  const SpaceAtom(
                                      spaceType: SpaceType.vertical,
                                      value: TokenSpaces.lg),
                                  CustomTextFormFIeld(
                                    labelText: AppLocalizations.of(context)!
                                        .emailLabel,
                                    hintText: AppLocalizations.of(context)!
                                        .emailPlaceholder,
                                  ),
                                  const SpaceAtom(
                                      spaceType: SpaceType.vertical,
                                      value: TokenSpaces.lg),
                                  CustomTextFormFIeld(
                                    labelText: AppLocalizations.of(context)!
                                        .messageLabel,
                                    hintText: AppLocalizations.of(context)!
                                        .typeYourMessageHere
                                        .toLowerCase(),
                                    maxLines: 6,
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
                                    onPressed: () {},
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
                          imageUrl:
                              'https://images.unsplash.com/uploads/141103282695035fa1380/95cdfeef?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1730&q=80',
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
      ),
    );
  }
}
