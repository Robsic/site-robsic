import 'package:flutter/material.dart';
import 'package:robsic/l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:robsic/main.dart';
import 'package:robsic/src/app_store.dart';
import 'package:robsic/src/resources/resources.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppStore _appStore;
  @override
  void initState() {
    super.initState();
    _appStore = serviceLocator.get<AppStore>();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _appStore,
        builder: (context, locale, _) {
          return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'RobSIC',
              theme: appThemeData,
              routerConfig: router,
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              locale: Locale(locale.languageCode),
              supportedLocales: const [
                Locale('en'),
                Locale('pt'),
              ]);
        });
  }
}
