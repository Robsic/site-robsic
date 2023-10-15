import 'package:flutter/material.dart';

import '../tokens/tokens.dart';

class AppBarOrganism extends StatefulWidget implements PreferredSizeWidget {
  const AppBarOrganism({
    super.key,
    this.height = 90.0,
    this.child,
  });

  final Widget? child;
  final double height;

  @override
  State<AppBarOrganism> createState() => _AppBarOrganismState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _AppBarOrganismState extends State<AppBarOrganism> {
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2.0,
      child: Container(
        color: TokenColors.secondary20,
        height: widget.preferredSize.height,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: TokenSpaces.md,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
