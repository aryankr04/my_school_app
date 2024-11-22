import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/dynamic_colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class SchoolOutlinedButtonTheme {
  SchoolOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 0),
      elevation: 0,
      foregroundColor: SchoolColors.darkBackgroundColor,
      side:  BorderSide(color: SchoolColors.borderColor),
      textStyle: const TextStyle(fontSize: 16, color: SchoolColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: SchoolSizes.md, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SchoolSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      minimumSize: const Size(double.infinity, 0),
      foregroundColor: SchoolColors.lightBackgroundColor,
      side:  BorderSide(color: SchoolColors.borderColor),
      textStyle: TextStyle(fontSize: 16, color: SchoolColors.whiteTextColor, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: SchoolSizes.md,),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(SchoolSizes.buttonRadius)),
    ),
  );
}
