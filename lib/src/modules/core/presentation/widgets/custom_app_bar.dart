import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/core/core.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height = 90.0,
  });

  final double height;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool isDesktop;

  late final AppMenusStore _appMenusStore;
  late final UrlLauncherDriver _urlLauncher;

  @override
  void initState() {
    super.initState();
    _appMenusStore = serviceLocator.get<AppMenusStore>();
    _urlLauncher = serviceLocator.get<UrlLauncherDriver>();
  }

  @override
  Widget build(BuildContext context) {
    isDesktop = ResponsiveUtils.isDesktop(context);
    return AppbarTemplate(
      height: widget.height,
      leading: Row(
        children: [
          InkWell(
            child: const Image(
                image: ImagesAsset.assinHorUnifeiPos, fit: BoxFit.fitHeight),
            onTap: () => _urlLauncher.launchUrl(EndPoints.unifeiSiteUrl),
          ),
          const SpaceAtom(
              spaceType: SpaceType.horizontal, value: TokenSpaces.lg),
          InkWell(
            child: const Image(
                image: ImagesAsset.robsicLogo, fit: BoxFit.fitHeight),
            onTap: () {
              _appMenusStore.setMenu(AppMenus.home);
              context.go(Routes.home);
            },
          ),
        ],
      ),
      trailing: Visibility(
        visible: MediaQuery.of(context).size.width < 1200.0,
        child: IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      child: MediaQuery.of(context).size.width >= 1200.0
          ? Row(
              children: [
                AppbarMenuMolecule(
                  label: AppLocalizations.of(context)!.aboutUsLabel,
                  onPressed: () {
                    _appMenusStore.setMenu(AppMenus.about);
                    context.go(Routes.about);
                  },
                  isSelected: _appMenusStore.isAboutPage,
                ),
                const SizedBox(width: TokenSpaces.lg),
                AppbarMenuMolecule(
                    label: AppLocalizations.of(context)!.membersLabel,
                    onPressed: () {
                      _appMenusStore.setMenu(AppMenus.members);
                      context.go(Routes.members);
                    },
                    isSelected: _appMenusStore.isMembersPage),
                const SizedBox(width: TokenSpaces.lg),
                AppbarMenuMolecule(
                    label: AppLocalizations.of(context)!.projectsLabel,
                    onPressed: () {
                      _appMenusStore.setMenu(AppMenus.projects);
                      context.go(Routes.projects);
                    },
                    isSelected: _appMenusStore.isProjectsPage),
                const SizedBox(width: TokenSpaces.lg),
                AppbarMenuMolecule(
                    label: AppLocalizations.of(context)!.publicationsLabel,
                    onPressed: () {
                      _appMenusStore.setMenu(AppMenus.publications);
                      context.go(Routes.publications);
                    },
                    isSelected: _appMenusStore.isPublicationsPage),
                const SpaceAtom(
                  spaceType: SpaceType.horizontal,
                  value: TokenSpaces.md,
                ),
                OutlinedButtonMolecule(
                  label: LabelAtom(
                      text: AppLocalizations.of(context)!
                          .contactUsLabel
                          .toUpperCase()),
                  onPressed: () {
                    _appMenusStore.setMenu(AppMenus.contact);
                    context.go(Routes.contact);
                  },
                ),
                const SpaceAtom(
                  spaceType: SpaceType.horizontal,
                  value: TokenSpaces.md,
                ),
                const SelectLanguage(),
              ],
            )
          : null,
    );
  }
}
