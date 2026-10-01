import 'package:flutter/material.dart';

class _BreakPoints {
  static const mobile = 300.0;
  static const tablet = 720.0;
  static const desktop = 1024.0;
}

enum ScreenType {
  mobile(_BreakPoints.mobile),
  tablet(_BreakPoints.tablet),
  desktop(_BreakPoints.desktop);

  const ScreenType(this.minValue);
  final double minValue;
}

class ResponsiveUtils {
  static bool isMobile(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth < ScreenType.tablet.minValue;
  }

  static bool isTablet(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth >= ScreenType.tablet.minValue &&
        deviceWidth < ScreenType.desktop.minValue;
  }

  static bool isDesktop(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return deviceWidth >= ScreenType.desktop.minValue;
  }
}
