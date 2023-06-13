import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/organisms/header_section_organism.dart';

import '../../../../core/ui/atoms/body_text_atom.dart';
import '../../../../core/ui/molecules/section_title_molecule.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return HeaderSectionOrganism(
      title: const SectionTitleMolecule(
        title: 'RobSIC',
        sectionTitleStyle: SectionTitleStyle.onLightBackground,
      ),
      content: BodyTextAtom(
        text:
            'It is a interdisciplinary team, composed of researchers with solid klowledge in Robotics, Electronics, and Computing.',
        textStyle: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
