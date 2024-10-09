import 'package:flutter/material.dart';
import '../../constants/dynamic_colors.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class SchoolElevatedButtonTheme {
  SchoolElevatedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 0),
      elevation: SchoolSizes.buttonElevation,
      foregroundColor: SchoolColors.lightBackgroundColor,
      backgroundColor: SchoolColors.primaryColor,
      disabledForegroundColor: SchoolColors.darkGrey,
      disabledBackgroundColor: SchoolColors.disabledButtonColor,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(vertical: SchoolSizes.buttonHeight),
      textStyle:  TextStyle(fontSize: 18, color: SchoolColors.whiteTextColor, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      minimumSize: const Size(double.infinity, 0),
      elevation: SchoolSizes.buttonElevation,
      foregroundColor: SchoolColors.lightBackgroundColor,
      backgroundColor: SchoolColors.primaryColor,
      disabledForegroundColor: SchoolColors.darkGrey,
      disabledBackgroundColor: SchoolColors.darkerGrey,
      side: BorderSide.none,
      padding: const EdgeInsets.symmetric(vertical: SchoolSizes.buttonHeight),
      textStyle:  TextStyle(fontSize: 18, color: SchoolColors.whiteTextColor, fontWeight: FontWeight.w500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SchoolSizes.md)),
    ),
  );
}
