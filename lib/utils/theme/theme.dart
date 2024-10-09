import 'package:flutter/material.dart';
import 'package:my_school_app/utils/theme/widget_themes/appbar_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/bottom_navigation_bar.dart';
import 'package:my_school_app/utils/theme/widget_themes/bottom_sheet_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/card_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/checkbox_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/chip_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/color_scheme_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/outlined_button_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/tab_bar_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/text_field_theme.dart';
import 'package:my_school_app/utils/theme/widget_themes/text_theme.dart';

import '../constants/dynamic_colors.dart';
import '../constants/colors.dart';

class SchoolAppTheme {
  SchoolAppTheme._();

  static ThemeData _baseThemeData(Brightness brightness) {
    return ThemeData(
      primarySwatch: MaterialColor(
        SchoolColors.primaryColor.value,
         <int, Color>{
          50: SchoolColors.primaryColor,
          100: SchoolColors.primaryColor,
          200: SchoolColors.primaryColor,
          300: SchoolColors.primaryColor,
          400: SchoolColors.primaryColor,
          500: SchoolColors.primaryColor,
          600: SchoolColors.primaryColor,
          700: SchoolColors.primaryColor,
          800: SchoolColors.primaryColor,
          900: SchoolColors.primaryColor,
        },
      ),
      useMaterial3: true,
      fontFamily: 'Poppins',
      disabledColor: SchoolColors.grey,
      brightness: brightness,
      primaryColor: SchoolColors.primaryColor,
    );
  }

  static ThemeData get lightTheme => _baseThemeData(Brightness.light).copyWith(
        cardTheme: SchoolCardTheme.lightCardTheme,
        colorScheme: SchoolColorSchemeTheme.lightTheme.colorScheme,
        textTheme: SchoolTextTheme.lightTextTheme,
        chipTheme: SchoolChipTheme.lightChipTheme,
        tabBarTheme: SchoolTabBarTheme.lightTabBarTheme,
        bottomNavigationBarTheme:
            SchoolBottomNavigationBarTheme.lightBottomNavigationBar,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: SchoolAppBarTheme.lightAppBarTheme,
        checkboxTheme: SchoolCheckboxTheme.lightCheckboxTheme,
        bottomSheetTheme: SchoolBottomSheetTheme.lightBottomSheetTheme,
        elevatedButtonTheme: SchoolElevatedButtonTheme.lightElevatedButtonTheme,
        outlinedButtonTheme: SchoolOutlinedButtonTheme.lightOutlinedButtonTheme,
        inputDecorationTheme:
            SchoolTextFormFieldTheme.lightInputDecorationTheme,
      );


  static ThemeData get darkTheme => _baseThemeData(Brightness.dark).copyWith(
        cardTheme: SchoolCardTheme.darkCardTheme,
        colorScheme: SchoolColorSchemeTheme.darkTheme.colorScheme,
        textTheme: SchoolTextTheme.darkTextTheme,
        chipTheme: SchoolChipTheme.darkChipTheme,
        tabBarTheme: SchoolTabBarTheme.darkTabBarTheme,
        bottomNavigationBarTheme:
            SchoolBottomNavigationBarTheme.darkBottomNavigationBar,
        scaffoldBackgroundColor: SchoolColors.black,
        appBarTheme: SchoolAppBarTheme.darkAppBarTheme,
        checkboxTheme: SchoolCheckboxTheme.darkCheckboxTheme,
        bottomSheetTheme: SchoolBottomSheetTheme.darkBottomSheetTheme,
        elevatedButtonTheme: SchoolElevatedButtonTheme.darkElevatedButtonTheme,
        outlinedButtonTheme: SchoolOutlinedButtonTheme.darkOutlinedButtonTheme,
        inputDecorationTheme: SchoolTextFormFieldTheme.darkInputDecorationTheme,
      );
}
