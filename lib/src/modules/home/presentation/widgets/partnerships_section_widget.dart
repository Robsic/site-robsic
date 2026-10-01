import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';

class PartnershipsSection extends StatelessWidget {
  const PartnershipsSection({
    super.key,
    this.partnershipsSectionData,
  });

  final PartnershipsSectionEntity? partnershipsSectionData;

  @override
  Widget build(BuildContext context) {
    return partnershipsSectionData != null
        ? Container(
            color: TokenColors.secondary20,
            constraints: const BoxConstraints(minWidth: double.maxFinite),
            padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SectionTitleMolecule(
                        title: partnershipsSectionData!.title ?? '',
                        sectionTitleStyle: SectionTitleStyle.onLightBackground,
                      ),
                    ],
                  ),
                  const SizedBox(height: TokenSpaces.xxl),
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const double spacing = TokenSpaces.xl;
                      const double runSpacing = TokenSpaces.lg;
                      final int crossAxisCount = constraints.maxWidth > 800
                          ? 5
                          : (constraints.maxWidth > 500 ? 3 : 2);
                      final double itemWidth =
                          (constraints.maxWidth - (spacing * (crossAxisCount - 1))) /
                              crossAxisCount;

                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          spacing: spacing,
                          runSpacing: runSpacing,
                          alignment: WrapAlignment.start,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            if (partnershipsSectionData!.images != null)
                              for (final partner in partnershipsSectionData!.images!)
                                Container(
                                  height: 65.0,
                                  width: itemWidth,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: TokenSpaces.sm,
                                    vertical: TokenSpaces.xs,
                                  ),
                                  alignment: Alignment.center,
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${EndPoints.baseUrl}${partner.url}',
                                    fit: BoxFit.contain,
                                    errorWidget: (context, _, __) =>
                                        const LoadImageError(),
                                  ),
                                ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
