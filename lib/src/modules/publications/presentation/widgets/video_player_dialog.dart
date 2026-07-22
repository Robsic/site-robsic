import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../../../resources/resources.dart';
import '../../domain/domain.dart';

class VideoPlayerDialog extends StatelessWidget {
  const VideoPlayerDialog({
    super.key,
    required this.publication,
    required this.videoId,
  });

  final PublicationEntity publication;
  final String videoId;

  @override
  Widget build(BuildContext context) {
    final urlLauncher = serviceLocator.get<UrlLauncherDriver>();
    final String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';

    return Dialog(
      backgroundColor: TokenColors.gray900,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 600),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    publication.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: TokenColors.gray50,
                          fontWeight: FontWeight.bold,
                        ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(Icons.close, color: TokenColors.gray100),
                ),
              ],
            ),
            const SizedBox(height: TokenSpaces.md),
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: thumbnailUrl,
                        fit: BoxFit.cover,
                        errorWidget: (context, _, __) => Container(
                          color: Colors.black45,
                          child: const Icon(Icons.movie, size: 64, color: Colors.white54),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => urlLauncher.launchUrl(publication.urlLink),
                    child: Container(
                      padding: const EdgeInsets.all(TokenSpaces.md),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (publication.resume.isNotEmpty) ...[
              const SizedBox(height: TokenSpaces.md),
              Text(
                publication.resume,
                style: const TextStyle(color: TokenColors.gray300, fontSize: 14),
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: TokenSpaces.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: TokenSpaces.lg,
                      vertical: TokenSpaces.md,
                    ),
                  ),
                  onPressed: () => urlLauncher.launchUrl(publication.urlLink),
                  icon: const Icon(Icons.open_in_new),
                  label: const Text('ABRIR NO YOUTUBE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
