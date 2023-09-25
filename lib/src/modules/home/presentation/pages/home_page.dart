import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/core/core.dart';

import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../../home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore _homeStore;

  @override
  void initState() {
    super.initState();
    _homeStore = serviceLocator.get<HomeStore>();
    _homeStore.getHomePageData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageScaffold(
      child: ValueListenableBuilder<HomeState>(
        valueListenable: _homeStore,
        builder: (context, state, _) {
          if (state is HomeStateFailure) {
            return PageError(
              errorMessage: AppLocalizations.of(context)!.errorLoadingPage,
              reloadAction: () => _homeStore.getHomePageData(),
            );
          } else if (state is HomeStateSuccess) {
            HomePageEntity homePageData = state.homePageData;
            HeaderSectionEntity? headerSectionData = homePageData.headerSection;
            ExpertiseAreasSectionEntity? expertiseAreasSectionData =
                homePageData.expertiseAreasSection;
            ContentWithImageSectionEntity? projectsSectionData =
                homePageData.projectsSection;
            ContentWithImageSectionEntity? membersSectionData =
                homePageData.membersSection;
            BasicContentSectionEntity? papersSectionData =
                homePageData.publicationsSection;

            return SingleChildScrollView(
              child: Column(
                children: [
                  HeaderSection(headerSectionData: headerSectionData),
                  AreasOfExpertiseSection(
                      expertiseAreasSectionData: expertiseAreasSectionData),
                  const Divider(height: 2.0, color: Colors.green),
                  ProjectsSectionWidget(
                      projectsSectionData: projectsSectionData),
                  const Divider(height: 2.0, color: Colors.green),
                  MembersSection(membersSectionData: membersSectionData),
                  const Divider(height: 2.0, color: Colors.green),
                  PapersSection(
                    papersSectionData: papersSectionData,
                  ),
                  const FooterOrganism()
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
