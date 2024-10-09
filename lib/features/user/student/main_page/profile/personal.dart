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
          padding: const EdgeInsets.symmetric(horizontal: SchoolSizes.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              buildTextColumn(context, 'Father', 'Anand Kumar'),
              buildTextColumn(context, 'Mother', 'Lalita Devi'),

              buildTextColumn(context, 'Mobile No', '9431098856'),
              buildTextColumn(
                  context, 'Email', 'aryankumarimpossible@gmail.com'),

              buildTextColumn(context, 'Address', 'Chowk Road Dumraon'),
              buildTextColumn(context, 'City', 'Dumraon'),
              buildTextColumn(context, 'District', 'Buxar'),
              buildTextColumn(context, 'State', 'Bihar'),

              buildTextColumn(context, 'Date of Birth', '4th July 2003'),
              buildTextColumn(context, 'Gender', 'Male'),
              buildTextColumn(context, 'Blood Group', 'B+'),
              buildTextColumn(context, 'Height', '5 ft 6 inch'),
              buildTextColumn(context, 'Weight', '60KG'),

              buildTextColumn(context, 'Religion', 'Hindu'),
              buildTextColumn(context, 'Category', 'OBC'),
              buildTextColumn(context, 'Aadhaar No.', '#1234 5678 9123'),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTextColumn(BuildContext context, String text1, String text2) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: SchoolSizes.sm),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(SchoolSizes.cardRadiusXs),
            color: SchoolDynamicColors.backgroundColorTintLightGrey,
          ),
          child: Icon(Icons.person,
              size: 20, color: SchoolDynamicColors.primaryIconColor),
        ),
        SizedBox(width: SchoolSizes.md,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text1,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: SchoolDynamicColors.placeholderColor,fontSize: 13),
            ),
            Text(
              text2,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // Divider(
            //   color: SchoolColors.grey,
            //   thickness: 0.5,
            // )
          ],
        ),
      ],
    ),
  );
}
