import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';
import 'package:robsic/src/modules/publications/presentation/widgets/video_player_dialog.dart';

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

  String? _getYouTubeVideoId(String url) {
    if (url.isEmpty) return null;
    final regExp = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
      caseSensitive: false,
    );
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    final String? youtubeVideoId = _getYouTubeVideoId(widget.publication.urlLink);
    final bool isVideo = widget.publication.resultType == ResultType.video || youtubeVideoId != null;

    // Imagem do card
    String? imageUrl;
    if (widget.publication.image?.url != null && widget.publication.image!.url.isNotEmpty) {
      imageUrl = widget.publication.image!.url.startsWith('http')
          ? widget.publication.image!.url
          : EndPoints.baseUrl + widget.publication.image!.url;
    } else if (youtubeVideoId != null) {
      imageUrl = 'https://img.youtube.com/vi/$youtubeVideoId/hqdefault.jpg';
    }

    final bool hasImage = imageUrl != null && (isVideo || widget.publication.resultType != ResultType.publicacao);

    return Card(
      child: Container(
        constraints: BoxConstraints(
          minHeight: 180.0,
          maxHeight: isMobile ? 550.0 : 380.0,
        ),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage && ResponsiveUtils.isDesktop(context))
              Expanded(
                flex: 3,
                child: SizedBox(
                  height: double.infinity,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            fit: BoxFit.cover,
                            errorWidget: (context, _, __) => const Image(
                              image: ImagesAsset.defaultPublication,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      if (isVideo)
                        GestureDetector(
                          onTap: () => _openVideoOrLink(context, youtubeVideoId),
                          child: Container(
                            padding: const EdgeInsets.all(TokenSpaces.sm),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.white,
                              size: 36,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            if (hasImage && ResponsiveUtils.isDesktop(context))
              const SpaceAtom(
                spaceType: SpaceType.horizontal,
                value: TokenSpaces.md,
              ),
            Expanded(
              flex: hasImage && ResponsiveUtils.isDesktop(context) ? 7 : 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
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
                        if (widget.publication.autors.isNotEmpty)
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
                                  _appStore.value,
                                ),
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
                        if (widget.publication.resume.isNotEmpty)
                          Expanded(
                            child: ListView(
                              padding: EdgeInsets.zero,
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
                  const SpaceAtom(
                    spaceType: SpaceType.vertical,
                    value: TokenSpaces.md,
                  ),
                  Row(
                    children: [
                      if (widget.publication.urlLink.isNotEmpty)
                        ElevatedButtonMolecule(
                          label: LabelAtom(
                            text: isVideo
                                ? 'ASSISTIR VÍDEO'
                                : AppLocalizations.of(context)!
                                    .getAccessLabel
                                    .toUpperCase(),
                          ),
                          onPressed: () => _openVideoOrLink(context, youtubeVideoId),
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

  void _openVideoOrLink(BuildContext context, String? youtubeVideoId) {
    if (youtubeVideoId != null) {
      showDialog(
        context: context,
        builder: (_) => VideoPlayerDialog(
          publication: widget.publication,
          videoId: youtubeVideoId,
        ),
      );
    } else if (widget.publication.urlLink.isNotEmpty) {
      _urlLauncher.launchUrl(widget.publication.urlLink);
    }
  }

  String _formattedDate(DateTime date, [AppLocale? locale]) {
    return DateFormat.yMd(locale?.fullLanguageCode ?? AppLocale.ptBR)
        .format(date);
  }
}
