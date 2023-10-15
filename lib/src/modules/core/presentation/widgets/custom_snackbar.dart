import 'package:flutter/material.dart';

import '../../../../core/core.dart';

enum SnackBarType { success, error, warning }

SnackBar customSnackBar(
  BuildContext context, {
  required SnackBarType snackBarType,
  required String message,
}) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;

  Color getSnackBarColor() {
    return snackBarType == SnackBarType.error
        ? colorScheme.error
        : colorScheme.primary;
  }

  return SnackBar(
    backgroundColor: getSnackBarColor(),
    content: Center(
      child: BodyTextAtom(
        text: message,
        textStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
    ),
  );
}
