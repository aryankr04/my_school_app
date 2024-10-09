import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/profile/personal.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TAcademics extends StatelessWidget {
  const TAcademics({super.key});

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

}
