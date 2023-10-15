import 'package:flutter/material.dart';

class LabelAtom extends StatelessWidget {
  const LabelAtom({super.key, required this.text, this.textStyle});
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: textStyle);
  }
}
