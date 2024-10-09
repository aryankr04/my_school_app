import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class ColorChips extends StatelessWidget {
  final Color? color;
  final double? textSize;
  final double? padding;
  final double? borderRadius;
  final String text;

  const ColorChips({
    Key? key,
    this.color,
    this.textSize,
    required this.text, this.padding,this.borderRadius
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 32),
      padding: EdgeInsets.symmetric(
        vertical: padding??4,
        horizontal: (padding ?? 4) * 2,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius??
            SchoolSizes.cardRadiusXs),
        color: color?.withOpacity(0.1) ??
        SchoolDynamicColors.backgroundColorGreyLightGrey,
      ),
      child: Text(
        text,
        style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
          color: color != null ? color : null,
          fontSize: textSize ?? 12.0,
        ),
      ),
    );
  }
}
