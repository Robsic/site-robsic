import 'package:flutter/material.dart';

import '../atoms/label_atom.dart';
import '../tokens/tokens.dart';

class DrawerMenuMolecule extends StatefulWidget {
  const DrawerMenuMolecule({
    super.key,
    required this.label,
    this.isSelected = false,
    this.onPressed,
  });

  final String label;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  State<DrawerMenuMolecule> createState() => _DrawerMenuMoleculeState();
}

class _DrawerMenuMoleculeState extends State<DrawerMenuMolecule> {
  double _bordeWidth = 5.0;
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
          border: widget.isSelected || _isHovered
              ? Border(
                  left: BorderSide(
                    color: TokenColors.emphasis,
                    width: _bordeWidth,
                  ),
                )
              : null,
          color: widget.isSelected ? TokenColors.emphasis20 : null),
      child: TextButton(
        onPressed: widget.onPressed,
        onHover: (value) {
          _isHovered = value;
          setState(() {
            if (value) {
              _bordeWidth = widget.isSelected ? 5.0 : 3.0;
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
            return TokenColors.gray700;
          }),
          textStyle:
              MaterialStateProperty.all<TextStyle>(TokenTextStyles.labelLarge),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              LabelAtom(
                text: widget.label.toUpperCase(),
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
