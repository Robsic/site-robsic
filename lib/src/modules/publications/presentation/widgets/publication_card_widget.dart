import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';
import 'package:robsic/src/modules/publications/presentation/widgets/video_player_dialog.dart';
import '../stores/publications_store.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';

class Publicationcard extends StatefulWidget {
  const Publicationcard({
    super.key,
    required this.publication,
    this.onReferenceTap,
  });

  final PublicationEntity publication;
  final void Function(String code)? onReferenceTap;

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
    final codes = _extractCodes(widget.publication.resume);
    String urlLink = widget.publication.urlLink;
    String? inheritedFromCode;

    if (urlLink.isEmpty) {
      final publicationsStore = serviceLocator.get<PublicationsStore>();
      final allPubs = publicationsStore.allPublications;

      for (final code in codes) {
        final keyword = _codeToTitleKeyword[code];
        if (keyword != null) {
          PublicationEntity? found;
          for (final p in allPubs) {
            if (p.title.toLowerCase().contains(keyword.toLowerCase()) && p.urlLink.isNotEmpty) {
              found = p;
              break;
            }
          }
          if (found != null) {
            urlLink = found.urlLink;
            inheritedFromCode = code;
            break;
          }
        }
      }
    }

    final String? youtubeVideoId = _getYouTubeVideoId(urlLink);
    final bool isVideo = widget.publication.resultType == ResultType.video;

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
          minHeight: 140.0,
        ),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage && ResponsiveUtils.isDesktop(context))
              Expanded(
                flex: 3,
                child: AspectRatio(
                  aspectRatio: 16 / 9,
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
                          onTap: () => _openVideoOrLink(context, youtubeVideoId, urlLink),
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
                  Column(
                    mainAxisSize: MainAxisSize.min,  
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
                        BodyTextAtom(
                          text: widget.publication.resume,
                          textStyle: TokenTextStyles.bodyLarge,
                          maxLines: 4,
                          textOverflow: TextOverflow.ellipsis,
                        ),
                              
                        if (codes.isNotEmpty) ...[
                          const SpaceAtom(
                            spaceType: SpaceType.vertical,
                            value: TokenSpaces.xs,
                          ),
                          Wrap(
                            spacing: TokenSpaces.xs,
                            runSpacing: TokenSpaces.xs,
                            children: codes.map((c) => _buildBadge(c)).toList(),
                          ),
                        ],
                      ],
                    ),
                  const SpaceAtom(
                    spaceType: SpaceType.vertical,
                    value: TokenSpaces.md,
                  ),
                   Row(
                    children: [
                      if (urlLink.isNotEmpty)
                        ElevatedButtonMolecule(
                          label: LabelAtom(
                            text: isVideo
                                ? 'ASSISTIR VÍDEO'
                                : (inheritedFromCode != null
                                    ? 'ACESSAR ($inheritedFromCode)'
                                    : AppLocalizations.of(context)!
                                        .getAccessLabel
                                        .toUpperCase()),
                          ),
                          onPressed: () => _openVideoOrLink(context, youtubeVideoId, urlLink),
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

  void _openVideoOrLink(BuildContext context, String? youtubeVideoId, String targetUrl) {
    if (youtubeVideoId != null) {
      showDialog(
        context: context,
        builder: (_) => VideoPlayerDialog(
          publication: widget.publication,
          videoId: youtubeVideoId,
        ),
      );
    } else if (targetUrl.isNotEmpty) {
      _urlLauncher.launchUrl(targetUrl);
    }
  }

  String _formattedDate(DateTime date, [AppLocale? locale]) {
    return DateFormat.yMd(locale?.fullLanguageCode ?? AppLocale.ptBR)
        .format(date);
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

  List<String> _extractCodes(String text) {
    final codes = <String>[];
    final regExp = RegExp(r'\b(S\d+|P\d+|PT\d+|W\d+|D\d+|DM\d+)\b');
    final matches = regExp.allMatches(text);
    for (final m in matches) {
      final code = m.group(1);
      if (code != null && _codeToTitleKeyword.containsKey(code)) {
        if (!codes.contains(code)) {
          codes.add(code);
        }
      }
    }
    return codes;
  }

  Widget _buildBadge(String code) {
    String label = code;
    if (code.startsWith('P') && !code.startsWith('PT')) {
      label = 'Protótipo $code';
    } else if (code.startsWith('PT')) {
      label = 'Patente $code';
    } else if (code.startsWith('S')) {
      label = 'Software $code';
    } else if (code.startsWith('W')) {
      label = 'Sistema Web $code';
    } else if (code.startsWith('D') && !code.startsWith('DM')) {
      label = 'Dataset $code';
    } else if (code.startsWith('DM')) {
      label = 'Demonstração $code';
    }

    return GestureDetector(
      onTap: () {
        if (widget.onReferenceTap != null) {
          widget.onReferenceTap!(code);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: TokenColors.primary.withOpacity(0.12),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: TokenColors.primary.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.link,
              size: 14,
              color: TokenColors.primary,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                color: TokenColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
