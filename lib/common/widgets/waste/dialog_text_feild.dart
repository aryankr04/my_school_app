import 'package:flutter/material.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

import '../../../utils/constants/sizes.dart';


class CustomChipSelectionWidget extends StatefulWidget {
  final List<String> chipOptions;
  final Function(List<String>) onSelectionChanged;

  CustomChipSelectionWidget({
    required this.chipOptions,
    required this.onSelectionChanged,
  });

  @override
  _CustomChipSelectionWidgetState createState() =>
      _CustomChipSelectionWidgetState();
}

class _CustomChipSelectionWidgetState
    extends State<CustomChipSelectionWidget> {
  List<String> selectedChips = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ChipsChoice<String>.multiple(
          value: selectedChips,
          wrapped: true,

          choiceStyle: const C2ChipStyle(),
          //choiceCheckmark: true,
          runSpacing: SchoolSizes.spaceBtwItems,
          spacing: SchoolSizes.spaceBtwItems,
          onChanged: (val) {
            setState(() {
              selectedChips = val;
              widget.onSelectionChanged(selectedChips);
            });
          },
          choiceItems: C2Choice.listFrom<String, String>(
            source: widget.chipOptions,
            value: (i, v) => v,
            label: (i, v) => v,
          ),
        ),
        SizedBox(height: 16.0),
        //Text('Selected Chips: ${selectedChips.join(', ')}'),
      ],
    );
  }
}
