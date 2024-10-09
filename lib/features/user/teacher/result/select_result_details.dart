import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/option_list.dart';
import 'package:my_school_app/utils/constants/lists.dart';

import '../../../../utils/constants/sizes.dart';
import '../../student/syllabus_and_routine/syllabus.dart';

class SelectResultDetails extends StatelessWidget {
   SelectResultDetails({super.key});

  List<String> classList=[];
  RxString selectedClass=''.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Result'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              dialogSelector(selectedClass, classList, 'Class',
                      (selectedItem) {})
            ],
          ),
        ),
      ),
    );
  }
}
