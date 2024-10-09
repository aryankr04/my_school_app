

import 'package:flutter/material.dart';

import '../../../utils/constants/dynamic_colors.dart';
import '../../../utils/helpers/helper_functions.dart';

class SchoolStepper extends StatefulWidget {
  final int noOfSteps ;
  final int activeStep;

  SchoolStepper({
    required this.activeStep, required this.noOfSteps,
  });

  @override
  _SchoolStepperState createState() => _SchoolStepperState();
}

class _SchoolStepperState extends State<SchoolStepper> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.noOfSteps,
            (index) => _buildStep(index),
      ),
    );
  }

  Widget _buildStep(int index) {
    final isActive = widget.activeStep == index;
    final isCompleted = widget.activeStep > index;

    return Row(
      children: [
        Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isCompleted ? SchoolDynamicColors.primaryColor : isActive ? SchoolDynamicColors.primaryColor : Colors.grey[300],
          ),
          child: Center(
            child: isCompleted
                ? Icon(
              Icons.check,
              color: Colors.white,
              size: 16,
            )
                : Text(
              '${index + 1}',
              style: TextStyle(
                color: isActive ? Colors.white : Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (index < widget.noOfSteps - 1) _buildLine(isCompleted),
      ],
    );
  }

  Widget _buildLine(bool isCompleted) {
    return Container(
      width: 40,
      height: 4,
      color: isCompleted ? SchoolDynamicColors.primaryColor : Colors.grey[300],
    );
  }
}
