import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/src/core/core.dart';

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
            constraints: const BoxConstraints(
                minWidth: double.maxFinite, maxHeight: 428.0),
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
                  SizedBox(
                    height: 150,
                    child: Center(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: partnershipsSectionData!.images?.length,
                        itemBuilder: (context, index) {
                          final partner =
                              partnershipsSectionData!.images?[index];
                          return SizedBox(
                            height: 150.0,
                            width: 300.0,
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${EndPoints.baseUrl}${partner?.url ?? ''}',
                              fit: BoxFit.contain,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : const SizedBox.shrink();
  }
}
