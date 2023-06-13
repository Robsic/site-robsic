import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/atoms/atoms.dart';
import 'package:robsic/src/core/ui/molecules/molecules.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';
import 'package:robsic/src/modules/publications/domain/entities/publication_entity.dart';

import '../../../../core/ui/tokens/tokens.dart';

class Publicationcard extends StatelessWidget {
  const Publicationcard({super.key, required this.publication});

  final PublicationEntity publication;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return Card(
      child: Container(
        constraints: BoxConstraints(maxHeight: isMobile ? 500.0 : 400.0),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveUtils.isDesktop(context))
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://images.unsplash.com/photo-1614332625575-6bef549fcc7b?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1441&q=80',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            const SpaceAtom(
              spaceType: SpaceType.horizontal,
              value: TokenSpaces.sm,
            ),
            Expanded(
              flex: 7,
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
                                  text: publication.title,
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
                                  text: publication.autors.first,
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
                                  text: publication.publicationDate.toString(),
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
                                  text: publication.abstract,
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
                        label: LabelAtom(text: 'Get Access'.toUpperCase()),
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
