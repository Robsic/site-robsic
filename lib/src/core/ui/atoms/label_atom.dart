import 'package:flutter/material.dart';

class LabelAtom extends StatelessWidget {
  const LabelAtom({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text);
  }
}
