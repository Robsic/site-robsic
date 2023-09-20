import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/src/core/constants/constants.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';
import 'package:robsic/src/modules/home/domain/domain.dart';

import '../../../../core/ui/atoms/atoms.dart';
import '../../../../core/ui/molecules/molecules.dart';
import '../../../../core/ui/tokens/tokens.dart';

class AreasOfExpertiseSection extends StatelessWidget {
  const AreasOfExpertiseSection(
      {super.key, required this.expertiseAreasSectionData});

  final ExpertiseAreasSectionEntity? expertiseAreasSectionData;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return expertiseAreasSectionData != null
        ? Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
                minWidth: double.maxFinite, maxHeight: 600),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              if (!isMobile)
                Expanded(
                  flex: 60,
                  child: SizedBox(
                    height: double.maxFinite,
                    child: CachedNetworkImage(
                      imageUrl: EndPoints.baseUrl +
                          (expertiseAreasSectionData?.image?.url ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              Expanded(
                flex: 40,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 60.0),
                  decoration: const BoxDecoration(
                    color: TokenColors.gray900,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 0.7,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Areas of Expertise'.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.apply(color: TokenColors.gray50),
                        ),
                        const SpaceAtom(
                          spaceType: SpaceType.vertical,
                          value: TokenSpaces.xxl,
                        ),
                        Expanded(
                            child: ListView.builder(
                          itemCount:
                              expertiseAreasSectionData?.expertiseAreas?.length,
                          itemBuilder: (context, index) {
                            final item = expertiseAreasSectionData
                                ?.expertiseAreas![index];
                            return _ExpertiseAreaItem(text: item!);
                          },
                        )),
                        OutlinedButtonMolecule(
                          label: LabelAtom(text: 'About Us'.toUpperCase()),
                          onPressed: () => context.go(Routes.about),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          )
        : const SizedBox();
  }
}

class _ExpertiseAreaItem extends StatelessWidget {
  const _ExpertiseAreaItem({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TokenSpaces.xs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check,
            color: TokenColors.primary,
          ),
          const SpaceAtom(
              spaceType: SpaceType.horizontal, value: TokenSpaces.xs),
          Flexible(
            child: LabelAtom(
              text: text,
              textStyle: TokenTextStyles.titleLarge
                  .apply(color: TokenColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
