import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/core/core.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.height = 90.0,
  });

  final double height;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  late bool isDesktop;

  late final LaunchUrlService _launchUrlService;

  @override
  void initState() {
    super.initState();
    _launchUrlService = serviceLocator.get<LaunchUrlService>();
  }

  @override
  Widget build(BuildContext context) {
    isDesktop = ResponsiveUtils.isDesktop(context);
    return AppbarTemplate(
      height: widget.height,
      leading: Row(
        children: [
          InkWell(
            child: const Image(
                image: ImagesAsset.assinHorUnifeiPos, fit: BoxFit.fitHeight),
            onTap: () => _launchUrlService.launch(url: EndPoints.unifeiSiteUrl),
          ),
          const SpaceAtom(
              spaceType: SpaceType.horizontal, value: TokenSpaces.lg),
          InkWell(
            child: const Image(
                image: ImagesAsset.robsicLogo, fit: BoxFit.fitHeight),
            onTap: () => context.go(Routes.home),
          ),
        ],
      ),
      trailing: Visibility(
        visible: MediaQuery.of(context).size.width < 1100.0,
        child: IconButton(
          onPressed: () {
            Scaffold.of(context).openEndDrawer();
          },
          icon: const Icon(Icons.menu),
        ),
      ),
      child: MediaQuery.of(context).size.width >= 1100.0
          ? Row(
              children: [
                AppbarMenuMolecule(
                  label: AppLocalizations.of(context)!.aboutUsLabel,
                  onPressed: () => context.go(Routes.about),
                  isSelected: true,
                ),
                const SizedBox(width: TokenSpaces.lg),
                AppbarMenuMolecule(
                    label: AppLocalizations.of(context)!.membersLabel,
                    onPressed: () => context.go(Routes.members)),
                const SizedBox(width: TokenSpaces.lg),
                AppbarMenuMolecule(
                  label: AppLocalizations.of(context)!.projectsLabel,
                  onPressed: () => context.go(Routes.projects),
                ),
                const SizedBox(width: TokenSpaces.lg),
                AppbarMenuMolecule(
                  label: AppLocalizations.of(context)!.publicationsLabel,
                  onPressed: () => context.go(Routes.publications),
                ),
                const SpaceAtom(
                  spaceType: SpaceType.horizontal,
                  value: TokenSpaces.md,
                ),
                OutlinedButtonMolecule(
                  label: LabelAtom(
                      text: AppLocalizations.of(context)!
                          .contactUsLabel
                          .toUpperCase()),
                  onPressed: () => context.go(Routes.contact),
                ),
              ],
            )
          : null,
    );
  }
}
