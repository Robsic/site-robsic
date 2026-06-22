import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';

class Publicationcard extends StatefulWidget {
  const Publicationcard({super.key, required this.publication});

  final PublicationEntity publication;

  @override
  State<Publicationcard> createState() => _PublicationcardState();
}

class _PublicationcardState extends State<Publicationcard> {
  late final UrlLauncherDriver _urlLauncher;
  late final AppStore _appStore;

  @override
  void initState() {
    super.initState();
    _appStore = serviceLocator.get<AppStore>();
    _urlLauncher = serviceLocator.get<UrlLauncherDriver>();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    return Card(
      child: Container(
        constraints: BoxConstraints(maxHeight: isMobile ? 500.0 : 400.0),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (ResponsiveUtils.isDesktop(context))
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: EndPoints.baseUrl +
                        (widget.publication.image?.url ?? ''),
                    fit: BoxFit.fitHeight,
                    errorWidget: (context, _, __) => const Image(
                      image: ImagesAsset.defaultPublication,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            const SpaceAtom(
              spaceType: SpaceType.horizontal,
              value: TokenSpaces.sm,
            ),
            Expanded(
              flex: 7,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: LabelAtom(
                                  text: widget.publication.title,
                                  textStyle: TokenTextStyles.titleLarge.apply(
                                    color: TokenColors.emphasis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.xxs,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: LabelAtom(
                                  text: widget.publication.autors,
                                  textStyle: TokenTextStyles.labelSmall.apply(
                                    color: TokenColors.gray900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.xxs,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: LabelAtom(
                                  text: _formattedDate(
                                          widget.publication.publicationDate,
                                          _appStore.value)
                                      .toString(),
                                  textStyle: TokenTextStyles.labelSmall.apply(
                                    color: TokenColors.gray500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.sm,
                          ),
                          Flexible(
                            child: ListView(
                              children: [
                                BodyTextAtom(
                                  text: widget.publication.resume,
                                  textStyle: TokenTextStyles.bodyLarge,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SpaceAtom(
                    spaceType: SpaceType.vertical,
                    value: TokenSpaces.md,
                  ),
                  Row(
                    children: [
                      ElevatedButtonMolecule(
                        label: LabelAtom(
                            text: AppLocalizations.of(context)!
                                .getAccessLabel
                                .toUpperCase()),
                        onPressed: () =>
                            _urlLauncher.launchUrl(widget.publication.urlLink),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formattedDate(DateTime date, [AppLocale? locale]) {
    return DateFormat.yMd(locale?.fullLanguageCode ?? AppLocale.ptBR)
        .format(date);
  }
}
