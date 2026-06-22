import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../resources/resources.dart';
import '../../domain/domain.dart';

class MembersSection extends StatelessWidget {
  const MembersSection({
    super.key,
    this.membersSectionData,
  });

  final ContentWithImageSectionEntity? membersSectionData;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return membersSectionData != null
        ? Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(
                minWidth: double.maxFinite, maxHeight: 428.0),
            padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
            decoration: const BoxDecoration(color: TokenColors.gray900),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Flex(
                  direction: isMobile ? Axis.vertical : Axis.horizontal,
                  children: [
                    if (!isMobile)
                      Expanded(
                        flex: 39,
                        child: Container(
                          alignment: Alignment.center,
                          child: Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                strokeAlign: BorderSide.strokeAlignOutside,
                                color: TokenColors.primary,
                                width: 2.0,
                              ),
                              shape: BoxShape.circle,
                            ),
                            width: 250.0,
                            height: 250.0,
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${EndPoints.baseUrl}${membersSectionData!.image?.url ?? ''}',
                                errorWidget: (context, _, __) =>
                                    const Image(image: ImagesAsset.defaultUser),
                                fit: BoxFit.cover,
                                width: 245.0,
                                height: 245.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    Expanded(
                      flex: 61,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            SectionTitleMolecule(
                              title: membersSectionData!.title,
                              sectionTitleStyle:
                                  SectionTitleStyle.onDarkBackground,
                            ),
                            const SizedBox(height: TokenSpaces.xxl),
                            BodyTextAtom(
                              text: membersSectionData!.content,
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.apply(color: TokenColors.gray500),
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                OutlinedButton(
                                  onPressed: () => context.go(Routes.members),
                                  child: Text(
                                    AppLocalizations.of(context)!
                                        .ourMembersLabel
                                        .toUpperCase(),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          )
        : const SizedBox();
  }
}
