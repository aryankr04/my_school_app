import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/profile/personal.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';

class TOthers extends StatelessWidget {
  const TOthers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
          child: Column(
            children: [
              SizedBox(height: 16,),
              buildTextColumn(context, 'Transportation', 'By Bus'),
              buildTextColumn(context, 'Vehicle No.', 'Bus No.2'),
              buildTextColumn(context, 'Vehicle Route', 'Dumraon-Chaungai'),
              buildTextColumn(context, 'Driver Name', 'Vikash Yadav'),
              buildTextColumn(context, 'Driver Contact', '8757012040'),


            ],
          ),
        ),
      ),
    );
  }
}
