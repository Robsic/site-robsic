import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:robsic/src/core/utils/responsive_utils.dart';

import '../../../../core/constants/routes.dart';
import '../../../../core/ui/atoms/atoms.dart';
import '../../../../core/ui/molecules/molecules.dart';
import '../../../../core/ui/tokens/tokens.dart';

class MembersSection extends StatelessWidget {
  const MembersSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveUtils.isMobile(context);
    return Container(
      alignment: Alignment.center,
      constraints:
          const BoxConstraints(minWidth: double.maxFinite, maxHeight: 428.0),
      padding: const EdgeInsets.symmetric(vertical: TokenSpaces.xxl),
      decoration: const BoxDecoration(color: TokenColors.gray900),
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Flex(
            direction: isMobile ? Axis.vertical : Axis.horizontal,
            children: [
              if (!isMobile)
                Expanded(
                  flex: 39,
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: TokenColors.primary,
                          width: 2.0,
                        ),
                        shape: BoxShape.circle,
                      ),
                      width: 250.0,
                      height: 250.0,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl:
                              'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=687&q=80',
                          fit: BoxFit.cover,
                          width: 245.0,
                          height: 245.0,
                        ),
                      ),
                    ),
                  ),
                ),
              Expanded(
                flex: 61,
                child: Container(
                  alignment: Alignment.bottomCenter,
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SectionTitleMolecule(
                        title: 'Members',
                        sectionTitleStyle: SectionTitleStyle.onDarkBackground,
                      ),
                      const SizedBox(height: TokenSpaces.xxl),
                      BodyTextAtom(
                        text:
                            'We developed a series of projects together with students and in partnership with large companies.',
                        textStyle: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.apply(color: TokenColors.gray500),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton(
                            onPressed: () => context.go(Routes.members),
                            child: Text(
                              'Our Members'.toUpperCase(),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
