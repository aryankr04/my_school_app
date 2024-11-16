import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utils/constants/dynamic_colors.dart';
import '../../utils/constants/sizes.dart';

class SchoolDropdownFormField extends StatefulWidget {
  final List<String>? items;
  final String? labelText;
  final String? hintText;
  String? selectedValue;
  String? suffixText;
  IconData? suffixIcon;
  final InputDecoration? decoration;
  String? prefixText;
  IconData? prefixIcon;
  final bool? isValidate;
  final void Function(String)? onSelected;

  SchoolDropdownFormField({
    super.key,
    this.items,
    this.labelText,
    this.suffixText,
    this.prefixText,
    this.suffixIcon,
    this.prefixIcon,
    this.isValidate,
    this.hintText,
    this.decoration,
    this.selectedValue,
    this.onSelected,
  });

  @override
  _SchoolDropdownFormFieldState createState() =>
      _SchoolDropdownFormFieldState();
}

class _SchoolDropdownFormFieldState extends State<SchoolDropdownFormField> {
  @override
  Widget build(BuildContext context) {
    // Ensure that the selectedValue is valid
    widget.selectedValue = widget.items?.contains(widget.selectedValue) == true
        ? widget.selectedValue
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText!,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const SizedBox(height: 6),
        ButtonTheme(
          // alignedDropdown: true,
          child: DropdownButtonFormField<String>(
            value: widget.selectedValue,
            alignment: Alignment.centerLeft,
            hint: Text(
              widget.hintText ?? 'Select ${widget.labelText}', // Provide a hint text
              style: Theme.of(context).textTheme.bodySmall,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            icon: Icon(Icons.keyboard_arrow_down_rounded),
            decoration: widget.decoration ??
                InputDecoration(
                  filled: true,
                  fillColor: SchoolDynamicColors.backgroundColorTintLightGrey,
                  prefixIcon: widget.prefixIcon != null
                      ? Icon(widget.prefixIcon,
                          color: SchoolDynamicColors.iconColor)
                      : null,
                  suffixIcon: widget.suffixIcon != null
                      ? Icon(widget.suffixIcon,
                          color: SchoolDynamicColors.iconColor)
                      : null,
                  prefixText: widget.prefixText,
                  suffixText: widget.suffixText ?? '',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: InputBorder.none,
                  enabledBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(SchoolSizes.inputFieldRadius),
                    borderSide: BorderSide(
                        width: 0,
                        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey),
                  ),
                  focusedBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(SchoolSizes.inputFieldRadius),
                    borderSide: BorderSide(
                        width: 1.5, color: SchoolDynamicColors.primaryColor),
                  ),
                  errorBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(SchoolSizes.inputFieldRadius),
                    borderSide: BorderSide(
                        width: 1, color: SchoolDynamicColors.activeRed),
                  ),
                  focusedErrorBorder: const OutlineInputBorder().copyWith(
                    borderRadius:
                        BorderRadius.circular(SchoolSizes.inputFieldRadius),
                    borderSide: BorderSide(
                        width: 2, color: SchoolDynamicColors.activeRed),
                  ),
                ),
            items: widget.items?.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Row(
                  children: [
                    Text(
                      item,
                      style: Theme.of(context).textTheme.bodyLarge,
                      overflow: TextOverflow.ellipsis, // Handle overflow
                      maxLines: 1, // Limit the number of lines
                    ),
                  ],
                ),
              );
            }).toList(),
            validator: (value) {
              // Check if validation is enabled
              if (widget.isValidate == true) {
                // If the value is null or empty, return an error message
                if (value == null || value.isEmpty) {
                  return ''; // Custom error message
                }
              }
              return null; // Return null if the value is valid or validation is not enabled
            },
            onChanged: (val) {
              setState(() {
                widget.selectedValue = val!;
              });

              // Notify the parent widget when the value changes
              widget.onSelected?.call(val!);
            },
            isExpanded: true,
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }
}
