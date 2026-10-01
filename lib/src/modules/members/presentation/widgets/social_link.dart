import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class SocialLink extends StatelessWidget {
  const SocialLink({
    super.key,
    required this.visible,
    required this.label,
    required this.image,
    required this.onTap,
  });

  final bool visible;
  final String label;
  final AssetImage image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(image: image),
            const SpaceAtom(
              spaceType: SpaceType.horizontal,
              value: TokenSpaces.xxs,
            ),
            LabelAtom(
              text: label,
              textStyle: TokenTextStyles.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
