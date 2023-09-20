import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';
import 'package:robsic/src/modules/home/domain/domain.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/ui/atoms/atoms.dart';
import '../../../../core/ui/molecules/molecules.dart';
import '../../../../core/ui/tokens/tokens.dart';

class ProjectsSectionWidget extends StatelessWidget {
  const ProjectsSectionWidget({super.key, this.projectsSectionData});

  final ContentWithImageSectionEntity? projectsSectionData;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return projectsSectionData != null
        ? Container(
            alignment: Alignment.center,
            width: double.infinity,
            constraints: const BoxConstraints(maxHeight: 428.0),
            padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 62,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: TokenSpaces.md),
                        child: Column(
                          children: [
                            SectionTitleMolecule(
                              title: projectsSectionData!.title,
                              sectionTitleStyle:
                                  SectionTitleStyle.onLightBackground,
                            ),
                            const SizedBox(height: TokenSpaces.xxl),
                            BodyTextAtom(
                              text: projectsSectionData!.content,
                              textStyle:
                                  Theme.of(context).textTheme.headlineSmall,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                  onPressed: () => context.go(Routes.projects),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .seeProjectsLabel
                                        .toUpperCase(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    if (!isMobile)
                      Expanded(
                        flex: 38,
                        child: SizedBox(
                          height: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://images.unsplash.com/photo-1508873535684-277a3cbcc4e8?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2070&q=80',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                  ]),
            ),
          )
        : const SizedBox();
  }
}
