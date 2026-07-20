import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';

class ProjectDetailsDialog extends StatelessWidget {
  const ProjectDetailsDialog({super.key, required this.project});

  final ProjectEntity project;

  String get _formattedStartDate =>
      '${project.startDate.year.toString().padLeft(4, '0')}-'
      '${project.startDate.month.toString().padLeft(2, '0')}-'
      '${project.startDate.day.toString().padLeft(2, '0')}';

  String get _formattedEndDate => project.endDate != null
      ? '${project.endDate!.year.toString().padLeft(4, '0')}-'
        '${project.endDate!.month.toString().padLeft(2, '0')}-'
        '${project.endDate!.day.toString().padLeft(2, '0')}'
      : '';

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 700, maxHeight: 600),
      child: ListView(
        children: [
          Container(
            decoration: const BoxDecoration(color: TokenColors.gray900),
            padding: const EdgeInsets.all(TokenSpaces.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).maybePop(),
                    icon: const Icon(
                      Icons.close,
                      color: TokenColors.gray100,
                    ),
                  ),
                ),
                if (project.image?.url != null && project.image!.url.isNotEmpty)
                  Center(
                    child: Container(
                      height: 180,
                      padding: const EdgeInsets.only(bottom: TokenSpaces.md),
                      child: CachedNetworkImage(
                        imageUrl: project.image!.url.startsWith('http')
                            ? project.image!.url
                            : EndPoints.baseUrl + project.image!.url,
                        fit: BoxFit.contain,
                        errorWidget: (context, _, __) => const LoadImageError(),
                      ),
                    ),
                  ),
                Text(
                  project.name,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: TokenColors.gray50,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SpaceAtom(
                  spaceType: SpaceType.vertical,
                  value: TokenSpaces.xs,
                ),
                Row(
                  children: [
                    Chip(
                      label: Text(
                        project.category,
                        style: const TextStyle(
                          color: TokenColors.gray900,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: TokenColors.primary,
                      padding: EdgeInsets.zero,
                    ),
                    const SpaceAtom(
                      spaceType: SpaceType.horizontal,
                      value: TokenSpaces.sm,
                    ),
                    Text(
                      _formattedEndDate.isNotEmpty
                          ? '$_formattedStartDate  →  $_formattedEndDate'
                          : _formattedStartDate,
                      style: const TextStyle(
                        color: TokenColors.gray300,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(TokenSpaces.xl),
            child: SelectableText(
              project.description,
              style: TokenTextStyles.bodyLarge.copyWith(
                height: 1.5,
                color: TokenColors.gray900,
              ),
            ),
          ),
          const SpaceAtom(
            spaceType: SpaceType.vertical,
            value: TokenSpaces.lg,
          ),
        ],
      ),
    );
  }
}
