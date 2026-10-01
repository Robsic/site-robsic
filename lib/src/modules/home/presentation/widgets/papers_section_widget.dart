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
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return papersSectionData != null
        ? Container(
            constraints: isMobile
                ? const BoxConstraints(minWidth: double.maxFinite)
                : const BoxConstraints(
                    minWidth: double.maxFinite, maxHeight: 260.0),
            padding: const EdgeInsets.symmetric(vertical: TokenSpaces.lg),
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SectionTitleMolecule(
                    title: papersSectionData!.title,
                    sectionTitleStyle: SectionTitleStyle.onLightBackground,
                  ),
                  const SizedBox(height: TokenSpaces.sm),
                  BodyTextAtom(
                    text: papersSectionData!.content,
                    textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          color: TokenColors.gray700,
                        ),
                  ),
                  const SizedBox(height: TokenSpaces.md),
                  ElevatedButton(
                    onPressed: () => context.go(Routes.publications),
                    child: Text(
                      AppLocalizations.of(context)!
                          .publicationsLabel
                          .toUpperCase(),
                    ),
                  )
                ],
              ),
            ),
          )
        : const SizedBox();
  }
}
