import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/atoms/atoms.dart';
import 'package:robsic/src/core/ui/molecules/molecules.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';

import '../../../../core/ui/tokens/tokens.dart';

class Membercard extends StatelessWidget {
  const Membercard({super.key, required this.member});

  final MemberEntity member;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: TokenColors.primary20,
        ),
        borderRadius: BorderRadius.circular(TokenSpaces.xxs),
      ),
      child: Container(
        padding: const EdgeInsets.all(TokenSpaces.lg),
        constraints: const BoxConstraints(
          maxWidth: 400.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: TokenColors.primary,
                      width: 2.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  width: 78.0,
                  height: 78.0,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
                      fit: BoxFit.cover,
                      width: 75.0,
                      height: 75.0,
                    ),
                  ),
                ),
                const SpaceAtom(
                  spaceType: SpaceType.horizontal,
                  value: TokenSpaces.sm,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: LabelAtom(
                              text: member.name,
                              textStyle: TokenTextStyles.titleLarge.apply(
                                color: TokenColors.emphasis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: LabelAtom(
                              text: member.role,
                              textStyle: TokenTextStyles.labelSmall.apply(
                                color: TokenColors.primary,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: TokenSpaces.md),
              child: BodyTextAtom(
                text: member.description,
                textStyle: TokenTextStyles.bodyLarge,
              ),
            ),
            const Divider(
              color: TokenColors.gray200,
              thickness: 1.0,
            ),
            const SpaceAtom(
              spaceType: SpaceType.vertical,
              value: TokenSpaces.sm,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Image(image: ImagesAsset.logoLattes),
                    SpaceAtom(
                      spaceType: SpaceType.horizontal,
                      value: TokenSpaces.xxs,
                    ),
                    LabelAtom(
                      text: 'Lattes',
                      textStyle: TokenTextStyles.titleSmall,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Image(image: ImagesAsset.logoOrcid),
                    SpaceAtom(
                      spaceType: SpaceType.horizontal,
                      value: TokenSpaces.xxs,
                    ),
                    LabelAtom(
                      text: 'Orcid',
                      textStyle: TokenTextStyles.titleSmall,
                    ),
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Image(image: ImagesAsset.logoLinkedIn),
                    SpaceAtom(
                      spaceType: SpaceType.horizontal,
                      value: TokenSpaces.xxs,
                    ),
                    LabelAtom(
                      text: 'Linkedin',
                      textStyle: TokenTextStyles.titleSmall,
                    ),
                  ],
                ),
              ],
            ),
            const SpaceAtom(
              spaceType: SpaceType.vertical,
              value: TokenSpaces.md,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButtonMolecule(
                  label: const LabelAtom(text: 'Send Email'),
                  onPressed: () {},
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
