import 'package:flutter/material.dart';

enum SpaceType { vertical, horizontal }

class SpaceAtom extends StatelessWidget {
  const SpaceAtom({super.key, required this.spaceType, required this.value});

  final SpaceType spaceType;
  final double value;

  @override
  Widget build(BuildContext context) {
    return spaceType == SpaceType.horizontal
        ? SizedBox(width: value)
        : SizedBox(height: value);
  }
}
