import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';

class AreasOfExpertiseSection extends StatelessWidget {
  const AreasOfExpertiseSection(
      {super.key, required this.expertiseAreasSectionData});

  final ExpertiseAreasSectionEntity? expertiseAreasSectionData;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    final hasDescription = expertiseAreasSectionData?.description != null &&
        expertiseAreasSectionData!.description!.isNotEmpty;

    return expertiseAreasSectionData != null
        ? Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minWidth: double.maxFinite,
              maxHeight: isMobile ? 750 : 650,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isMobile)
                  Expanded(
                    flex: 55,
                    child: SizedBox(
                      height: double.maxFinite,
                      child: CachedNetworkImage(
                        imageUrl: EndPoints.baseUrl +
                            (expertiseAreasSectionData?.image?.url ?? ''),
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) => const LoadImageError(),
                      ),
                    ),
                  ),
                Expanded(
                  flex: 45,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: TokenSpaces.xl,
                      horizontal: TokenSpaces.lg,
                    ),
                    decoration: const BoxDecoration(
                      color: TokenColors.gray900,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          expertiseAreasSectionData?.title ?? 'As áreas de atuação',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.apply(color: TokenColors.gray50),
                        ),
                        const SpaceAtom(
                          spaceType: SpaceType.vertical,
                          value: TokenSpaces.md,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: expertiseAreasSectionData
                                ?.expertiseAreas?.length,
                            itemBuilder: (context, index) {
                              final item = expertiseAreasSectionData
                                  ?.expertiseAreas![index];
                              return _ExpertiseAreaItem(text: item!);
                            },
                          ),
                        ),
                        if (hasDescription) ...[
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.sm,
                          ),
                          Text(
                            expertiseAreasSectionData!.description!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.apply(color: TokenColors.gray200),
                          ),
                        ],
                        const SpaceAtom(
                          spaceType: SpaceType.vertical,
                          value: TokenSpaces.md,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: OutlinedButtonMolecule(
                            label: LabelAtom(
                                text: AppLocalizations.of(context)!
                                    .aboutUsLabel),
                            onPressed: () => context.go(Routes.about),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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
      padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxs),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '- ',
            style: TextStyle(
              color: TokenColors.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SpaceAtom(
            spaceType: SpaceType.horizontal,
            value: TokenSpaces.xxs,
          ),
          Flexible(
            child: LabelAtom(
              text: text,
              textStyle: TokenTextStyles.titleMedium
                  .apply(color: TokenColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
