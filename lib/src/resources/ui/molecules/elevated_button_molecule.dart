import 'package:flutter/material.dart';

class ElevatedButtonMolecule extends StatelessWidget {
  const ElevatedButtonMolecule({
    super.key,
    this.onPressed,
    this.label,
  });

  final VoidCallback? onPressed;
  final Widget? label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: label,
    );
  }
}
