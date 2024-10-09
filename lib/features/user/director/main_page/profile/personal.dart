import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../utils/constants/dynamic_colors.dart';

class Personal extends StatelessWidget {
  const Personal({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              buildSection(context, 'Parents', [
                buildTextColumn(context, 'Father', 'Anand Kumar'),
                buildTextColumn(context, 'Mother', 'Lalita Devi'),
              ]),
              buildSection(context, 'Contacts', [
                buildTextColumn(context, 'Mobile No', '9431098856'),
                buildTextColumn(
                    context, 'Email', 'aryankumarimpossible@gmail.com'),
              ]),
              buildSection(context, 'Address', [
                buildTextColumn(context, 'Address', 'Chowk Road Dumraon'),
                buildTextColumn(context, 'City', 'Dumraon'),
                buildTextColumn(context, 'District', 'Buxar'),
                buildTextColumn(context, 'State', 'Bihar'),
              ]),
              buildSection(context, 'Medical', [
                buildTextColumn(context, 'Date of Birth', '4th July 2003'),
                buildTextColumn(context, 'Gender', 'Male'),
                buildTextColumn(context, 'Blood Group', 'B+'),
                buildTextColumn(context, 'Height', '5 ft 6 inch'),
                buildTextColumn(context, 'Weight', '60KG'),
              ]),
              buildSection(context, 'Identity', [
                buildTextColumn(context, 'Religion', 'Hindu'),
                buildTextColumn(context, 'Category', 'OBC'),
                buildTextColumn(context, 'Aadhaar No.', '#1234 5678 9123'),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSection(
      BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildDivider(context, title),
        ...children,
      ],
    );
  }

  Widget buildDivider(BuildContext context, String label) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Expanded(
            child: Container(
              height: 1,
              color: SchoolDynamicColors.borderColor,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextColumn(BuildContext context, String text1, String text2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SchoolSizes.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              text1,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
            ),
          ),
          Flexible(
            child: Text(
              text2,
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
