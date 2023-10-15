import 'package:flutter/material.dart';

class BodyTextAtom extends StatelessWidget {
  const BodyTextAtom({
    super.key,
    required this.text,
    this.textStyle,
    this.textAlign,
    this.textOverflow,
    this.maxLines,
  });

  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextOverflow? textOverflow;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: textStyle,
      textAlign: textAlign,
      overflow: textOverflow,
      maxLines: maxLines,
    );
  }
}
