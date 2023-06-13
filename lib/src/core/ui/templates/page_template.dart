import 'package:flutter/material.dart';
import 'package:robsic/src/modules/core/presentation/widgets/custom_app_bar.dart';
import 'package:robsic/src/modules/core/presentation/widgets/custom_end_drawer.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate({super.key, this.appBar, required this.child});

  final PreferredSizeWidget? appBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(),
        endDrawer: const CustomEndDrawer(),
        body: child,
      ),
    );
  }
}
