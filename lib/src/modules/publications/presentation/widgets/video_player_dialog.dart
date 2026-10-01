import 'package:flutter/material.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';
import 'youtube_player_helper.dart';

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

    return Dialog(
      backgroundColor: TokenColors.gray900,
      insetPadding: const EdgeInsets.symmetric(horizontal: TokenSpaces.md, vertical: TokenSpaces.lg),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: SingleChildScrollView(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: getYouTubePlayer(videoId),
                ),
              ),
              if (publication.resume.isNotEmpty) ...[
                const SizedBox(height: TokenSpaces.md),
                Text(
                  publication.resume,
                  style: const TextStyle(color: TokenColors.gray300, fontSize: 14, height: 1.4),
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
      ),
    );
  }
}
