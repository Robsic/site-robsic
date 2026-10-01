import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.controller,
    this.initialValue,
    this.labelText,
    this.hintText,
    this.maxLines,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.onSaved,
    this.validator,
    this.autovalidateMode,
    this.sufixIcon,
  });

  final TextEditingController? controller;
  final String? initialValue;
  final String? labelText;
  final String? hintText;
  final int? maxLines;
  final TextInputType? keyboardType;
  final void Function(String)? onChanged;
  final void Function()? onEditingComplete;
  final void Function(String)? onFieldSubmitted;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final AutovalidateMode? autovalidateMode;
  final Widget? sufixIcon;

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
          controller: controller,
          initialValue: initialValue,
          decoration: InputDecoration(
            hintText: hintText,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.never,
            suffixIcon: sufixIcon,
          ),
          keyboardType: keyboardType,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          onEditingComplete: onEditingComplete,
          onFieldSubmitted: onFieldSubmitted,
          onSaved: onSaved,
          validator: validator,
          maxLines: maxLines ?? 1,
        ),
      ],
    );
  }
}
