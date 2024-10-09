import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class SchoolTextFormFieldTheme {
  SchoolTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SchoolColors.iconColor,
    suffixIconColor: SchoolColors.iconColor,
    contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
    labelStyle: const TextStyle().copyWith(fontSize: SchoolSizes.fontSizeMd, color: SchoolColors.placeholderColor,),
    hintStyle: const TextStyle().copyWith(fontSize: SchoolSizes.fontSizeMd, fontWeight: FontWeight.w400, color: SchoolColors.placeholderColor),

    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(color: SchoolColors.black.withOpacity(0.8)),
    border: InputBorder.none,
    enabledBorder: const OutlineInputBorder().copyWith(

      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 0, ),
    ),
    focusedBorder:const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide:  BorderSide(width: 1.5, color: SchoolColors.primaryColor),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: SchoolColors.activeRed),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SchoolColors.activeRed),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: SchoolColors.darkGrey,
    suffixIconColor: SchoolColors.darkGrey,
    contentPadding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
    labelStyle: const TextStyle().copyWith(fontSize: SchoolSizes.fontSizeMd, color: SchoolColors.white),
    hintStyle: const TextStyle().copyWith(fontSize: SchoolSizes.fontSizeMd, color: SchoolColors.white),
    floatingLabelStyle: const TextStyle().copyWith(color: SchoolColors.white.withOpacity(0.8)),
    border: InputBorder.none,
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 0, color: Colors.transparent),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.5, color: SchoolColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1.5, color: SchoolColors.activeRed),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(SchoolSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: SchoolColors.activeRed),
    ),
  );
}
