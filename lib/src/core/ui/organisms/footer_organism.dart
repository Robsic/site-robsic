import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/src/core/constants/routes.dart';
import 'package:robsic/src/core/ui/atoms/images_asset.dart';
import 'package:robsic/src/core/ui/atoms/label_atom.dart';
import 'package:robsic/src/core/ui/molecules/footer_link_molecule.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';

import '../tokens/tokens.dart';

class FooterOrganism extends StatelessWidget {
  const FooterOrganism({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
      constraints: BoxConstraints(
          minWidth: double.maxFinite, maxHeight: isMobile ? 650 : 280),
      color: TokenColors.gray900,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  alignment:
                      isMobile ? Alignment.centerLeft : Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: InkWell(
                          child:
                              const Image(image: ImagesAsset.robsicLogoFullHor),
                          onTap: () => context.go(Routes.home),
                        ),
                      ),
                      const SizedBox(height: TokenSpaces.md),
                      const Flexible(
                          child:
                              Image(image: ImagesAsset.assinHorComplUnifeiNeg))
                    ],
                  ),
                ),
              ),
              if (isMobile)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: TokenSpaces.xs),
                  child: Divider(height: 2.0, color: Colors.green),
                ),
              Expanded(
                child: Container(
                  alignment:
                      isMobile ? Alignment.centerLeft : Alignment.topCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: TokenSpaces.xs,
                          right: TokenSpaces.xxs,
                          bottom: TokenSpaces.xxs,
                        ),
                        child: LabelAtom(
                          text: 'Links',
                          textStyle: TokenTextStyles.titleMedium.copyWith(
                            color: TokenColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.about),
                        label: 'About Us',
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.members),
                        label: 'Members',
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.projects),
                        label: 'Projects',
                      ),
                      FooterLinkMolecule(
                        onPressed: () => context.go(Routes.publications),
                        label: 'Publications',
                      ),
                    ],
                  ),
                ),
              ),
              if (isMobile)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: TokenSpaces.xs),
                  child: Divider(height: 2.0, color: Colors.green),
                ),
              Expanded(
                child: Container(
                  alignment:
                      isMobile ? Alignment.centerLeft : Alignment.topCenter,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LabelAtom(
                        text: 'Address',
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: TokenColors.primary,
                                fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: TokenSpaces.sm),
                      LabelAtom(
                        text:
                            'Rua irmã Ivone Drummond, 200 - Distrito Industrial II. Itabira-MG',
                        textStyle: TokenTextStyles.titleSmall
                            .copyWith(color: TokenColors.gray300),
                      ),
                      const Spacer(),
                      LabelAtom(
                        text: '© 2023 RobSIC - All rights reserved',
                        textStyle: TokenTextStyles.bodyMedium
                            .apply(color: TokenColors.secondary),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
