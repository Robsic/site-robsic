import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/src/core/constants/routes.dart';
import 'package:robsic/src/core/ui/atoms/atoms.dart';
import 'package:robsic/src/core/ui/templates/drawer_template.dart';

import '../../../../core/ui/molecules/molecules.dart';

class CustomEndDrawer extends StatelessWidget {
  const CustomEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerTemplate(
      header: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back),
          )
        ],
      ),
      content: ListView(
        shrinkWrap: true,
        children: [
          DrawerMenuMolecule(
            label: 'About-us',
            onPressed: () => context.go(Routes.about),
            isSelected: true,
          ),
          DrawerMenuMolecule(
            label: 'Members',
            onPressed: () => context.go(Routes.members),
          ),
          DrawerMenuMolecule(
            label: 'Projects',
            onPressed: () => context.go(Routes.projects),
          ),
          DrawerMenuMolecule(
            label: 'Publications',
            onPressed: () => context.go(Routes.publications),
          ),
        ],
      ),
      footer: OutlinedButtonMolecule(
        label: LabelAtom(
          text: 'Contact Us'.toUpperCase(),
        ),
        onPressed: () => context.go(Routes.contact),
      ),
    );
  }
}
