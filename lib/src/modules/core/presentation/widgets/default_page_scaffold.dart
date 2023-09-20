import 'package:flutter/material.dart';
import 'package:robsic/src/core/core.dart';
import 'package:robsic/src/modules/core/core.dart';

class DefaultPageScaffold extends StatelessWidget {
  const DefaultPageScaffold({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return PageTemplate(
      appBar: const CustomAppBar(),
      endDrawer: const CustomEndDrawer(),
      child: child,
    );
  }
}
