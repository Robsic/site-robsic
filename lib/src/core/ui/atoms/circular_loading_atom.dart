import 'package:flutter/material.dart';
import 'package:robsic/src/core/core.dart';

class CircularLoadingAtom extends StatelessWidget {
  const CircularLoadingAtom(
      {super.key, this.semanticLabel, this.semanticValue});

  final String? semanticLabel;
  final String? semanticValue;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: TokenColors.primary,
      semanticsLabel: semanticLabel,
      semanticsValue: semanticValue,
    );
  }
}
