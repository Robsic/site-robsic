import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';
import 'package:robsic/src/core/ui/templates/page_template.dart';
import 'package:robsic/src/modules/core/presentation/widgets/default_header_section.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';
import 'package:robsic/src/modules/members/presentation/widgets/member_card_widget.dart';

import '../../../../core/ui/tokens/tokens.dart';

class MembersPage extends StatefulWidget {
  const MembersPage({super.key});

  @override
  State<MembersPage> createState() => _MembersPageState();
}

class _MembersPageState extends State<MembersPage> {
  final member = MemberEntity(
    name: 'Member Name',
    role: 'Cientista da computação',
    phothoUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    description:
        'Head of the Laboratory of Robotics, intelligent and Complex Systems - RobSIC and Associate Professor in computer Engineering at Federal University ofItajubá (UNIFEI - Advanced Campus of Itabira). Head of the Laboratory of Robotics, intelligent and Complex Systems - RobSIC.',
    orcidUrl: '',
    lattesUrl: '',
    linkedinUrl: '',
  );
  final member2 = MemberEntity(
    name: 'Member Name',
    role: 'Cientista da computação',
    phothoUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
    description:
        'Head of the Laboratory of Robotics, intelligent and Complex Systems - RobSIC and Associate Professor in computer Engineering at Federal University ofItajubá (UNIFEI - Advanced Campus of Itabira).',
    orcidUrl: '',
    lattesUrl: '',
    linkedinUrl: '',
  );

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
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Wrap(
                spacing: TokenSpaces.md,
                runSpacing: TokenSpaces.md,
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                children: [
                  for (int i = 0; i < 10; i++)
                    Membercard(
                      member: i % 2 == 0 ? member : member2,
                    ),
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
