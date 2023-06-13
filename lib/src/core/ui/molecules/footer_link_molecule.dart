import 'package:flutter/material.dart';

import '../atoms/label_atom.dart';
import '../tokens/tokens.dart';

class FooterLinkMolecule extends StatefulWidget {
  const FooterLinkMolecule({
    super.key,
    required this.label,
    this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  State<FooterLinkMolecule> createState() => _FooterLinkMoleculeState();
}

class _FooterLinkMoleculeState extends State<FooterLinkMolecule> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.hovered) ||
              states.contains(MaterialState.focused)) {
            return TokenColors.gray50;
          } else if (states.contains(MaterialState.disabled)) {
            return TokenColors.gray400;
          }
          return TokenColors.gray300;
        }),
        textStyle:
            MaterialStateProperty.all<TextStyle>(TokenTextStyles.titleSmall),
      ),
      child: LabelAtom(
        text: widget.label,
      ),
    );
  }
}
