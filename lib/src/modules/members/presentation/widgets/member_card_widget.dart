import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/modules/core/core.dart';
import 'package:robsic/src/modules/members/domain/entities/member_entity.dart';

import '../../../../resources/resources.dart';

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
        constraints: const BoxConstraints(
          maxWidth: 350.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(
                      strokeAlign: BorderSide.strokeAlignOutside,
                      color: TokenColors.primary,
                      width: 2.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                  width: 78.0,
                  height: 78.0,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          '${EndPoints.baseUrl}${widget.member.photo.url}',
                      fit: BoxFit.cover,
                      width: 75.0,
                      height: 75.0,
                      errorWidget: (context, _, __) =>
                          const Image(image: ImagesAsset.defaultUser),
                    ),
                  ),
                ),
                const SpaceAtom(
                  spaceType: SpaceType.horizontal,
                  value: TokenSpaces.sm,
                ),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
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
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 600.0),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: TokenSpaces.md),
                child: BodyTextAtom(
                  text: widget.member.description,
                  textStyle: TokenTextStyles.bodyLarge,
                  maxLines: 10,
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
                Visibility(
                  visible: widget.member.lattesUrl.isNotEmpty,
                  child: InkWell(
                    onTap: () =>
                        _urlLauncher.launchUrl(widget.member.lattesUrl),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Image(image: ImagesAsset.logoLattes),
                        const SpaceAtom(
                          spaceType: SpaceType.horizontal,
                          value: TokenSpaces.xxs,
                        ),
                        LabelAtom(
                          text: AppLocalizations.of(context)!.lattesLabel,
                          textStyle: TokenTextStyles.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.member.orcidUrl.isNotEmpty,
                  child: InkWell(
                    onTap: () => _urlLauncher.launchUrl(widget.member.orcidUrl),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Image(image: ImagesAsset.logoOrcid),
                        const SpaceAtom(
                          spaceType: SpaceType.horizontal,
                          value: TokenSpaces.xxs,
                        ),
                        LabelAtom(
                          text: AppLocalizations.of(context)!.orcidLabel,
                          textStyle: TokenTextStyles.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
                Visibility(
                  visible: widget.member.linkedinUrl.isNotEmpty,
                  child: InkWell(
                    onTap: () =>
                        _urlLauncher.launchUrl(widget.member.linkedinUrl),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Image(image: ImagesAsset.logoLinkedIn),
                        const SpaceAtom(
                          spaceType: SpaceType.horizontal,
                          value: TokenSpaces.xxs,
                        ),
                        LabelAtom(
                          text: AppLocalizations.of(context)!.linkedinLabel,
                          textStyle: TokenTextStyles.titleSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SpaceAtom(
              spaceType: SpaceType.vertical,
              value: TokenSpaces.md,
            ),
            if (widget.member.canReceiveEmail)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButtonMolecule(
                    label: LabelAtom(
                        text: AppLocalizations.of(context)!.sendEmailLabel),
                    onPressed: () {},
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
