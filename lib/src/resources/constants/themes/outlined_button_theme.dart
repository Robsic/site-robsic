part of './app_theme.dart';

final OutlinedButtonThemeData _outlinedButtonThemeData =
    OutlinedButtonThemeData(
  style: ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(
      const EdgeInsets.symmetric(
        horizontal: TokenSpaces.xl,
        vertical: TokenSpaces.md,
      ),
    ),
    foregroundColor: MaterialStateProperty.resolveWith(
      (states) {
        if (states.contains(MaterialState.hovered) ||
            states.contains(MaterialState.focused)) {
          return TokenColors.primary;
        } else if (states.contains(MaterialState.disabled)) {
          return TokenColors.gray600;
        }
        return TokenColors.primary80;
      },
    ),
    textStyle: MaterialStateProperty.all<TextStyle>(TokenTextStyles.labelLarge),
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
);
