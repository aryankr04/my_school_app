import 'package:flutter/material.dart';
import '../../constants/dynamic_colors.dart';
import '../../constants/colors.dart';

class SchoolChipTheme {
  SchoolChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: SchoolColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: SchoolColors.black),
    selectedColor: SchoolColors.primaryColor,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: SchoolColors.white,
  );

  static ChipThemeData darkChipTheme = ChipThemeData(
    disabledColor: SchoolColors.darkerGrey,
    labelStyle: TextStyle(color: SchoolColors.white),
    selectedColor: SchoolColors.primaryColor,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: SchoolColors.white,
  );
}
