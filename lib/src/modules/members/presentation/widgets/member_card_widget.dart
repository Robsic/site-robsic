import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';

import '../../../../resources/resources.dart';
import '../../domain/domain.dart';
import 'member_details_dialog.dart';
import 'social_link.dart';

class Membercard extends StatefulWidget {
  const Membercard({super.key, required this.member});

  final MemberEntity member;

  @override
  State<Membercard> createState() => _MembercardState();
}

class _MembercardState extends State<Membercard> {
  late final UrlLauncherDriver _urlLauncher;

  @override
  void initState() {
    super.initState();
    _urlLauncher = serviceLocator.get<UrlLauncherDriver>();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: TokenColors.primary20,
        ),
        borderRadius: BorderRadius.circular(TokenSpaces.xxs),
      ),
      child: Container(
        padding: const EdgeInsets.all(TokenSpaces.lg),
        width: 350.0,
        height: 540.0,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(
              height: 110.0,
              child: Row(
                children: [
                  CircleUserAvatar(
                    url: widget.member.photo?.url != null
                        ? '${EndPoints.baseUrl}${widget.member.photo!.url}'
                        : '',
                    size: 78,
                  ),
                  const SpaceAtom(
                    spaceType: SpaceType.horizontal,
                    value: TokenSpaces.sm,
                  ),
                  Flexible(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: LabelAtom(
                                text: widget.member.name,
                                textStyle: TokenTextStyles.titleLarge.apply(
                                  color: TokenColors.emphasis,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: LabelAtom(
                                text: widget.member.role,
                                textStyle: TokenTextStyles.labelSmall.apply(
                                  color: TokenColors.primary,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 220.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: TokenSpaces.md),
                child: BodyTextAtom(
                  text: widget.member.description,
                  textStyle: TokenTextStyles.bodyLarge,
                  maxLines: 8,
                  textOverflow: TextOverflow.ellipsis,
                ),
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
                  onTap: () =>
                      _urlLauncher.launchUrl(widget.member.linkedinUrl),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButtonMolecule(
                    label: LabelAtom(
                      text: AppLocalizations.of(context)!.moreDetailsLabel,
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) => Dialog(
                        child: MemberDetailsDialog(member: widget.member),
                      ),
                    ),
                  ),
                  if (widget.member.canReceiveEmail) ...[
                    const SpaceAtom(
                      spaceType: SpaceType.vertical,
                      value: TokenSpaces.md,
                    ),
                    OutlinedButtonMolecule(
                      label: LabelAtom(
                        text: AppLocalizations.of(context)!.sendEmailLabel,
                      ),
                      onPressed: () => _urlLauncher.launchUrl(
                        'https://mail.google.com/mail/?view=cm&fs=1&to=${widget.member.email}',
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
