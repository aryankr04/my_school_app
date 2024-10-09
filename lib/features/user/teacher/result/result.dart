import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/student/syllabus_and_routine/syllabus.dart';
import 'package:my_school_app/features/user/teacher/result/my_result.dart';
import 'package:my_school_app/features/user/teacher/result/select_result_details.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ManageResult extends StatefulWidget {
  const ManageResult({super.key});

  @override
  State<ManageResult> createState() => _ManageResultState();
}

class _ManageResultState extends State<ManageResult> {
  RxString selectedClass = ''.obs;

  RxString selectedSection = ''.obs;

  RxString selectedRollNo = ''.obs;
  RxString selectedExam = ''.obs;

  List<String> classList = SchoolLists.classList;
  List<String> sectionList = SchoolLists.sectionList;
  List<String> rollNoList = ['1', '2', '3', '4', '5'];
  List<String> examList = SchoolLists.examList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Result'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  SchoolHelperFunctions.navigateToScreen(
                      context, SelectResultDetails());
                },
                child: Container(
                    padding: const EdgeInsets.all(SchoolSizes.md),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                      border: Border.all(
                          width: 0.5, color: SchoolDynamicColors.borderColor),
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(SchoolSizes.sm),
                          decoration: BoxDecoration(
                            color: SchoolDynamicColors.primaryTintColor,
                            border: Border.all(
                                width: 0.5, color: SchoolDynamicColors.borderColor),
                            borderRadius:
                                BorderRadius.circular(SchoolSizes.cardRadiusSm),
                          ),
                          child: Icon(
                            Icons.add,
                            color: SchoolDynamicColors.primaryColor,
                            size: 36,
                          ),
                        ),
                        SizedBox(
                          width: SchoolSizes.md,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Create New Results",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                              ),
                              Text(
                                  "Search Homeworks according to the class and date",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.labelSmall)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SchoolSizes.md,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: SchoolDynamicColors.primaryColor,
                        )
                      ],
                    )),
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Options",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18)),
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              Row(
                children: [
                  Flexible(
                      child: dialogSelector(selectedClass, classList, 'Class',
                          (selectedItem) {})),
                  SizedBox(
                    width: SchoolSizes.lg,
                  ),
                  Flexible(
                      child: dialogSelector(selectedSection, sectionList, 'Sec',
                          (selectedItem) {})),
                ],
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              Row(
                children: [
                  Flexible(
                      child: dialogSelector(selectedRollNo, rollNoList,
                          'Roll no', (selectedItem) {})),
                  SizedBox(
                    width: SchoolSizes.lg,
                  ),
                  Flexible(
                      child: dialogSelector(
                          selectedExam, examList, 'Exam', (selectedItem) {})),
                ],
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
