import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';

import '../../../../resources/resources.dart';

class LoadImageError extends StatelessWidget {
  const LoadImageError({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(TokenSpaces.xs),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.broken_image_outlined,
                size: TokenSpaces.xxl,
              ),
              const SpaceAtom(
                spaceType: SpaceType.vertical,
                value: TokenSpaces.xs,
              ),
              BodyTextAtom(text: AppLocalizations.of(context)!.loadImageError)
            ],
          ),
        ),
      ),
    );
  }
}
