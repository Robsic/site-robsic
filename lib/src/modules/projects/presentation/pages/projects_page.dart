import 'package:flutter/material.dart';
import 'package:robsic/src/modules/core/presentation/widgets/custom_app_bar.dart';
import 'package:robsic/src/modules/core/presentation/widgets/default_header_section.dart';

import '../../../../core/core.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBar: const CustomAppBar(),
      child: SingleChildScrollView(
          child: Column(
        children: [
          const DefaultHeaderSection(
            title: 'Projects',
            text:
                'It is a interdisciplinary team, composed of researchers with solid klowledge in Robotics, Electronics, and Computing.',
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: TokenSpaces.xl,
            ),
            color: TokenColors.gray100,
            width: double.infinity,
            child: const FractionallySizedBox(
              widthFactor: 0.9,
              child: Wrap(
                spacing: TokenSpaces.md,
                runSpacing: TokenSpaces.md,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                children: [
                  // for (int i = 0; i < 10; i++)
                  //   Projectcard(
                  //     project: project,
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
