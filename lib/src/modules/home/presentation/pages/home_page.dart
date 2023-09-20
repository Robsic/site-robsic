import 'package:flutter/material.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';
import 'package:robsic/src/modules/core/presentation/widgets/page_error.dart';
import 'package:robsic/src/modules/core/presentation/widgets/page_loading.dart';
import 'package:robsic/src/modules/home/domain/domain.dart';
import 'package:robsic/src/modules/home/presentation/stores/home_states.dart';
import 'package:robsic/src/modules/home/presentation/stores/home_store.dart';

import '../../../core/core.dart';
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
    return Scaffold(
      appBar: const CustomAppBar(),
      endDrawer: const CustomEndDrawer(),
      body: ValueListenableBuilder<HomeState>(
        valueListenable: _homeStore,
        builder: (context, state, _) {
          if (state is HomeStateFailure) {
            return PageError(
              errorMessage: 'Erro ao carregar a página!',
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
                  const PapersSection(),
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
