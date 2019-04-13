import 'package:flutter/material.dart';

class AppTheme {
  static const ThemeColors safeColors = const ThemeColors(
    primaryColor: AppColors.blue,
    darkColor: AppColors.blueDark,
    textColor: AppColors.grey,
  );

  static const ThemeColors unsafeColors = const ThemeColors(
    primaryColor: AppColors.red,
    darkColor: AppColors.redDark,
    textColor: AppColors.grey,
  );

  static const ThemeColors maybeSafeColors = const ThemeColors(
    primaryColor: AppColors.lightBlue,
    darkColor: AppColors.lightBlueDark,
    textColor: AppColors.grey,
  );
}

class AppColors {
  static const Color blue = Color(0xff008cff);
  static const Color blueDark = Color(0xff252d4d);

  static const Color red = Color(0xfff6414a);
  static const Color redDark = Color(0xff471215);

  static const Color lightBlue = Color(0xff00bee9);
  static const Color lightBlueDark = Color(0xFF000D34);

  static const Color grey = Color(0xff616161);
  static const Color lightGrey = Color(0xffe7e7e7);
}

class ThemeColors {
  final Color primaryColor;
  final Color darkColor;
  final Color textColor;

  const ThemeColors({this.primaryColor, this.darkColor, this.textColor});
}
