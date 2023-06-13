import 'package:flutter/material.dart';
import 'package:robsic/src/core/constants/router.dart';

import 'core/constants/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'RobSIC',
      theme: appThemeData,
      routerConfig: router,
    );
  }
}
