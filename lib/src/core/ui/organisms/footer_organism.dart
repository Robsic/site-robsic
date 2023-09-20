import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/core/constants/constants.dart';
import 'package:robsic/src/core/ui/atoms/images_asset.dart';
import 'package:robsic/src/core/ui/atoms/label_atom.dart';
import 'package:robsic/src/core/ui/molecules/footer_link_molecule.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../tokens/tokens.dart';

class FooterOrganism extends StatefulWidget {
  const FooterOrganism({
    super.key,
  });

  @override
  State<FooterOrganism> createState() => _FooterOrganismState();
}

class _FooterOrganismState extends State<FooterOrganism> {
  late final LaunchUrlService _launchUrlService;

  @override
  void initState() {
    super.initState();
    _launchUrlService = serviceLocator.get<LaunchUrlService>();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
      constraints: BoxConstraints(
          minWidth: double.maxFinite, maxHeight: isMobile ? 650 : 280),
      color: TokenColors.gray900,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment:
                      isMobile ? Alignment.centerLeft : Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: InkWell(
                          child: const Image(
                              image: ImagesAsset.assinHorComplUnifeiNeg),
                          onTap: () => _launchUrlService.launch(
                              url: EndPoints.unifeiSiteUrl),
                        ),
                      ),
                      const SizedBox(height: TokenSpaces.md),
                      Flexible(
                        child: InkWell(
                          child:
                              const Image(image: ImagesAsset.robsicLogoFullHor),
                          onTap: () => context.go(Routes.home),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isMobile)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: TokenSpaces.xs),
                  child: Divider(height: 2.0, color: Colors.green),
                ),
              Expanded(
                child: Container(
                  alignment:
                      isMobile ? Alignment.centerLeft : Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: TokenSpaces.xs,
                          right: TokenSpaces.xxs,
                          bottom: TokenSpaces.xxs,
                        ),
                        child: LabelAtom(
                          text: AppLocalizations.of(context)!.linksLabel,
                          textStyle: TokenTextStyles.titleMedium.copyWith(
                            color: TokenColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.about),
                        label: AppLocalizations.of(context)!.aboutUsLabel,
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.members),
                        label: AppLocalizations.of(context)!.membersLabel,
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.projects),
                        label: AppLocalizations.of(context)!.projectsLabel,
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.publications),
                        label: AppLocalizations.of(context)!.publicationsLabel,
                      ),
                    ],
                  ),
                ),
              ),
              if (isMobile)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: TokenSpaces.xs),
                  child: Divider(height: 2.0, color: Colors.green),
                ),
              Expanded(
                child: Container(
                  alignment:
                      isMobile ? Alignment.centerLeft : Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelAtom(
                        text: AppLocalizations.of(context)!.addressLabel,
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: TokenColors.primary,
                                fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: TokenSpaces.sm),
                      LabelAtom(
                        text:
                            'Rua irmã Ivone Drummond, 200 - Distrito Industrial II. Itabira-MG',
                        textStyle: TokenTextStyles.titleSmall
                            .copyWith(color: TokenColors.gray300),
                      ),
                      const Spacer(),
                      LabelAtom(
                        text:
                            '© ${DateTime.now().year} RobSIC - ${AppLocalizations.of(context)!.allRightsReservedLabel}',
                        textStyle: TokenTextStyles.bodyMedium
                            .apply(color: TokenColors.secondary),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
