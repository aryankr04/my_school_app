import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class SchoolTextFormField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? prefixText;
  final String? suffixText;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final InputDecoration? decoration;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final int? maxLines;
  bool? obscureText;
  SchoolTextFormField({
    this.labelText,
    this.prefixText,
    this.suffixIcon,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.onTap,
    this.decoration,
    this.readOnly,
    this.suffixText,
    this.prefixIcon,
    this.hintText,
    this.validator,
    this.maxLines,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText ?? '',
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500, ),
        ),
        SizedBox(
          height: 6,
        ),
        TextFormField(
          controller: controller,
          onChanged: onChanged,
          keyboardType: keyboardType,
          onTap: onTap,
          readOnly: readOnly ?? false,
          decoration: decoration ??
              InputDecoration(
                hintText: labelText,
                hintStyle: Theme.of(context).textTheme.bodySmall,
                filled: true,
                fillColor: SchoolDynamicColors.backgroundColorTintLightGrey,
                prefixText: prefixText,
                prefixIcon: prefixIcon != null
                    ? Icon(
                        prefixIcon,
                        color: SchoolDynamicColors.iconColor,
                      )
                    : null,
                suffixText: suffixText,
                suffixIcon: suffixIcon != null
                    ? Icon(
                        suffixIcon,
                        color: SchoolDynamicColors.iconColor,
                      )
                    : null,
                border: InputBorder.none,
                enabledBorder: const OutlineInputBorder().copyWith(
                  borderRadius:
                      BorderRadius.circular(SchoolSizes.inputFieldRadius),
                  borderSide:
                      BorderSide(width: 0, color: SchoolDynamicColors.backgroundColorWhiteDarkGrey),
                ),
                focusedBorder: const OutlineInputBorder().copyWith(
                  borderRadius:
                      BorderRadius.circular(SchoolSizes.inputFieldRadius),
                  borderSide:
                       BorderSide(width: 1.5, color: SchoolDynamicColors.primaryColor),
                ),
                errorBorder: const OutlineInputBorder().copyWith(
                  borderRadius:
                      BorderRadius.circular(SchoolSizes.inputFieldRadius),
                  borderSide:
                      BorderSide(width: 1, color: SchoolDynamicColors.activeRed),
                ),
                focusedErrorBorder: const OutlineInputBorder().copyWith(
                  borderRadius:
                      BorderRadius.circular(SchoolSizes.inputFieldRadius),
                  borderSide:
                      BorderSide(width: 2, color: SchoolDynamicColors.activeRed),
                ),
              ),
          validator: validator,
          maxLines: maxLines,
        ),
      ],
    );
  }
}
