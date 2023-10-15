part of './app_theme.dart';

final ElevatedButtonThemeData _elevatedButtonThemeData =
    ElevatedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        horizontal: TokenSpaces.xl,
        vertical: TokenSpaces.md,
      ),
    ),
    backgroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused)) {
          return TokenColors.primary;
        } else if (states.contains(MaterialState.disabled)) {
          return TokenColors.gray400;
        }
        return TokenColors.primary80;
      },
    ),
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused)) {
          return TokenColors.gray50;
        } else if (states.contains(MaterialState.disabled)) {
          return TokenColors.gray600;
        }
        return TokenColors.gray50;
      },
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(TokenTextStyles.labelLarge),
  ),
);
