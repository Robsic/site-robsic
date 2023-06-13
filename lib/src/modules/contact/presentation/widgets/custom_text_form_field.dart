import 'package:flutter/material.dart';

import '../../../../core/ui/atoms/atoms.dart';
import '../../../../core/ui/tokens/tokens.dart';

class CustomTextFormFIeld extends StatelessWidget {
  const CustomTextFormFIeld(
      {super.key, this.labelText, this.hintText, this.maxLines});

  final String? labelText;
  final String? hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              LabelAtom(
                text: labelText!,
                textStyle: TokenTextStyles.labelLarge,
              ),
              const SpaceAtom(
                spaceType: SpaceType.vertical,
                value: TokenSpaces.xs,
              ),
            ],
          ),
        TextFormField(
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.never,
          ),
          maxLines: maxLines,
        ),
      ],
    );
  }
}
