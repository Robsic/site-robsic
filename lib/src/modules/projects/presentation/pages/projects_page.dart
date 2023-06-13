import 'package:flutter/material.dart';
import 'package:robsic/src/modules/core/presentation/widgets/custom_app_bar.dart';
import 'package:robsic/src/modules/core/presentation/widgets/default_header_section.dart';
import 'package:robsic/src/modules/projects/domain/entities/project_entity.dart';
import 'package:robsic/src/modules/projects/presentation/widgets/project_card_widget.dart';

import '../../../../core/core.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  final project = ProjectEntity(
      name: 'Golfinho',
      category: 'Authonomus Vehicle',
      startDate: DateTime(2020, 04),
      description:
          'Concept and development of a inteligent and authonomus Land vehicle.',
      imageUrl:
          'https://images.unsplash.com/photo-1559758045-8ce743f79096?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1470&q=80');

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
            child: FractionallySizedBox(
              widthFactor: 0.9,
              child: Wrap(
                spacing: TokenSpaces.md,
                runSpacing: TokenSpaces.md,
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.start,
                children: [
                  for (int i = 0; i < 10; i++)
                    Projectcard(
                      project: project,
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
