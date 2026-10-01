import 'package:flutter/material.dart';
import 'package:robsic/src/resources/resources.dart';
import '../../domain/domain.dart';
import 'publication_card_widget.dart';

class VideoPlaylistCard extends StatefulWidget {
  const VideoPlaylistCard({
    super.key,
    required this.playlistTitle,
    required this.videos,
    this.onReferenceTap,
  });

  final String playlistTitle;
  final List<PublicationEntity> videos;
  final void Function(String code)? onReferenceTap;

  @override
  State<VideoPlaylistCard> createState() => _VideoPlaylistCardState();
}

class _VideoPlaylistCardState extends State<VideoPlaylistCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    PublicationEntity? firstWithThumb;
    for (final v in widget.videos) {
      if (_getYouTubeVideoId(v.urlLink) != null) {
        firstWithThumb = v;
        break;
      }
    }
    final String? videoId = firstWithThumb != null ? _getYouTubeVideoId(firstWithThumb.urlLink) : null;
    final String? thumbnailUrl = videoId != null ? 'https://img.youtube.com/vi/$videoId/hqdefault.jpg' : null;

    return Card(
      margin: const EdgeInsets.only(bottom: TokenSpaces.md),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => _isExpanded = !_isExpanded),
            child: Padding(
              padding: const EdgeInsets.all(TokenSpaces.lg),
              child: Row(
                children: [
                  Container(
                    width: 120,
                    height: 70,
                    decoration: BoxDecoration(
                      color: TokenColors.gray900,
                      borderRadius: BorderRadius.circular(6),
                      image: thumbnailUrl != null
                          ? DecorationImage(
                              image: NetworkImage(thumbnailUrl),
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: TokenSpaces.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.playlistTitle,
                          style: TokenTextStyles.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            color: TokenColors.emphasis,
                          ),
                        ),
                        const SizedBox(height: TokenSpaces.xs),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: TokenColors.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            '${widget.videos.length} ${widget.videos.length == 1 ? 'vídeo' : 'vídeos'}',
                            style: const TextStyle(
                              color: TokenColors.primary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: TokenColors.primary,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.all(TokenSpaces.md),
              child: Column(
                children: widget.videos
                    .map((v) => Padding(
                          padding: const EdgeInsets.only(bottom: TokenSpaces.sm),
                          child: Publicationcard(
                            publication: v,
                            onReferenceTap: widget.onReferenceTap,
                          ),
                        ))
                    .toList(),
              ),
            ),
        ],
      ),
    );
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
}
