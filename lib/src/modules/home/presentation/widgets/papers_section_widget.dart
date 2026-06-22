import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

import '../../../../resources/resources.dart';
import '../../domain/domain.dart';

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
                      AppLocalizations.of(context)!.papersLabel.toUpperCase(),
                    ),
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
