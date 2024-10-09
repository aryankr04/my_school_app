import 'package:flutter/material.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';

class Academics extends StatelessWidget {
  const Academics({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
          child: Column(
            children: [
              SizedBox(height: 16,),
              buildTextColumn(context, 'All India Rank (AIR)', '#1'),
              buildTextColumn(context, 'School Rank', '#1'),
              buildTextColumn(context, 'Attendence%', '74.3%'),
              buildTextColumn(context, 'Class Teacher', 'N.K Pandey Sir'),
              buildTextColumn(context, 'Student House', 'Tagore House'),



            ],
          ),
        ),
      ),
    );
  }
  buildTextColumn(BuildContext context, String text1, String text2) {
    return Padding(
      padding:
      const EdgeInsets.only(top: SchoolSizes.md, bottom: SchoolSizes.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Text(text1,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: SchoolDynamicColors.subtitleTextColor)),
          ),
          Flexible(
            child: Text(text2,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
