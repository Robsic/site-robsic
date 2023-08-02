import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class LoadImageError extends StatelessWidget {
  const LoadImageError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: BodyTextAtom(text: 'Erro ao carregar a imagem!'),
    );
  }
}
