import 'package:flutter/material.dart';
import 'package:robsic/src/core/core.dart';

class PageError extends StatelessWidget {
  const PageError({super.key, required this.errorMessage, this.reloadAction});

  final String errorMessage;
  final VoidCallback? reloadAction;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 2 * appBarHeight,
      width: double.infinity,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BodyTextAtom(text: errorMessage),
            const SpaceAtom(
                spaceType: SpaceType.vertical, value: TokenSpaces.lg),
            if (reloadAction != null)
              ElevatedButtonMolecule(
                label: const LabelAtom(text: 'Recarregar'),
                onPressed: reloadAction,
              )
          ],
        ),
      ),
    );
  }
}
