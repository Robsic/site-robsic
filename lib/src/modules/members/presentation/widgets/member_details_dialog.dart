import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';

import '../../../../resources/resources.dart';
import '../../../core/core.dart';
import '../../domain/domain.dart';
import 'social_link.dart';

class MemberDetailsDialog extends StatefulWidget {
  const MemberDetailsDialog({super.key, required this.member});
  final MemberEntity member;

  @override
  State<MemberDetailsDialog> createState() => _MemberDetailsDialogState();
}

class _MemberDetailsDialogState extends State<MemberDetailsDialog> {
  late final UrlLauncherDriver _urlLauncher;

  @override
  void initState() {
    super.initState();
    _urlLauncher = serviceLocator.get<UrlLauncherDriver>();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          decoration: const BoxDecoration(color: TokenColors.gray900),
          padding: const EdgeInsets.symmetric(
              horizontal: TokenSpaces.lg, vertical: TokenSpaces.lg),
          child: Column(
            children: [
              Container(
                alignment: Alignment.topRight,
                child: IconButton(
                  onPressed: () => Navigator.of(context).maybePop(),
                  icon: const Icon(
                    Icons.close,
                    color: TokenColors.gray100,
                  ),
                ),
              ),
              CircleUserAvatar(
                url: widget.member.photo?.url != null
                    ? '${EndPoints.baseUrl}${widget.member.photo!.url}'
                    : '',
                size: 200,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: SectionTitleMolecule(
                      title: widget.member.name,
                      sectionTitleStyle: SectionTitleStyle.onDarkBackground,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: LabelAtom(
                      text: widget.member.role,
                      textStyle: TokenTextStyles.bodyLarge.apply(
                        color: TokenColors.primary,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: TokenSpaces.xxl, vertical: TokenSpaces.lg),
          child: BodyTextAtom(
            text: widget.member.description,
            textStyle: TokenTextStyles.bodyLarge,
          ),
        ),
        const Divider(
          color: TokenColors.gray200,
          thickness: 1.0,
        ),
        const SpaceAtom(
          spaceType: SpaceType.vertical,
          value: TokenSpaces.sm,
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SocialLink(
              visible: widget.member.lattesUrl.isNotEmpty,
              label: AppLocalizations.of(context)!.lattesLabel,
              image: ImagesAsset.logoLattes,
              onTap: () => _urlLauncher.launchUrl(widget.member.lattesUrl),
            ),
            SocialLink(
              visible: widget.member.orcidUrl.isNotEmpty,
              label: AppLocalizations.of(context)!.orcidLabel,
              image: ImagesAsset.logoOrcid,
              onTap: () => _urlLauncher.launchUrl(widget.member.orcidUrl),
            ),
            SocialLink(
              visible: widget.member.linkedinUrl.isNotEmpty,
              label: AppLocalizations.of(context)!.linkedinLabel,
              image: ImagesAsset.logoLinkedIn,
              onTap: () => _urlLauncher.launchUrl(widget.member.linkedinUrl),
            ),
          ],
        ),
        const SpaceAtom(
          spaceType: SpaceType.vertical,
          value: TokenSpaces.xxl,
        ),
      ],
    );
  }
}
