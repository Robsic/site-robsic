import 'package:flutter/material.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/core/ui/atoms/body_text_atom.dart';
import 'package:robsic/src/core/ui/atoms/label_atom.dart';
import 'package:robsic/src/core/ui/organisms/footer_organism.dart';
import 'package:robsic/src/core/ui/tokens/token_spaces.dart';
import 'package:robsic/src/modules/about/about.dart';
import 'package:robsic/src/modules/core/core.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  late final AboutStore _aboutStore;

  @override
  void initState() {
    super.initState();
    _aboutStore = serviceLocator.get<AboutStore>();
    _aboutStore.getAboutPageData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultPageScaffold(
      child: ValueListenableBuilder(
        valueListenable: _aboutStore,
        builder: (context, state, _) {
          if (state is AboutStateFailure) {
            return PageError(
              errorMessage: 'Erro ao carregar a página!',
              reloadAction: () => _aboutStore.getAboutPageData(),
            );
          } else if (state is AboutStateSuccess) {
            AboutPageEntity aboutPageData = state.aboutEntity;
            HeaderSectionEntity? headerSection = aboutPageData.headerSection;
            return SingleChildScrollView(
              child: Column(
                children: [
                  DefaultHeaderSection(
                    title: headerSection?.title ?? '',
                    text: headerSection?.content ?? '',
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Column(
                        children: [
                          Center(
                            child: LabelAtom(
                              text: aboutPageData.title ?? '',
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      fontSize: 32.0,
                                      fontWeight: FontWeight.w600),
                            ),
                          ),
                          const SizedBox(height: TokenSpaces.xxl),
                          BodyTextAtom(
                            text: aboutPageData.introduction ?? '',
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                          ),
                          if (aboutPageData.images?.isNotEmpty ?? false)
                            ConstrainedBox(
                              constraints:
                                  const BoxConstraints(maxHeight: 600.0),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: TokenSpaces.lg,
                                ),
                                child: CarouselWidget(
                                    images: aboutPageData.images!),
                              ),
                            ),
                          BodyTextAtom(
                            text: aboutPageData.moreAbout ?? '',
                            textStyle: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ),
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
