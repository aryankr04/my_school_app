import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../../utils/constants/dynamic_colors.dart';

class OptionList extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String?> onItemSelected;

  OptionList({required this.options, required this.onItemSelected});

  @override
  _OptionListState createState() => _OptionListState();
}

class _OptionListState extends State<OptionList> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      children: widget.options.map((option) {
        bool isSelected = option == selectedOption;
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedOption = isSelected ? null : option;
            });
            widget.onItemSelected(selectedOption);
          },
          child: Container(
            constraints: const BoxConstraints(
              minWidth: 65,
            ),
            padding: EdgeInsets.symmetric(vertical: SchoolSizes.sm,horizontal: SchoolSizes.md),
            margin: const EdgeInsets.all(4), // Add margin between options
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
                  option,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected
                        ? SchoolDynamicColors.white
                        : SchoolDynamicColors.headlineTextColor,
                    fontWeight: isSelected ? FontWeight.w600 : null,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
