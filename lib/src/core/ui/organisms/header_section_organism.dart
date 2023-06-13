import 'package:flutter/material.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';

import '../tokens/tokens.dart';

class HeaderSectionOrganism extends StatelessWidget {
  const HeaderSectionOrganism({
    super.key,
    required this.title,
    required this.content,
  });

  final Widget title;
  final Widget content;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = ResponsiveUtils.isDesktop(context);
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        horizontal: TokenSpaces.lg,
        vertical: TokenSpaces.md,
      ),
      constraints: const BoxConstraints(
        minWidth: double.maxFinite,
        maxHeight: 400,
      ),
      decoration: const BoxDecoration(
        color: TokenColors.secondary20,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280.0),
        child: Flex(
            direction: !isDesktop ? Axis.vertical : Axis.horizontal,
            children: [
              Expanded(
                flex: 45,
                child: Container(
                  padding: const EdgeInsets.all(TokenSpaces.xs),
                  alignment:
                      !isDesktop ? Alignment.bottomLeft : Alignment.centerLeft,
                  child: title,
                ),
              ),
              Expanded(
                flex: 55,
                child: Container(
                  padding: const EdgeInsets.all(TokenSpaces.xs),
                  alignment:
                      !isDesktop ? Alignment.topLeft : Alignment.centerLeft,
                  child: content,
                ),
              ),
            ]),
      ),
    );
  }
}
