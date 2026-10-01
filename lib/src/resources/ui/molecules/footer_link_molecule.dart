import 'package:flutter/material.dart';

import '../atoms/atoms.dart';
import '../tokens/tokens.dart';

class FooterLinkMolecule extends StatefulWidget {
  const FooterLinkMolecule({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  State<FooterLinkMolecule> createState() => _FooterLinkMoleculeState();
}

class _FooterLinkMoleculeState extends State<FooterLinkMolecule> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: widget.onPressed,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(horizontal: 0, vertical: 4),
        ),
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
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (widget.icon != null) ...[
            widget.icon!,
            const SizedBox(width: TokenSpaces.xs),
          ],
          LabelAtom(
            text: widget.label,
          ),
        ],
      ),
    );
  }
}
