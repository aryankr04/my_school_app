import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../features/user/student/result/create_result_format.dart';

class CustomDataTable extends StatelessWidget {
  CustomDataTable({super.key, required this.subjects});

  final List<SubjectFormat> subjects;

  double? width = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHeaderRow(),
          ..._buildDataRows(),
        ],
      ),
    );
  }

  Widget _buildHeaderRow() {
    return Row(
      children: [
        Container(
          width: 100,
          alignment: Alignment.center,
          color: SchoolDynamicColors.activeBlue.withOpacity(0.1),
          child: Text('Student'),
        ),
        for (var subject in subjects)
          Container(
            width: getTextWidth(subject.parameters
                .map((parameter) =>
                    '${parameter.parameterName}(${parameter.marks})')
                .join('          ')),
            padding: EdgeInsets.symmetric(vertical: 4),
            color: SchoolDynamicColors.activeBlue.withOpacity(0.1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${subject.subjectName} (${subject.marks})',
                  style: Theme.of(Get.context!).textTheme.titleLarge,
                ),
                Divider(
                  thickness: 0.5,
                  color: SchoolDynamicColors.black,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var parameter in subject.parameters)
                      Container(
                        alignment: Alignment.center,
                        width: getTextWidth(
                            '${parameter.parameterName}(${parameter.marks})     '),
                        child: Text(
                            '${parameter.parameterName}(${parameter.marks})'),
                      ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }

  List<Widget> _buildDataRows() {
    List<Widget> rows = [];

    // Adding a single row for the student data
    rows.add(
      Row(
        children: [
          Container(
            width: 100,
            child: Text('John'),
          ),
          for (var subject in subjects)
            Row(
              children: [
                for (var parameter in subject.parameters)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    alignment: Alignment.center,
                    width: getTextWidth(
                        '${parameter.parameterName}(${parameter.marks})     '),
                    decoration: BoxDecoration(
                      border:
                          Border.all(width: 0.5, color: SchoolDynamicColors.darkGrey),
                    ),
                    child: Text(parameter.marks),
                  ),
              ],
            ),
        ],
      ),
    );

    return rows;
  }

  double? _calculateMaxWidth(String columnTitle, List<SubjectFormat> subjects) {
    double? maxWidth;

    for (var subject in subjects) {
      if (columnTitle == 'Student') {
        maxWidth = maxWidth == null ? 100 : maxWidth;
      } else if (subject.subjectName == columnTitle) {
        for (var parameter in subject.parameters) {
          double textWidth = getTextWidth(parameter.parameterName);
          maxWidth = maxWidth == null
              ? textWidth
              : (textWidth > maxWidth ? textWidth : maxWidth);
        }
      }
    }
    
    return maxWidth;
  }

  double getTextWidth(String text) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(fontSize: 14.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    return textPainter.width;
  }
}
