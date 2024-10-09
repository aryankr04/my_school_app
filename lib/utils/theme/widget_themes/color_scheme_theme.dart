import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

import '../../constants/colors.dart';

class SchoolColorSchemeTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme:  ColorScheme.light(
      primary: SchoolColors.primaryColor,
      secondary: SchoolColors.primaryColor,
      background: Colors.white,
      surface: Colors.white,
      onBackground: Colors.black,
      onSurface: Colors.black,
      onError: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      error: SchoolColors.activeRed,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: SchoolColors.primaryColor,
      secondary: SchoolColors.primaryColor,
      background: Colors.black,
      surface: Colors.black,
      onBackground: Colors.white,
      onSurface: Colors.white,
      onError: Colors.black,
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      error: SchoolColors.activeRed,
    ),
  );
}
