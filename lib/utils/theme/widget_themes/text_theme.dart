import 'package:flutter/material.dart';
import '../../constants/dynamic_colors.dart';

/// Custom Class for Light & Dark Text Themes
class SchoolTextTheme {
  SchoolTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.w600, color: SchoolDynamicColors.darkBackgroundColor),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: SchoolDynamicColors.darkBackgroundColor),
    headlineSmall: const TextStyle().copyWith(fontSize: 20.0, fontWeight: FontWeight.w600, color: SchoolDynamicColors.darkBackgroundColor),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.darkBackgroundColor),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.darkBackgroundColor),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: SchoolDynamicColors.darkBackgroundColor),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.darkBackgroundColor),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.normal, color: SchoolDynamicColors.darkBackgroundColor),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.darkBackgroundColor.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.darkBackgroundColor),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.darkBackgroundColor.withOpacity(0.5)),
    labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: SchoolDynamicColors.darkBackgroundColor.withOpacity(0.5)),

  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 32.0, fontWeight: FontWeight.bold, color: SchoolDynamicColors.lightBackgroundColor),
    headlineMedium: const TextStyle().copyWith(fontSize: 24.0, fontWeight: FontWeight.w600, color: SchoolDynamicColors.lightBackgroundColor),
    headlineSmall: const TextStyle().copyWith(fontSize: 18.0, fontWeight: FontWeight.w600, color: SchoolDynamicColors.lightBackgroundColor),

    titleLarge: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.lightBackgroundColor),
    titleMedium: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.lightBackgroundColor),
    titleSmall: const TextStyle().copyWith(fontSize: 16.0, fontWeight: FontWeight.w400, color: SchoolDynamicColors.lightBackgroundColor),

    bodyLarge: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.lightBackgroundColor),
    bodyMedium: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.lightBackgroundColor),
    bodySmall: const TextStyle().copyWith(fontSize: 14.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.lightBackgroundColor.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w400, color: SchoolDynamicColors.lightBackgroundColor),
    labelMedium: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.w500, color: SchoolDynamicColors.lightBackgroundColor.withOpacity(0.5)),
    labelSmall: const TextStyle().copyWith(fontSize: 12.0, fontWeight: FontWeight.normal, color: SchoolDynamicColors.lightBackgroundColor.withOpacity(0.5)),
  );
}
