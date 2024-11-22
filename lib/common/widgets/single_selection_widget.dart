import 'package:flutter/material.dart';

import '../../utils/constants/dynamic_colors.dart';
import '../../utils/constants/sizes.dart';

class SingleSelectionWidget extends StatefulWidget {
  final List<String> options;
  final Function(String) onSelectionChanged;
  final String? selectedItem; // Default selected item
  final Axis scrollDirection; // New parameter for scroll direction

  SingleSelectionWidget({
    required this.options,
    required this.onSelectionChanged,
    this.selectedItem, // Default to null if none provided
    this.scrollDirection = Axis.horizontal, // Default to horizontal if not provided
  });

  @override
  _SingleSelectionWidgetState createState() => _SingleSelectionWidgetState();
}

class _SingleSelectionWidgetState extends State<SingleSelectionWidget> {
  String? _selectedItem;

  @override
  void initState() {
    super.initState();
    // Set initial selected item if provided
    _selectedItem = widget.selectedItem;
  }

  void _onItemTapped(String item) {
    setState(() {
      // Allow only one item to be selected at a time
      _selectedItem = item;
    });
    widget.onSelectionChanged(item);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: widget.scrollDirection, // Use the passed scroll direction
      child: Wrap(
        spacing: SchoolSizes.md, // Space between items horizontally
        runSpacing: SchoolSizes.md, // Space between rows
        children: widget.options.map((option) {
          bool isSelected = _selectedItem == option;

          return GestureDetector(
            onTap: () {
              _onItemTapped(option);
            },
            child: Container(
              constraints: BoxConstraints(minWidth: 36),
              padding: EdgeInsets.symmetric(
                  vertical: SchoolSizes.sm, horizontal: SchoolSizes.sm
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? SchoolDynamicColors.primaryColor
                    : SchoolDynamicColors.backgroundColorGreyLightGrey,
                borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
                border: Border.all(
                  color: isSelected
                      ? SchoolDynamicColors.primaryColor
                      : Colors.transparent,
                  width: isSelected ? 0 : 0.0,
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
                          : SchoolDynamicColors.subtitleTextColor,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
