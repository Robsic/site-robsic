import 'package:flutter/material.dart';
import 'package:robsic/src/core/ui/tokens/tokens.dart';

import 'modules/home/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RobSIC',
      theme: ThemeData(
        colorScheme: const ColorScheme(
            brightness: Brightness.light,
            primary: TokenColors.primary,
            onPrimary: TokenColors.gray50,
            primaryContainer: TokenColors.primary60,
            onPrimaryContainer: TokenColors.gray900,
            secondary: TokenColors.secondary,
            onSecondary: TokenColors.gray50,
            secondaryContainer: TokenColors.secondary60,
            tertiary: TokenColors.emphasis,
            onTertiary: TokenColors.gray50,
            tertiaryContainer: TokenColors.emphasis60,
            onTertiaryContainer: TokenColors.gray900,
            error: TokenColors.alert,
            onError: TokenColors.gray50,
            errorContainer: TokenColors.alert60,
            onErrorContainer: TokenColors.gray900,
            background: TokenColors.gray100,
            onBackground: TokenColors.gray900,
            surface: TokenColors.gray100,
            onSurface: TokenColors.gray900,
            outline: TokenColors.primary40,
            surfaceVariant: TokenColors.primary40,
            onSurfaceVariant: TokenColors.gray600),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(
              const EdgeInsets.symmetric(
                horizontal: TokenSpaces.xl,
                vertical: TokenSpaces.md,
              ),
            ),
            foregroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.focused)) {
                return TokenColors.primary;
              } else if (states.contains(MaterialState.disabled)) {
                return TokenColors.gray400;
              }
              return TokenColors.primary80;
            }),
            textStyle: MaterialStateProperty.resolveWith<TextStyle>((states) {
              if (states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.focused)) {
                return const TextStyle(
                    fontFamily: 'Roboto',
                    //color: TokenColors.primary,
                    fontSize: 16.0,
                    //fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: 0.05);
              } else if (states.contains(MaterialState.disabled)) {
                return const TextStyle(
                    fontFamily: 'Roboto',
                    color: TokenColors.gray400,
                    fontSize: 16.0,
                    //fontWeight: FontWeight.bold,
                    height: 1.2,
                    letterSpacing: 0.05);
              }
              return const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 16.0,
                  //fontWeight: FontWeight.bold,
                  height: 1.2,
                  letterSpacing: 0.05);
            }),
            side: MaterialStateProperty.resolveWith<BorderSide>(
              (states) {
                if (states.contains(MaterialState.hovered) ||
                    states.contains(MaterialState.focused)) {
                  return const BorderSide(
                    color: TokenColors.primary,
                    width: 1.5,
                  );
                } else if (states.contains(MaterialState.disabled)) {
                  return const BorderSide(
                    color: TokenColors.gray400,
                    width: 1.5,
                  );
                }
                return const BorderSide(
                  color: TokenColors.primary,
                );
              },
            ),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}
