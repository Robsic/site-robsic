import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
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
  ResultType? _selectedCategory;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchTerm = '';
    _selectedCategory = null;
    _appStore = serviceLocator.get<AppStore>();
    _appStore.addListener(_reloadData);
    _publicationsStore = serviceLocator.get<PublicationsStore>();
    _publicationsStore.getPublicationsPageData();
  }

  void _reloadData() {
    if (mounted) {
      setState(() {});
    }
    _publicationsStore.getPublicationsPageData();
  }

  @override
  void dispose() {
    _appStore.removeListener(_reloadData);
    _searchController.dispose();
    super.dispose();
  }

  String _getCategoryLabel(BuildContext context, ResultType? type) {
    final l10n = AppLocalizations.of(context)!;
    if (type == null) return l10n.resultsAllLabel;
    switch (type) {
      case ResultType.dataset:
        return l10n.resultsDatasetsLabel;
      case ResultType.software:
        return l10n.resultsSoftwaresLabel;
      case ResultType.sistemaWeb:
        return l10n.resultsWebSystemsLabel;
      case ResultType.video:
        return l10n.resultsVideosLabel;
      case ResultType.prototipo:
        return l10n.resultsPrototypesLabel;
      case ResultType.patente:
        return l10n.resultsPatentsLabel;
      case ResultType.publicacao:
        return l10n.resultsPublicationsLabel;
      case ResultType.demonstracao:
        return l10n.resultsDemonstrationsLabel;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<ResultType?> categories = [
      null,
      ResultType.dataset,
      ResultType.software,
      ResultType.sistemaWeb,
      ResultType.video,
      ResultType.prototipo,
      ResultType.patente,
      ResultType.publicacao,
      ResultType.demonstracao,
    ];

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
                      } else if (stateList is PublicationsListStateSuccess) {
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
                                // Custom Category Filter Bar
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: categories.map((cat) {
                                      final isSelected =
                                          _selectedCategory == cat;
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: TokenSpaces.xxs,
                                        ),
                                        child: ChoiceChip(
                                          label: Text(_getCategoryLabel(
                                              context, cat)),
                                          selected: isSelected,
                                          selectedColor: TokenColors.primary,
                                          backgroundColor: Colors.white,
                                          labelStyle: TextStyle(
                                            color: isSelected
                                                ? Colors.white
                                                : TokenColors.gray900,
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                          onSelected: (selected) {
                                            if (selected) {
                                              setState(() {
                                                _selectedCategory = cat;
                                              });
                                              _publicationsStore
                                                  .filterByType(cat);
                                            }
                                          },
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                const SpaceAtom(
                                  spaceType: SpaceType.vertical,
                                  value: TokenSpaces.md,
                                ),
                                Container(
                                  alignment: Alignment.centerRight,
                                  child: SizedBox(
                                    width: 367.0,
                                    child: CustomTextFormField(
                                      controller: _searchController,
                                      labelText: AppLocalizations.of(context)!
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
                                  value: TokenSpaces.md,
                                ),
                                _buildContent(context, publications),
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

  Widget _buildContent(BuildContext context, List<PublicationEntity> publications) {
    if (publications.isEmpty) {
      return SizedBox(
        height: 200.0,
        child: Center(
          child: BodyTextAtom(
            text: AppLocalizations.of(context)!.noResultsFound,
          ),
        ),
      );
    }

    // Categories in order of presentation
    final orderedCategories = [
      ResultType.dataset,
      ResultType.software,
      ResultType.sistemaWeb,
      ResultType.video,
      ResultType.prototipo,
      ResultType.patente,
      ResultType.publicacao,
      ResultType.demonstracao,
    ];

    // If a specific category filter is active, only show that category's items
    if (_selectedCategory != null) {
      final categoryItems = publications.where((p) => p.resultType == _selectedCategory).toList();
      if (categoryItems.isEmpty) {
        return SizedBox(
          height: 200.0,
          child: Center(
            child: BodyTextAtom(
              text: AppLocalizations.of(context)!.noResultsFound,
            ),
          ),
        );
      }

      if (_selectedCategory == ResultType.video) {
        return _buildVideoPlaylistsList(categoryItems);
      }

      return Wrap(
        spacing: TokenSpaces.md,
        runSpacing: TokenSpaces.md,
        alignment: WrapAlignment.center,
        runAlignment: WrapAlignment.start,
        children: categoryItems
            .map((pub) => Publicationcard(
                  publication: pub,
                  onReferenceTap: _handleReferenceTap,
                ))
            .toList(),
      );
    }

    // Tab "Todos": Group and display by ordered sections
    final List<Widget> sections = [];

    for (final cat in orderedCategories) {
      final catItems = publications.where((p) => p.resultType == cat).toList();
      if (catItems.isEmpty) continue;

      // Build Section Title
      sections.add(
        _buildSectionHeader(context, _getCategoryLabel(context, cat)),
      );

      // Build Section Content
      if (cat == ResultType.video) {
        sections.add(_buildVideoPlaylistsList(catItems));
      } else {
        sections.add(
          Wrap(
            spacing: TokenSpaces.md,
            runSpacing: TokenSpaces.md,
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.start,
            children: catItems
                .map((pub) => Publicationcard(
                      publication: pub,
                      onReferenceTap: _handleReferenceTap,
                    ))
                .toList(),
          ),
        );
      }
      
      // Add spacing between sections
      sections.add(const SizedBox(height: TokenSpaces.lg));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sections,
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: TokenSpaces.md, bottom: TokenSpaces.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: TokenColors.primary,
                ),
          ),
          const SizedBox(height: TokenSpaces.xxs),
          const Divider(
            color: TokenColors.gray300,
            thickness: 1.5,
          ),
          const SizedBox(height: TokenSpaces.sm),
        ],
      ),
    );
  }

  Widget _buildVideoPlaylistsList(List<PublicationEntity> publications) {
    final Map<String, List<PublicationEntity>> playlistGroups = {};
    final orderedPlaylists = [
      'CAT793F — Simulação e Digital Twin',
      'Realidade Virtual e Digital Twins de Ambientes',
      'Veículos Autônomos e Teleoperação',
      'Visão Computacional e IA aplicada à Indústria',
      'Robótica',
      'Cidades Inteligentes / Smart Cities',
      'Outros Vídeos do Canal RobSIC',
    ];

    for (final pub in publications) {
      final playlist = _getPlaylistForVideo(pub);
      playlistGroups.putIfAbsent(playlist, () => []).add(pub);
    }

    return Column(
      children: orderedPlaylists
          .where((pl) => playlistGroups.containsKey(pl) && playlistGroups[pl]!.isNotEmpty)
          .map<Widget>((pl) => VideoPlaylistCard(
                playlistTitle: pl,
                videos: playlistGroups[pl]!,
                onReferenceTap: _handleReferenceTap,
              ))
          .toList(),
    );
  }

  String _getPlaylistForVideo(PublicationEntity pub) {
    final title = pub.title.toLowerCase().trim();

    if (title.contains('cat793f') || title.contains('mineração autônoma')) {
      return 'CAT793F — Simulação e Digital Twin';
    }
    if (title.contains('realidade virtual do campus') ||
        title.contains('realidade virtual com quest 2') ||
        title.contains('vr-mining inspection')) {
      return 'Realidade Virtual e Digital Twins de Ambientes';
    }
    if (title.contains('veículo elétrico autônomo') ||
        title.contains('veículo elétrico teleoperado') ||
        title.contains('plataforma de testes para sistemas inteligentes')) {
      return 'Veículos Autônomos e Teleoperação';
    }
    if (title.contains('ground engaging tools') ||
        (title.contains('drone autônomo') && title.contains('visão computacional'))) {
      return 'Visão Computacional e IA aplicada à Indústria';
    }
    if (title.contains('kuka') ||
        title.contains('seguidor de linha') ||
        (title.contains('drone autônomo') && !title.contains('visão computacional'))) {
      return 'Robótica';
    }
    if (title.contains('vlc') || title.contains('i2v')) {
      return 'Cidades Inteligentes / Smart Cities';
    }

    return 'Outros Vídeos do Canal RobSIC';
  }

  static const Map<String, String> _codeToTitleKeyword = {
    'D1': 'Banco de imagens de esmeraldas',
    'D2': 'Dataset de imagens/mapas georreferenciados',
    'S1': 'GRaSP-web',
    'W1': 'GRaSP-web',
    'S2': 'GASS-WEB',
    'S3': 'GASS-Metal',
    'S4': 'VR-Mining Inspection',
    'DM1': 'VR-Mining Inspection',
    'S5': 'Onto4ALL Editor',
    'W3': 'Onto4ALL Editor',
    'S6': 'VisGreMLIN 2.0',
    'S9': 'SRAM',
    'PT7': 'SRAM',
    'S14': 'SRAM',
    'S10': 'Plataforma Robótica',
    'P17': 'Plataforma Robótica',
    'P1': 'Máquina de Classificação de Esmeraldas',
    'P2': 'Simulador 3D do Caminhão',
    'P3': 'Veículo Terrestre Autônomo',
    'P4': 'Veículo Elétrico Teleoperado',
    'P5': 'Drone Autônomo para Rastreamento',
    'P6': 'Robô Seguidor de Linha',
    'P7': 'Comunicação VLC',
    'P8': 'Manipulador Robótico KUKA',
    'P11': 'Sistema Embarcado para emulação',
    'PT1': '2015 0203462',
    'PT2': '2019 0226477',
    'PT3': '2022 0256160',
    'PT4': '2025 0074052',
    'PT5': '2025 0178729',
    'PT6': '2019 0028360',
    'DM2': 'Mina Conceição',
    'DM3': 'Simulador CAT793F',
    'DM4': 'Localização Topológica sem GPS',
    'DM5': 'GRaSP-web / GASS-WEB',
  };

  void _handleReferenceTap(String code) {
    final keyword = _codeToTitleKeyword[code];
    if (keyword != null) {
      setState(() {
        _selectedCategory = null;
        searchTerm = keyword;
        _searchController.text = keyword;
      });
      _publicationsStore.filterByType(null);
      _publicationsStore.searchTerm(keyword);
    }
  }
}


