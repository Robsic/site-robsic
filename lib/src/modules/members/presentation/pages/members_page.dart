import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';
import 'package:robsic/src/core/ui/templates/page_template.dart';
import 'package:robsic/src/modules/core/presentation/widgets/default_header_section.dart';

import '../../../../core/ui/tokens/tokens.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      child: SingleChildScrollView(
          child: Column(
        children: [
          const DefaultHeaderSection(
            title: 'Members',
            text:
                'It is a interdisciplinary team, composed of researchers with solid klowledge in Robotics, Electronics, and Computing.',
          ),
          Container(
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(
              vertical: 32.0,
            ),
            width: double.infinity,
            child: const FractionallySizedBox(
              widthFactor: 0.9,
              child: Wrap(
                spacing: TokenSpaces.md,
                runSpacing: TokenSpaces.md,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                children: [
                  // for (int i = 0; i < 10; i++)
                  //   Membercard(
                  //     member: i % 2 == 0 ? member : member2,
                  //   ),
                ],
              ),
            ),
          ),
          const FooterOrganism(),
        ],
      )),
    );
  }
}
