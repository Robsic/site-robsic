import 'package:flutter/material.dart';

class OutlinedButtonMolecule extends StatelessWidget {
  const OutlinedButtonMolecule({
    super.key,
    this.onPressed,
    this.label,
  });

  final VoidCallback? onPressed;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: label,
    );
  }
}
