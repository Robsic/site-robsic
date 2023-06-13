import 'package:flutter/material.dart';

import '../atoms/atoms.dart';
import '../tokens/tokens.dart';

class AppbarMenuMolecule extends StatefulWidget {
  const AppbarMenuMolecule({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  State<AppbarMenuMolecule> createState() => _AppbarMenuMoleculeState();
}

class _AppbarMenuMoleculeState extends State<AppbarMenuMolecule> {
  double _bordeWidth = 3.0;
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: widget.isSelected || _isHovered
            ? Border(
                bottom: BorderSide(
                  color: TokenColors.emphasis,
                  width: _bordeWidth,
                ),
              )
            : null,
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        onHover: (value) {
          _isHovered = value;
          setState(() {
            if (value) {
              _bordeWidth = widget.isSelected ? 3.0 : 1.5;
            }
          });
        },
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith((states) {
            if (widget.isSelected) {
              return TokenColors.gray900;
            } else if (states.contains(MaterialState.hovered) ||
                states.contains(MaterialState.focused)) {
              return TokenColors.gray900;
            } else if (states.contains(MaterialState.disabled)) {
              return TokenColors.gray400;
            }
            return TokenColors.gray800;
          }),
          textStyle:
              MaterialStateProperty.all<TextStyle>(TokenTextStyles.labelLarge),
        ),
        child: LabelAtom(
          text: widget.label.toUpperCase(),
        ),
      ),
    );
  }
}
