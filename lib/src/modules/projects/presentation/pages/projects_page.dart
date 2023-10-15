import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../../../resources/resources.dart';
import '../../domain/domain.dart';
import '../stores/stores.dart';
import '../widgets/widgets.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  late final ProjectsStore _projectsStore;
  late final AppStore _appStore;
  late String searchTerm;

  @override
  void initState() {
    super.initState();
    searchTerm = '';
    _appStore = serviceLocator.get<AppStore>();
    _appStore.addListener(_reloadData);
    _projectsStore = serviceLocator.get<ProjectsStore>();
    _projectsStore.getProjectsPageData();
  }

  void _reloadData() => _projectsStore.getProjectsPageData();

  @override
  void dispose() {
    _appStore.removeListener(_reloadData);
    super.dispose();
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
                              .errorLoadingProjectsList,
                          reloadAction: () => _projectsStore.getProjectsList(),
                        );
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
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 367.0,
                                    child: CustomTextFormField(
                                      labelText: AppLocalizations.of(context)!
                                          .searchLabel,
                                      onChanged: (searchTerm) {
                                        this.searchTerm = searchTerm;
                                        _projectsStore.searchTerm(searchTerm);
                                      },
                                      onEditingComplete: () =>
                                          _projectsStore.searchTerm(searchTerm),
                                      sufixIcon: GestureDetector(
                                        onTap: () {
                                          _projectsStore.searchTerm(searchTerm);
                                        },
                                        child: const Icon(
                                          Icons.search,
                                          color: TokenColors.primary,
                                        ),
                                      ),
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                                const SpaceAtom(
                                    spaceType: SpaceType.vertical,
                                    value: TokenSpaces.md),
                                projects.isEmpty
                                    ? SizedBox(
                                        height: 200.0,
                                        child: BodyTextAtom(
                                            text: AppLocalizations.of(context)!
                                                .noProjectsFound),
                                      )
                                    : Wrap(
                                        spacing: TokenSpaces.md,
                                        runSpacing: TokenSpaces.md,
                                        crossAxisAlignment:
                                            WrapCrossAlignment.start,
                                        alignment: WrapAlignment.start,
                                        runAlignment: WrapAlignment.start,
                                        children: List.generate(
                                          projects.length,
                                          (index) => Projectcard(
                                            project: projects[index],
                                          ),
                                        ),
                                      ),
                              ],
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
