import 'package:flutter/material.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';

class DayCardButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  DayCardButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: SchoolSizes.xs, horizontal: SchoolSizes.sm + 4),
        decoration: BoxDecoration(
          color: isSelected
              ? SchoolDynamicColors.primaryColor
              : SchoolDynamicColors.backgroundColorGreyLightGrey,
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
          border: Border.all(
            color: isSelected ? SchoolDynamicColors.primaryColor : Colors.transparent,
            width: isSelected ? 1 : 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  color: isSelected
                      ? SchoolDynamicColors.white
                      : SchoolDynamicColors.subtitleTextColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
