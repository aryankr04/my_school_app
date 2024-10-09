
import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

import '../../constants/colors.dart';

class SchoolCardTheme {
  SchoolCardTheme._();

  static CardTheme lightCardTheme = CardTheme(
    color: SchoolColors.primaryColor
  );
  static CardTheme darkCardTheme = CardTheme(
    color: SchoolColors.primaryColor.withOpacity(0.5)
  );
}
