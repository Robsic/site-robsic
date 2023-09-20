import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  const PageTemplate(
      {super.key, this.appBar, this.endDrawer, required this.child});

  final PreferredSizeWidget? appBar;
  final Widget? endDrawer;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar,
        endDrawer: endDrawer,
        body: child,
      ),
    );
  }
}
