import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../utils/constants/dynamic_colors.dart';


class SchoolStaffStep0Form extends StatelessWidget {
  final List<String> stepNames = [
    'Introduction to Teacher Registration',
    'Basic Information',
    'Employment Details',
    'Educational Qualifications',
    'Contact Information',
    'Authentication'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Registration in 5 Easy Steps",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(),
            ),
            SizedBox(
              height: SchoolSizes.lg,
            ),
            stepInfoRow(stepNames[1]),
            stepInfoRow(stepNames[2]),
            stepInfoRow(stepNames[3]),
            stepInfoRow(stepNames[4]),
            stepInfoRow(stepNames[5]),

          ],
        ),
      ),
    );
  }

  Widget stepInfoRow(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: SchoolDynamicColors.activeBlue,
          ),
          SizedBox(
            width: SchoolSizes.md,
          ),
          Text(
            text,
            style: Theme.of(Get.context!).textTheme.titleLarge?.copyWith(),
          ),
        ],
      ),
    );
  }
}
