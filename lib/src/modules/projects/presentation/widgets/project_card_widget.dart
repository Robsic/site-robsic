import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';

class Projectcard extends StatelessWidget {
  const Projectcard({super.key, required this.project});

  final ProjectEntity project;

  String get _formattedDate =>
      '${project.startDate.year.toString().padLeft(4, '0')}-'
      '${project.startDate.month.toString().padLeft(2, '0')}-'
      '${project.startDate.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return Card(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: isMobile ? 520.0 : 420.0,
          maxWidth: 500.0,
        ),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isMobile) ...[
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: project.image?.url == null
                        ? ''
                        : (project.image!.url.startsWith('http')
                            ? project.image!.url
                            : EndPoints.baseUrl + project.image!.url),
                    fit: BoxFit.contain,
                    errorWidget: (context, _, __) => const LoadImageError(),
                  ),
                ),
              ),
              const SpaceAtom(
                spaceType: SpaceType.horizontal,
                value: TokenSpaces.sm,
              ),
            ],
            Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: LabelAtom(
                                  text: project.name,
                                  textStyle: TokenTextStyles.titleLarge.apply(
                                    color: TokenColors.emphasis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.xxs,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: LabelAtom(
                                  text: project.category,
                                  textStyle: TokenTextStyles.labelSmall.apply(
                                    color: TokenColors.gray900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.xxs,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: LabelAtom(
                                  text: _formattedDate,
                                  textStyle: TokenTextStyles.labelSmall.apply(
                                    color: TokenColors.gray300,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.sm,
                          ),
                          Flexible(
                            child: ListView(
                              children: [
                                BodyTextAtom(
                                  text: project.description,
                                  textStyle: TokenTextStyles.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SpaceAtom(
                    spaceType: SpaceType.vertical,
                    value: TokenSpaces.md,
                  ),
                  Row(
                    children: [
                      ElevatedButtonMolecule(
                        label: LabelAtom(
                            text: AppLocalizations.of(context)!
                                .seeDetailsLabel
                                .toUpperCase()),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
