import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/atoms/atoms.dart';
import 'package:robsic/src/core/ui/molecules/molecules.dart';

import '../../../../core/ui/tokens/tokens.dart';
import '../../domain/entities/project_entity.dart';

class Projectcard extends StatelessWidget {
  const Projectcard({super.key, required this.project});

  final ProjectEntity project;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 295.0, maxWidth: 628.0),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: SizedBox(
                height: double.infinity,
                child: CachedNetworkImage(
                  imageUrl:
                      'https://images.unsplash.com/photo-1559758045-8ce743f79096?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80',
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            const SpaceAtom(
              spaceType: SpaceType.horizontal,
              value: TokenSpaces.sm,
            ),
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
                                  text: project.startDate.toString(),
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
