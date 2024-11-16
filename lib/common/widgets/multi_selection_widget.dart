
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/dynamic_colors.dart';
import '../../utils/constants/sizes.dart';

class MultiSelectionWidget extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelectionChanged;
  final List<String> selectedItems; // New parameter for default selected items
  final bool showSelectAll; // New parameter to show/hide the "All" button

  MultiSelectionWidget({
    required this.options,
    required this.onSelectionChanged,
    this.selectedItems = const [], // Default to an empty list if none provided
    this.showSelectAll = true, // Default to true to show the "All" button
  });

  @override
  _MultiSelectionWidgetState createState() => _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends State<MultiSelectionWidget> {
  List<bool> _isSelected = [];
  late RxBool isSelectedAll;

  @override
  void initState() {
    super.initState();
    // Initialize selection state based on the provided selectedItems
    _isSelected = List<bool>.generate(widget.options.length, (index) {
      return widget.selectedItems.contains(widget.options[index]);
    });
    isSelectedAll = _isSelected
        .every((selected) => selected)
        .obs; // Initialize isSelectedAll
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12, // Adjust spacing as needed
      runSpacing: 12, // Adjust run spacing as needed
      children: [
        // Option to select all, shown based on the showSelectAll parameter
        if (widget.showSelectAll) // Conditionally render the "All" button
          InkWell(
            onTap: () {
              setState(() {
                // Toggle selection state for all options
                for (int i = 0; i < _isSelected.length; i++) {
                  _isSelected[i] = !isSelectedAll.value;
                }
                widget.onSelectionChanged(_getSelectedOptions());
                isSelectedAll
                    .toggle(); // Toggle isSelectedAll using GetX toggle method
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: SchoolSizes.xs,
                horizontal: SchoolSizes.sm + 4,
              ),
              decoration: BoxDecoration(
                color: isSelectedAll.value
                    ? SchoolDynamicColors.primaryColor
                    : SchoolDynamicColors.backgroundColorGreyLightGrey,
                borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
              ),
              child: Text(
                'All',
                style: TextStyle(
                  fontSize: 14,
                  color: isSelectedAll.value
                      ? SchoolDynamicColors.white
                      : SchoolDynamicColors.subtitleTextColor,
                  fontWeight:
                  isSelectedAll.value ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ),
        // Options list
        ...List.generate(
          widget.options.length,
              (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected[index] = !_isSelected[index];
                  widget.onSelectionChanged(_getSelectedOptions());
                  // Check if all options are selected
                  isSelectedAll.value =
                      _isSelected.every((isSelected) => isSelected);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: SchoolSizes.xs,
                  horizontal: SchoolSizes.sm + 4,
                ),
                decoration: BoxDecoration(
                  color: _isSelected[index]
                      ? SchoolDynamicColors.primaryColor
                      : SchoolDynamicColors.backgroundColorGreyLightGrey,
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
                  border: Border.all(
                    color: _isSelected[index]
                        ? SchoolDynamicColors.primaryColor
                        : Colors.transparent,
                    width: _isSelected[index] ? 0 : 0.0,
                  ),
                ),
                child: Text(
                  widget.options[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: _isSelected[index]
                        ? SchoolDynamicColors.white
                        : SchoolDynamicColors.subtitleTextColor,
                    fontWeight:
                    _isSelected[index] ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Get the list of selected options
  List<String> _getSelectedOptions() {
    List<String> selectedOptions = [];
    for (int i = 0; i < _isSelected.length; i++) {
      if (_isSelected[i]) {
        selectedOptions.add(widget.options[i]);
      }
    }
    return selectedOptions;
  }
}
