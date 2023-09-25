import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';
import 'package:robsic/src/modules/projects/domain/domain.dart';
import 'package:robsic/src/modules/projects/presentation/stores/projects_states.dart';
import 'package:robsic/src/modules/projects/presentation/stores/projects_store.dart';
import 'package:robsic/src/modules/projects/presentation/widgets/project_card_widget.dart';

import '../../../../core/core.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late final ProjectsStore _projectsStore;

  @override
  void initState() {
    super.initState();
    _projectsStore = serviceLocator.get<ProjectsStore>();
    _projectsStore.getProjectsPageData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageScaffold(
      child: ValueListenableBuilder<ProjectsState>(
        valueListenable: _projectsStore,
        builder: (context, state, _) {
          if (state is ProjectsStateFailure) {
            return PageError(
              errorMessage: AppLocalizations.of(context)!.errorLoadingPage,
              reloadAction: () => _projectsStore.getProjectsPageData(),
            );
          } else if (state is ProjectsStateSuccess) {
            ProjectsEntity projectsPageData = state.projectsEntity;
            HeaderSectionEntity? headerSection = projectsPageData.header;
            return SingleChildScrollView(
              child: Column(
                children: [
                  DefaultHeaderSection(
                    title: headerSection?.title ?? '',
                    text: headerSection?.content ?? '',
                  ),
                  ValueListenableBuilder<ProjectsState>(
                    valueListenable: _projectsStore,
                    builder: (context, stateList, _) {
                      if (stateList is ProjectsListStateFailure) {
                        return PageError(
                            errorMessage: AppLocalizations.of(context)!
                                .errorLoadingProjectsList);
                      } else if (stateList is ProjectsListStateSuccess) {
                        List<ProjectEntity> projects = stateList.projects;
                        return Container(
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
                              children: List.generate(
                                projects.length,
                                (index) => Projectcard(
                                  project: projects[index],
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return const PageLoading();
                      }
                    },
                  ),
                  const FooterOrganism(),
                ],
              ),
            );
          } else {
            return const PageLoading();
          }
        },
      ),
    );
  }
}
