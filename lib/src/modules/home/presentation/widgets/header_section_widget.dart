import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/organisms/header_section_organism.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../../../core/ui/atoms/body_text_atom.dart';
import '../../../../core/ui/molecules/section_title_molecule.dart';

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key, this.headerSectionData});

  final HeaderSectionEntity? headerSectionData;

  @override
  Widget build(BuildContext context) {
    return headerSectionData != null
        ? HeaderSectionOrganism(
            title: SectionTitleMolecule(
              title: headerSectionData?.title ?? '',
              sectionTitleStyle: SectionTitleStyle.onLightBackground,
            ),
            content: BodyTextAtom(
              text: headerSectionData?.content ?? '',
              textStyle: Theme.of(context).textTheme.headlineSmall,
            ),
          )
        : const SizedBox();
  }
}
