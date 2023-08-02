import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/src/core/core.dart';

import '../../domain/domain.dart';

class PartnershipsSection extends StatelessWidget {
  const PartnershipsSection({
    super.key,
    this.partnershipsSection,
  });

  final PartnershipsSectionEntity? partnershipsSection;

  @override
  Widget build(BuildContext context) {
    return partnershipsSection != null
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
                        title: partnershipsSection!.title ?? '',
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
                        itemCount: partnershipsSection!.images?.length,
                        itemBuilder: (context, index) {
                          final partner = partnershipsSection!.images?[index];
                          return SizedBox(
                            height: 150.0,
                            width: 300.0,
                            child: CachedNetworkImage(
                              imageUrl:
                                  '${EndPoints.baseUrl}${partner?.url ?? ''}',
                              httpHeaders: const {
                                'ngrok-skip-browser-warning': '1234'
                              },
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
