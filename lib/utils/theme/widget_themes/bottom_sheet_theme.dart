import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

class SchoolBottomSheetTheme {
  SchoolBottomSheetTheme._();

  static BottomSheetThemeData lightBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: SchoolDynamicColors.white,
    modalBackgroundColor: SchoolDynamicColors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );

  static BottomSheetThemeData darkBottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: SchoolDynamicColors.black,
    modalBackgroundColor: SchoolDynamicColors.black,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}
