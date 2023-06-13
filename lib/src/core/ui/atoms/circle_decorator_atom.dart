import 'package:flutter/material.dart';

import '../tokens/tokens.dart';

class CircleDecoratorAtom extends StatelessWidget {
  const CircleDecoratorAtom({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 10.0,
      height: 10.0,
      decoration: const BoxDecoration(
        color: TokenColors.primary,
        shape: BoxShape.circle,
      ),
    );
  }
}
