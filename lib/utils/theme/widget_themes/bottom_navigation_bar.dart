import 'package:flutter/material.dart';

import '../../constants/colors.dart';

class SchoolBottomNavigationBarTheme {
  SchoolBottomNavigationBarTheme._();
  static final lightBottomNavigationBar = BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedLabelStyle:
          const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      selectedItemColor: SchoolColors.primaryColor,
      unselectedItemColor: SchoolColors.iconColor,
      backgroundColor: SchoolColors.black,
      elevation: 10);

  static final darkBottomNavigationBar = BottomNavigationBarThemeData(
      showUnselectedLabels: true,
      selectedLabelStyle:
          const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
      unselectedLabelStyle:
          const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
      selectedItemColor: SchoolColors.white,
      unselectedItemColor: SchoolColors.white.withOpacity(.5),
      backgroundColor: SchoolColors.white,
      elevation: 10);
}
