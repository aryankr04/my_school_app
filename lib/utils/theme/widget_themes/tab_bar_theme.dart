import 'package:flutter/material.dart';
import '../../constants/dynamic_colors.dart';
import '../../constants/colors.dart';

class SchoolTabBarTheme {
  SchoolTabBarTheme._();

  static TabBarTheme lightTabBarTheme = TabBarTheme(
    labelStyle: const TextStyle(
        color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),
    unselectedLabelStyle: const TextStyle(
        color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),
    unselectedLabelColor: SchoolColors.subtitleTextColor,
    indicator: BoxDecoration(
      color: SchoolColors.primaryColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 3,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    indicatorSize: TabBarIndicatorSize.tab,
    splashFactory: NoSplash.splashFactory,
    dividerColor: Colors.transparent,
  );

  static TabBarTheme darkTabBarTheme = TabBarTheme(
      labelStyle: const TextStyle(
          color: Colors.white, fontSize: 14.0, fontWeight: FontWeight.w500),
      unselectedLabelStyle: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontSize: 14.0,
          fontWeight: FontWeight.w500),
      unselectedLabelColor: Colors.white.withOpacity(0.6),
      indicator: BoxDecoration(
        color: SchoolColors.lightGreyBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      splashFactory: NoSplash.splashFactory,
      dividerColor: Colors.transparent);

  static TabBarTheme defaultTabBarTheme = TabBarTheme();
}
