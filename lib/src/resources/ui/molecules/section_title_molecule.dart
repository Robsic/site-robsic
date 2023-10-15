import 'package:flutter/material.dart';

import '../atoms/atoms.dart';
import '../tokens/tokens.dart';

enum SectionTitleStyle { onLightBackground, onDarkBackground }

class SectionTitleMolecule extends StatefulWidget {
  const SectionTitleMolecule({
    super.key,
    required this.title,
    required this.sectionTitleStyle,
  });

  final String title;
  final SectionTitleStyle sectionTitleStyle;

  @override
  State<SectionTitleMolecule> createState() => _SectionTitleStateMolecule();
}

class _SectionTitleStateMolecule extends State<SectionTitleMolecule> {
  bool get isOnLightBackground =>
      widget.sectionTitleStyle == SectionTitleStyle.onLightBackground;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        LabelAtom(
          text: widget.title.toUpperCase(),
          textStyle: TokenTextStyles.displaySmall.copyWith(
            fontWeight: FontWeight.w500,
            color:
                isOnLightBackground ? TokenColors.emphasis : TokenColors.gray50,
          ),
        ),
        const CircleDecoratorAtom()
      ],
    );
  }
}
