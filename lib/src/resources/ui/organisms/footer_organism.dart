import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../constants/constants.dart';
import '../../utils/utils.dart';
import '../atoms/atoms.dart';
import '../molecules/molecules.dart';
import '../tokens/tokens.dart';

class FooterOrganism extends StatefulWidget {
  const FooterOrganism({
    super.key,
  });

  @override
  State<FooterOrganism> createState() => _FooterOrganismState();
}

class _FooterOrganismState extends State<FooterOrganism> {
  late final UrlLauncherDriver _urlLauncher;
  late final AppMenusStore _appMenusStore;

  @override
  void initState() {
    super.initState();
    _appMenusStore = serviceLocator.get<AppMenusStore>();
    _urlLauncher = serviceLocator.get<UrlLauncherDriver>();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
      constraints: isMobile
          ? const BoxConstraints(minWidth: double.maxFinite)
          : const BoxConstraints(minWidth: double.maxFinite, maxHeight: 380),
      color: TokenColors.gray900,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          child: const Image(
                              image: ImagesAsset.assinHorComplUnifeiNeg),
                          onTap: () =>
                              _urlLauncher.launchUrl(EndPoints.unifeiSiteUrl),
                        ),
                        const SizedBox(height: TokenSpaces.md),
                        InkWell(
                          child:
                              const Image(image: ImagesAsset.robsicLogoFullHor),
                          onTap: () {
                            _appMenusStore.setMenu(AppMenus.home);
                            context.go(Routes.home);
                          },
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: TokenSpaces.md),
                    child: Divider(height: 2.0, color: Colors.green),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        LabelAtom(
                          text: AppLocalizations.of(context)!.linksLabel,
                          textStyle: TokenTextStyles.titleMedium.copyWith(
                            color: TokenColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FooterLinkMolecule(
                          onPressed: () {
                            _appMenusStore.setMenu(AppMenus.about);
                            context.go(Routes.about);
                          },
                          label: AppLocalizations.of(context)!.aboutUsLabel,
                        ),
                        FooterLinkMolecule(
                          onPressed: () {
                            _appMenusStore.setMenu(AppMenus.members);
                            context.go(Routes.members);
                          },
                          label: AppLocalizations.of(context)!.membersLabel,
                        ),
                        FooterLinkMolecule(
                          onPressed: () {
                            _appMenusStore.setMenu(AppMenus.projects);
                            context.go(Routes.projects);
                          },
                          label: AppLocalizations.of(context)!.projectsLabel,
                        ),
                        FooterLinkMolecule(
                          onPressed: () {
                            _appMenusStore.setMenu(AppMenus.publications);
                            context.go(Routes.publications);
                          },
                          label: AppLocalizations.of(context)!.publicationsLabel,
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: TokenSpaces.md),
                    child: Divider(height: 2.0, color: Colors.green),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
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
                        const SizedBox(height: TokenSpaces.md),
                        LabelAtom(
                          text: AppLocalizations.of(context)!.ourGroupAndMediaLabel,
                          textStyle: TokenTextStyles.titleMedium.copyWith(
                            color: TokenColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        FooterLinkMolecule(
                          onPressed: () {
                            _urlLauncher.launchUrl(EndPoints.cnpqGroupUrl);
                          },
                          label: AppLocalizations.of(context)!.cnpqGroupLabel,
                          icon: const Image(
                            image: ImagesAsset.logoCnpq,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        FooterLinkMolecule(
                          onPressed: () {
                            _urlLauncher.launchUrl(EndPoints.youtubeChannelUrl);
                          },
                          label: AppLocalizations.of(context)!.youtubeChannelLabel,
                          icon: const Image(
                            image: ImagesAsset.logoYoutube,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        FooterLinkMolecule(
                          onPressed: () {
                            _urlLauncher.launchUrl(EndPoints.githubUrl);
                          },
                          label: AppLocalizations.of(context)!.githubLabel,
                          icon: const Image(
                            image: ImagesAsset.logoGithub,
                            width: 20,
                            height: 20,
                          ),
                        ),
                        const SizedBox(height: TokenSpaces.xl),
                        LabelAtom(
                          text:
                              '© ${DateTime.now().year} RobSIC - ${AppLocalizations.of(context)!.allRightsReservedLabel}',
                          textStyle: TokenTextStyles.bodyMedium
                              .apply(color: TokenColors.secondary),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: InkWell(
                              child: const Image(
                                  image: ImagesAsset.assinHorComplUnifeiNeg),
                              onTap: () =>
                                  _urlLauncher.launchUrl(EndPoints.unifeiSiteUrl),
                            ),
                          ),
                          const SizedBox(height: TokenSpaces.md),
                          Flexible(
                            child: InkWell(
                              child:
                                  const Image(image: ImagesAsset.robsicLogoFullHor),
                              onTap: () {
                                _appMenusStore.setMenu(AppMenus.home);
                                context.go(Routes.home);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LabelAtom(
                            text: AppLocalizations.of(context)!.linksLabel,
                            textStyle: TokenTextStyles.titleMedium.copyWith(
                              color: TokenColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FooterLinkMolecule(
                            onPressed: () {
                              _appMenusStore.setMenu(AppMenus.about);
                              context.go(Routes.about);
                            },
                            label: AppLocalizations.of(context)!.aboutUsLabel,
                          ),
                          FooterLinkMolecule(
                            onPressed: () {
                              _appMenusStore.setMenu(AppMenus.members);
                              context.go(Routes.members);
                            },
                            label: AppLocalizations.of(context)!.membersLabel,
                          ),
                          FooterLinkMolecule(
                            onPressed: () {
                              _appMenusStore.setMenu(AppMenus.projects);
                              context.go(Routes.projects);
                            },
                            label: AppLocalizations.of(context)!.projectsLabel,
                          ),
                          FooterLinkMolecule(
                            onPressed: () {
                              _appMenusStore.setMenu(AppMenus.publications);
                              context.go(Routes.publications);
                            },
                            label: AppLocalizations.of(context)!.publicationsLabel,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.topCenter,
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
                          const SizedBox(height: TokenSpaces.md),
                          LabelAtom(
                            text: AppLocalizations.of(context)!.ourGroupAndMediaLabel,
                            textStyle: TokenTextStyles.titleMedium.copyWith(
                              color: TokenColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          FooterLinkMolecule(
                            onPressed: () {
                              _urlLauncher.launchUrl(EndPoints.cnpqGroupUrl);
                            },
                            label: AppLocalizations.of(context)!.cnpqGroupLabel,
                            icon: const Image(
                              image: ImagesAsset.logoCnpq,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          FooterLinkMolecule(
                            onPressed: () {
                              _urlLauncher.launchUrl(EndPoints.youtubeChannelUrl);
                            },
                            label: AppLocalizations.of(context)!.youtubeChannelLabel,
                            icon: const Image(
                              image: ImagesAsset.logoYoutube,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          FooterLinkMolecule(
                            onPressed: () {
                              _urlLauncher.launchUrl(EndPoints.githubUrl);
                            },
                            label: AppLocalizations.of(context)!.githubLabel,
                            icon: const Image(
                              image: ImagesAsset.logoGithub,
                              width: 20,
                              height: 20,
                            ),
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
                ],
              ),
      ),
    );
  }
}
