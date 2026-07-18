import 'package:flutter/material.dart';

import '../atoms/atoms.dart';
import '../organisms/organisms.dart';
import '../tokens/tokens.dart';

class AppbarTemplate extends StatefulWidget implements PreferredSizeWidget {
  const AppbarTemplate({
    super.key,
    this.height = 90.0,
    required this.leading,
    required this.child,
    required this.trailing,
  });

  final double height;
  final Widget leading;
  final Widget? child;
  final Widget? trailing;

  @override
  State<AppbarTemplate> createState() => _AppbarTemplateState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppbarTemplateState extends State<AppbarTemplate> {
  @override
  Widget build(BuildContext context) {
    return AppBarOrganism(
      height: widget.height,
      child: FractionallySizedBox(
        widthFactor: 0.9,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: SizedBox(height: TokenSpaces.xxl, child: widget.leading),
            ),
            if (widget.child != null) ...[
              const Spacer(),
              widget.child!,
              const SpaceAtom(
                spaceType: SpaceType.horizontal,
                value: TokenSpaces.xl,
              ),
            ],
            if (widget.trailing != null) widget.trailing!,
          ],
        ),
      ),
    );
  }
}
