import 'package:flutter/material.dart';

import '../../ui/tokens/tokens.dart';

part './app_color_scheme.dart';
part './outlined_button_theme.dart';
part './elevated_button_theme.dart';
part './app_text_theme.dart';

ThemeData appThemeData = ThemeData(
  colorScheme: _appColorScheme,
  outlinedButtonTheme: _outlinedButtonThemeData,
  elevatedButtonTheme: _elevatedButtonThemeData,
  textTheme: _appTextTheme,
);
