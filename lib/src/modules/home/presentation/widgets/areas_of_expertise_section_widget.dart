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
    final items = expertiseAreasSectionData?.expertiseAreas ?? [];

    final half = (items.length / 2).ceil();
    final col1 = items.take(half).toList();
    final col2 = items.skip(half).toList();

    return expertiseAreasSectionData != null
        ? Container(
            alignment: Alignment.center,
            constraints: BoxConstraints(
              minWidth: double.maxFinite,
              maxHeight: isMobile ? 700 : 480,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (!isMobile)
                  Expanded(
                    flex: 50,
                    child: CachedNetworkImage(
                      imageUrl: EndPoints.baseUrl +
                          (expertiseAreasSectionData?.image?.url ?? ''),
                      fit: BoxFit.cover,
                      errorWidget: (context, _, __) => const LoadImageError(),
                    ),
                  ),
                Expanded(
                  flex: 50,
                  child: Container(
                    padding: const EdgeInsets.all(TokenSpaces.xl),
                    decoration: const BoxDecoration(
                      color: TokenColors.gray900,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              expertiseAreasSectionData?.title ??
                                  'As áreas de atuação',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    color: TokenColors.gray50,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SpaceAtom(
                              spaceType: SpaceType.vertical,
                              value: TokenSpaces.md,
                            ),
                            if (isMobile)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: items
                                    .map((item) => _ExpertiseAreaItem(text: item))
                                    .toList(),
                              )
                            else
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: col1
                                          .map((item) =>
                                              _ExpertiseAreaItem(text: item))
                                          .toList(),
                                    ),
                                  ),
                                  const SpaceAtom(
                                    spaceType: SpaceType.horizontal,
                                    value: TokenSpaces.md,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: col2
                                          .map((item) =>
                                              _ExpertiseAreaItem(text: item))
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (hasDescription) ...[
                              Text(
                                expertiseAreasSectionData!.description!,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: TokenColors.gray300,
                                      height: 1.4,
                                    ),
                              ),
                              const SpaceAtom(
                                spaceType: SpaceType.vertical,
                                value: TokenSpaces.md,
                              ),
                            ],
                            OutlinedButtonMolecule(
                              label: LabelAtom(
                                text: AppLocalizations.of(context)!
                                    .aboutUsLabel,
                              ),
                              onPressed: () => context.go(Routes.about),
                            ),
                          ],
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
    return Container(
      height: 40.0,
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_outline,
            color: TokenColors.primary,
            size: 18,
          ),
          const SpaceAtom(
            spaceType: SpaceType.horizontal,
            value: TokenSpaces.xs,
          ),
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TokenTextStyles.titleMedium.copyWith(
                color: TokenColors.gray100,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
