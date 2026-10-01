import 'package:flutter/material.dart';

import '../organisms/organisms.dart';

class DrawerTemplate extends StatelessWidget {
  const DrawerTemplate(
      {super.key,
      required this.header,
      required this.content,
      required this.footer});

  final Widget header;
  final Widget content;
  final Widget footer;

  @override
  Widget build(BuildContext context) {
    return DrawerOrganism(
      header: header,
      content: content,
      footer: footer,
    );
  }
}
