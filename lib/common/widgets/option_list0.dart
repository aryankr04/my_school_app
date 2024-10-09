import 'package:flutter/material.dart';

import '../../utils/constants/dynamic_colors.dart';
import '../../utils/constants/sizes.dart';

class CardButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  CardButton({
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        constraints: const BoxConstraints(
          minWidth: 65,
        ),
        padding: EdgeInsets.symmetric(vertical: SchoolSizes.sm,horizontal: SchoolSizes.md),
        decoration: BoxDecoration(
          color: isSelected ? SchoolDynamicColors.primaryColor : SchoolDynamicColors.backgroundColorGreyLightGrey,
          borderRadius: BorderRadius.circular(48),
          border: Border.all(
            color: isSelected
                ? SchoolDynamicColors.primaryColor
                : SchoolDynamicColors.borderColor,
            width: isSelected ? 1 : 0.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontSize: 13,
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
