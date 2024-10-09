import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/colors.dart';

class SchoolDynamicColors {
  // App theme colors
  static Color getThemeBasedColor(Color lightColor, Color darkColor) {
    bool isDarkMode =
        MediaQuery.of(Get.context!).platformBrightness == Brightness.dark;
    return isDarkMode ? darkColor : lightColor;
  }

  // Primary color
  static Color get primaryColor => getThemeBasedColor(
      SchoolColors.primaryColor, SchoolColors.primaryColor.withOpacity(0.8));

  // Primary Tint Color
  static Color get primaryTintColor => getThemeBasedColor(
      SchoolColors.primaryTintColor, SchoolColors.primaryTintColor.withOpacity(0.8));

  // Secondary color
  static Color get secondaryColor => getThemeBasedColor(
      SchoolColors.secondaryColor, SchoolColors.secondaryColor.withOpacity(0.8));

  // Secondary Tint Color
  static Color get secondaryTintColor => getThemeBasedColor(
      SchoolColors.secondaryTintColor,
      SchoolColors.secondaryTintColor.withOpacity(0.8));

  // Primary text color
  static Color get primaryTextColor =>
      getThemeBasedColor(SchoolColors.primaryColor, SchoolColors.white);

  // Headline text color
  static Color get headlineTextColor =>
      getThemeBasedColor(SchoolColors.headlineTextColor, SchoolColors.white);

  // Subtitle text color
  static Color get subtitleTextColor => getThemeBasedColor(
      SchoolColors.subtitleTextColor, SchoolColors.whiteTextColor.withOpacity(0.5));

  // White text color
  static Color get whiteTextColor =>
      getThemeBasedColor(SchoolColors.white, SchoolColors.white);
  static const Color placeholderColor = CupertinoColors.inactiveGray;

  /// Background color tint for light & dark grey for dark theme
  static Color get backgroundColorTintDarkGrey => getThemeBasedColor(
      SchoolColors.primaryTintColor, SchoolColors.darkGreyBackgroundColor);

  // Background color tint for light & light grey for Dark theme
  static Color get backgroundColorTintLightGrey => getThemeBasedColor(
      SchoolColors.primaryTintColor, SchoolColors.lightGreyBackgroundColor);

  // Background color primary for light & light grey for dark theme
  static Color get backgroundColorPrimaryLightGrey => getThemeBasedColor(
      SchoolColors.primaryColor, SchoolColors.lightGreyBackgroundColor);

  // Background color primary for light & dark grey for dark theme
  static Color get backgroundColorPrimaryDarkGrey => getThemeBasedColor(
      SchoolColors.primaryColor, SchoolColors.darkGreyBackgroundColor);

  // Background color white for light & dark grey for dark theme
  static Color get backgroundColorWhiteDarkGrey =>
      getThemeBasedColor(SchoolColors.white, SchoolColors.darkGreyBackgroundColor);

  // Background color white for light & light grey for dark theme
  static Color get backgroundColorWhiteLightGrey =>
      getThemeBasedColor(SchoolColors.white, SchoolColors.lightGreyBackgroundColor);

  // Background color grey for light & light grey for dark theme
  static Color get backgroundColorGreyLightGrey => getThemeBasedColor(
      SchoolColors.backgroundAccentColor, const Color(0xFF373948));

 

  //Button Primary Color
  static Color get primaryButtonColor => getThemeBasedColor(
      SchoolColors.primaryButtonColor, SchoolColors.primaryButtonColor);

  //Button Secondary Color
  static Color get secondaryButtonColor => getThemeBasedColor(
      SchoolColors.secondaryButtonColor, SchoolColors.secondaryButtonColor);

  //Button Tertiary Color
  static Color get tertiaryButtonColor => getThemeBasedColor(
      SchoolColors.tertiaryButtonColor, SchoolColors.tertiaryButtonColor);

  //Button Disable Color
  static Color get disabledButtonColor => getThemeBasedColor(
      SchoolColors.disabledButtonColor, SchoolColors.disabledButtonColor);

  //Icon Primary Color
  static Color get primaryIconColor =>
      getThemeBasedColor(SchoolColors.primaryColor, SchoolColors.white);

  // Icon Color
  static Color get iconColor =>
      getThemeBasedColor(SchoolColors.iconColor, SchoolColors.white);

  //Icon Disabled Color
  static Color get disabledIconColor =>
      getThemeBasedColor(SchoolColors.disabledIconColor, SchoolColors.white);

  // Border color
  static Color get borderColor => getThemeBasedColor(
      SchoolColors.borderColor, SchoolColors.lightGreyBackgroundColor);

  // Border primary color
  static Color get primaryBorderColor =>
      getThemeBasedColor(SchoolColors.primaryColor, SchoolColors.white);

  //Active Green Color
  static Color get activeGreen =>
      getThemeBasedColor(SchoolColors.activeGreen, SchoolColors.activeGreen);

  //Active Blue Color
  static Color get activeBlue =>
      getThemeBasedColor(SchoolColors.activeBlue, SchoolColors.activeBlue);

  //Active Orange Color
  static Color get activeOrange =>
      getThemeBasedColor(SchoolColors.activeOrange, SchoolColors.activeOrange);

  //Active Red Color
  static Color get activeRed =>
      getThemeBasedColor(SchoolColors.activeRed, SchoolColors.activeRed);

  //Active Green Color
  static Color get activeGreenTint =>
      getThemeBasedColor(SchoolColors.activeGreenTint, SchoolColors.activeGreenTint);

  //Active Blue Color
  static Color get activeBlueTint =>
      getThemeBasedColor(SchoolColors.activeBlueTint, SchoolColors.activeBlueTint);

  //Active Orange Color
  static Color get activeOrangeTint =>
      getThemeBasedColor(SchoolColors.activeOrangeTint, SchoolColors.activeOrangeTint);

  //Active Red Color
  static Color get activeRedTint =>
      getThemeBasedColor(SchoolColors.activeRedTint, SchoolColors.activeRedTint);

  
  
  

  //My Grey
  static const Color lightGreyBackgroundColor = Color(0xFF373948);
  static const Color darkGreyBackgroundColor = Color(0xFF272733);
  static const Color darkerGreyBackgroundColor = Color(0xFF1D1D27);

  // Background colors
  static const Color lightBackgroundColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF202124);

  // Neutral Shades
  static const Color black = Color(0xFF1D1D27);
  static const Color darkerGrey = Color(0xFF4F4F4F);
  static const Color darkGrey = Color(0xFF939393);
  static const Color grey = Color(0xFFE0E0E0);
  static const Color softGrey = Color(0xFFF4F4F4);
  static const Color lightGrey = Color(0xFFF9F9F9);
  static const Color white = Color(0xFFFFFFFF);

  //Colors
  static const Color colorOrange = Color(0xFFFF9066);
  static const Color colorYellow = Color(0xFFFFC844);
  static const Color colorGreen = Color(0xFF3AD0AE);
  static const Color colorSkyBlue = Color(0xFF3ED4F6);
  static const Color colorBlue = Color(0xFF5BBFFF);
  static const Color colorTeal = Color(0xFF3CC4C4);
  static const Color colorPink = Color(0xFFD67AF1);
  static const Color colorRed = Color(0xFFFF769F);
  static const Color colorPurple = Color(0xFFB16FEF);
  static const Color colorViolet = Color(0xFF787DFF);
}
