import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../../constants/dynamic_colors.dart';
import '../../constants/colors.dart';

class SchoolAppBarTheme {
  SchoolAppBarTheme._();

  static final lightAppBarTheme = AppBarTheme(
    //elevation: 2,
    centerTitle: true,
    //scrolledUnderElevation: 4,
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.black,
    iconTheme: const IconThemeData(color: SchoolColors.darkBackgroundColor, size: SchoolSizes.iconMd),
    actionsIconTheme: const IconThemeData(color: SchoolColors.darkBackgroundColor, size: SchoolSizes.iconMd),
    titleTextStyle:  TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: SchoolColors.headlineTextColor),
    shadowColor: Colors.black.withOpacity(0.5), // Add this line for shadow color
  );

  static final darkAppBarTheme = AppBarTheme(
    //elevation: 2,
    centerTitle: true,
    //scrolledUnderElevation: 4,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    iconTheme: const IconThemeData(color: SchoolColors.white, size: SchoolSizes.iconMd),
    actionsIconTheme: const IconThemeData(color: SchoolColors.white, size: SchoolSizes.iconMd),
    titleTextStyle: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500, color: SchoolColors.white),
    shadowColor: Colors.black.withOpacity(0.5), // Add this line for shadow color
  );
}
