import 'package:flutter/material.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../student/main_page/profile/personal.dart';

class TPersonal extends StatelessWidget {
  const TPersonal({Key? key});

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

