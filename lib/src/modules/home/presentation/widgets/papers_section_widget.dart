import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/src/modules/home/domain/domain.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/ui/ui.dart';

class PapersSection extends StatelessWidget {
  const PapersSection({
    super.key,
    this.papersSectionData,
  });

  final BasicContentSectionEntity? papersSectionData;

  @override
  Widget build(BuildContext context) {
    return papersSectionData != null
        ? Container(
            constraints: const BoxConstraints(
                minWidth: double.maxFinite, maxHeight: 428.0),
            padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                children: [
                  SectionTitleMolecule(
                    title: papersSectionData!.title,
                    sectionTitleStyle: SectionTitleStyle.onLightBackground,
                  ),
                  const SizedBox(height: TokenSpaces.xxl),
                  BodyTextAtom(
                    text: papersSectionData!.content,
                    textStyle: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => context.go(Routes.publications),
                    child: Text(
                      'Papers'.toUpperCase(),
                    ),
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
