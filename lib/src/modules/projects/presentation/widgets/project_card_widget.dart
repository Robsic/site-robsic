import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';
import 'project_details_dialog.dart';

class Projectcard extends StatelessWidget {
  const Projectcard({super.key, required this.project});

  final ProjectEntity project;

  String get _formattedStartDate =>
      '${project.startDate.year.toString().padLeft(4, '0')}-'
      '${project.startDate.month.toString().padLeft(2, '0')}-'
      '${project.startDate.day.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final bool isMobile = ResponsiveUtils.isMobile(context);
    final String? imageUrl = project.image?.url;
    final bool hasImage = imageUrl != null && imageUrl.isNotEmpty;

    return Card(
      elevation: 2,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Container(
        width: double.infinity,
        constraints: BoxConstraints(
          minHeight: isMobile ? 320.0 : 200.0,
          maxHeight: isMobile ? 550.0 : 220.0,
        ),
        padding: const EdgeInsets.all(TokenSpaces.lg),
        child: isMobile
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage)
                    Center(
                      child: Container(
                        height: 140,
                        padding: const EdgeInsets.only(bottom: TokenSpaces.sm),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl.startsWith('http')
                              ? imageUrl
                              : EndPoints.baseUrl + imageUrl,
                          fit: BoxFit.contain,
                          errorWidget: (context, _, __) =>
                              const LoadImageError(),
                        ),
                      ),
                    ),
                  Text(
                    project.name,
                    style: TokenTextStyles.titleLarge.copyWith(
                      color: TokenColors.emphasis,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: TokenSpaces.xs),
                  Row(
                    children: [
                      Chip(
                        label: Text(
                          project.category,
                          style: const TextStyle(
                            color: TokenColors.gray900,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        backgroundColor: TokenColors.primary,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(width: TokenSpaces.sm),
                      Text(
                        _formattedStartDate,
                        style: const TextStyle(
                          color: TokenColors.gray500,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TokenSpaces.sm),
                  Expanded(
                    child: Text(
                      project.description,
                      style: TokenTextStyles.bodyMedium.copyWith(
                        color: TokenColors.gray700,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: TokenSpaces.sm),
                  ElevatedButtonMolecule(
                    label: LabelAtom(
                      text: AppLocalizations.of(context)!
                          .seeDetailsLabel
                          .toUpperCase(),
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: ProjectDetailsDialog(project: project),
                      ),
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (hasImage) ...[
                    Container(
                      width: 180,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        color: TokenColors.gray50,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6.0),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl.startsWith('http')
                              ? imageUrl
                              : EndPoints.baseUrl + imageUrl,
                          fit: BoxFit.contain,
                          errorWidget: (context, _, __) =>
                              const LoadImageError(),
                        ),
                      ),
                    ),
                    const SizedBox(width: TokenSpaces.lg),
                  ],
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.name,
                          style: TokenTextStyles.titleLarge.copyWith(
                            color: TokenColors.emphasis,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: TokenSpaces.xs),
                        Row(
                          children: [
                            Chip(
                              label: Text(
                                project.category,
                                style: const TextStyle(
                                  color: TokenColors.gray900,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              backgroundColor: TokenColors.primary,
                              visualDensity: VisualDensity.compact,
                              padding: EdgeInsets.zero,
                            ),
                            const SizedBox(width: TokenSpaces.md),
                            Text(
                              _formattedStartDate,
                              style: const TextStyle(
                                color: TokenColors.gray500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: TokenSpaces.sm),
                        Expanded(
                          child: Text(
                            project.description,
                            style: TokenTextStyles.bodyMedium.copyWith(
                              color: TokenColors.gray700,
                              height: 1.4,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: TokenSpaces.sm),
                        ElevatedButtonMolecule(
                          label: LabelAtom(
                            text: AppLocalizations.of(context)!
                                .seeDetailsLabel
                                .toUpperCase(),
                          ),
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) => Dialog(
                              child: ProjectDetailsDialog(project: project),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
