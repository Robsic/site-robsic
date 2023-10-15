import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';
import '../stores/stores.dart';
import '../widgets/widgets.dart';

class PublicationsPage extends StatefulWidget {
  const PublicationsPage({super.key});

  @override
  State<PublicationsPage> createState() => _PublicationsPageState();
}

class _PublicationsPageState extends State<PublicationsPage> {
  late final PublicationsStore _publicationsStore;
  late final AppStore _appStore;
  late String searchTerm;

  @override
  void initState() {
    super.initState();
    searchTerm = '';
    _appStore = serviceLocator.get<AppStore>();
    _appStore.addListener(_reloadData);
    _publicationsStore = serviceLocator.get<PublicationsStore>();
    _publicationsStore.getPublicationsPageData();
  }

  void _reloadData() => _publicationsStore.getPublicationsPageData();

  @override
  void dispose() {
    _appStore.removeListener(_reloadData);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageScaffold(
      child: ValueListenableBuilder<PublicationsState>(
          valueListenable: _publicationsStore,
          builder: (context, state, _) {
            if (state is PublicationsStateFailure) {
              return PageError(
                errorMessage: AppLocalizations.of(context)!.errorLoadingPage,
                reloadAction: () =>
                    _publicationsStore.getPublicationsPageData(),
              );
            } else if (state is PublicationsStateSuccess) {
              PublicationsPageEntity publicationsPageData =
                  state.publicationsPageEntity;
              HeaderSectionEntity? headerSection = publicationsPageData.header;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    DefaultHeaderSection(
                      title: headerSection?.title ?? '',
                      text: headerSection?.content ?? '',
                    ),
                    ValueListenableBuilder(
                        valueListenable: _publicationsStore,
                        builder: (context, stateList, _) {
                          if (stateList is PublicationsListStateFailure) {
                            return PageError(
                              errorMessage: AppLocalizations.of(context)!
                                  .errorLoadingPublicationsList,
                              reloadAction: () =>
                                  _publicationsStore.getPublicationsList(),
                            );
                          } else if (stateList
                              is PublicationsListStateSuccess) {
                            List<PublicationEntity> publications =
                                stateList.publications;
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
                                          labelText:
                                              AppLocalizations.of(context)!
                                                  .searchLabel,
                                          onChanged: (searchTerm) {
                                            this.searchTerm = searchTerm;
                                            _publicationsStore
                                                .searchTerm(searchTerm);
                                          },
                                          onEditingComplete: () =>
                                              _publicationsStore
                                                  .searchTerm(searchTerm),
                                          sufixIcon: GestureDetector(
                                            onTap: () {
                                              _publicationsStore
                                                  .searchTerm(searchTerm);
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
                                    publications.isEmpty
                                        ? SizedBox(
                                            height: 200.0,
                                            child: BodyTextAtom(
                                              text:
                                                  AppLocalizations.of(context)!
                                                      .noPublicationsFound,
                                            ),
                                          )
                                        : Wrap(
                                            spacing: TokenSpaces.md,
                                            runSpacing: TokenSpaces.md,
                                            alignment: WrapAlignment.center,
                                            runAlignment: WrapAlignment.start,
                                            children: List.generate(
                                              publications.length,
                                              (index) => Publicationcard(
                                                publication:
                                                    publications[index],
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
                        }),
                    const FooterOrganism(),
                  ],
                ),
              );
            } else {
              return const PageLoading();
            }
          }),
    );
  }
}
