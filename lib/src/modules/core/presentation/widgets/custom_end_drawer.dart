import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../../../resources/resources.dart';

class CustomEndDrawer extends StatefulWidget {
  const CustomEndDrawer({super.key});

  @override
  State<CustomEndDrawer> createState() => _CustomEndDrawerState();
}

class _CustomEndDrawerState extends State<CustomEndDrawer> {
  late final AppMenusStore _appMenusStore;

  @override
  void initState() {
    super.initState();
    _appMenusStore = serviceLocator.get<AppMenusStore>();
  }

  @override
  Widget build(BuildContext context) {
    return DrawerTemplate(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: TokenSpaces.lg),
            child: SelectLanguage(),
          )
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          DrawerMenuMolecule(
            label: AppLocalizations.of(context)!.aboutUsLabel,
            onPressed: () {
              _appMenusStore.setMenu(AppMenus.about);
              context.go(Routes.about);
            },
            isSelected: _appMenusStore.isAboutPage,
          ),
          DrawerMenuMolecule(
            label: AppLocalizations.of(context)!.membersLabel,
            onPressed: () {
              _appMenusStore.setMenu(AppMenus.members);
              context.go(Routes.members);
            },
            isSelected: _appMenusStore.isMembersPage,
          ),
          DrawerMenuMolecule(
            label: AppLocalizations.of(context)!.projectsLabel,
            onPressed: () {
              _appMenusStore.setMenu(AppMenus.projects);
              context.go(Routes.projects);
            },
            isSelected: _appMenusStore.isProjectsPage,
          ),
          DrawerMenuMolecule(
            label: AppLocalizations.of(context)!.publicationsLabel,
            onPressed: () {
              _appMenusStore.setMenu(AppMenus.publications);
              context.go(Routes.publications);
            },
            isSelected: _appMenusStore.isPublicationsPage,
          ),
        ],
      ),
      footer: OutlinedButtonMolecule(
        label: LabelAtom(
          text: AppLocalizations.of(context)!.contactUsLabel.toUpperCase(),
        ),
        onPressed: () {
          _appMenusStore.setMenu(AppMenus.contact);
          context.go(Routes.contact);
        },
      ),
    );
  }
}
