import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/atoms/images_asset.dart';
import 'package:robsic/src/core/ui/atoms/label_atom.dart';
import 'package:robsic/src/core/ui/molecules/outlined_button_molecule.dart';
import 'package:robsic/src/core/ui/tokens/tokens.dart';

class AppBarOrganism extends StatelessWidget implements PreferredSizeWidget {
  const AppBarOrganism({super.key, this.height = 90.0, this.child});

  final Widget? child;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 1.0,
      child: Container(
        color: Theme.of(context).colorScheme.secondary.withOpacity(0.2),
        height: preferredSize.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: TokenSpaces.xxl,
            vertical: TokenSpaces.md,
          ),
          child: Row(children: [
            const Image(image: ImagesAsset.robsicLogo),
            const Spacer(),
            OutlinedButtonMolecule(
              label: LabelAtom(text: 'contact us'.toUpperCase()),
              onPressed: () {},
            ),
          ]),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
