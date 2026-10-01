import 'package:flutter/material.dart';

import '../atoms/atoms.dart';
import '../tokens/tokens.dart';

class DrawerOrganism extends StatelessWidget {
  const DrawerOrganism({
    super.key,
    required this.header,
    required this.content,
    required this.footer,
  });

  final Widget header;
  final Widget content;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding:
            const EdgeInsets.only(top: TokenSpaces.xs, bottom: TokenSpaces.md),
        child: Column(
          children: [
            header,
            const SpaceAtom(
              spaceType: SpaceType.vertical,
              value: TokenSpaces.md,
            ),
            content,
            const Spacer(),
            footer,
          ],
        ),
      ),
    );
  }
}
