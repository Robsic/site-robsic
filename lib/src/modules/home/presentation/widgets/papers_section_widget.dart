import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/ui/ui.dart';

class PapersSection extends StatelessWidget {
  const PapersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints:
          const BoxConstraints(minWidth: double.maxFinite, maxHeight: 428.0),
      padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Column(
          children: [
            const SectionTitleMolecule(
              title: 'Papers',
              sectionTitleStyle: SectionTitleStyle.onLightBackground,
            ),
            const SizedBox(height: TokenSpaces.xxl),
            BodyTextAtom(
              text:
                  'We developed a series of projects together with students and in partnership with large companies.',
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
    );
  }
}
