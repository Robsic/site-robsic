import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';

class DefaultHeaderSection extends StatelessWidget {
  const DefaultHeaderSection(
      {super.key, required this.title, required this.text});

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return HeaderSectionOrganism(
      title: SectionTitleMolecule(
        title: title,
        sectionTitleStyle: SectionTitleStyle.onLightBackground,
      ),
      content: BodyTextAtom(
        text: text,
        textStyle: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
