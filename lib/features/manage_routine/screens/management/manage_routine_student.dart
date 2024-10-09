import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../controllers/management/manage_routine_student_controller.dart';

class ManageRoutineStudent extends StatefulWidget {
  @override
  State<ManageRoutineStudent> createState() => _ManageRoutineStudentState();
}

class _ManageRoutineStudentState extends State<ManageRoutineStudent> {
  final ManageRoutineStudentController controller=Get.put(ManageRoutineStudentController());

  @override
  void initState() {
    super.initState();
    controller.fetchSectionsInfo('SCH0000000001');
  }

  Future<void> _refreshData() async {
    controller.fetchSectionsInfo('SCH0000000001');
  }

  Widget _buildShimmerSectionList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Shimmer.fromColors(
        baseColor: SchoolDynamicColors.backgroundColorGreyLightGrey!,
        highlightColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey!,
        child: Column(
          children: List.generate(
            4, // Number of shimmering items
                (index) {
              return Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Padding(
        padding: const EdgeInsets.all(SchoolSizes.lg),
        child: Column(
          children: [
            Obx(
                  () => controller.isLoadingRoutine.value
                  ? _buildShimmerSectionList()
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.sectionsData.length,
                itemBuilder: (context, index) {
                  final section =
                  controller.sectionsData[index];
                  final sectionId = section.sectionId;
                  final className = section.className;
                  final sec = section.sectionName;
                  final teacherName = section.classTeacherName;

                  final isDifferentClass = index == 0 ||
                      section.className !=
                          controller.sectionsData[index - 1]
                              .className;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (isDifferentClass)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8.0),
                          child: Text(
                            'Class - $className',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: SchoolDynamicColors.subtitleTextColor
                            ),
                          ),
                        ),
                      StudentRoutine(
                        sectionId,
                        className,
                        sec,
                        teacherName,

                      ),
                      const SizedBox(
                        height: SchoolSizes.lg,
                      )
                    ],
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}
class StudentRoutine extends StatelessWidget {
  final String sectionId;
  final String className;
  final String sec;
  final String teacherName;


  StudentRoutine(
      this.sectionId,
      this.className,
      this.sec,
      this.teacherName,
      );
  final ManageRoutineStudentController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: SchoolSizes.sm, horizontal: SchoolSizes.sm),
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
        border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: SchoolDynamicColors.backgroundColorTintLightGrey,
              //border: Border.all(width: 0.5, color: SchoolColors.borderColor),
              borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
            ),
            child: Center(
              child: Text(
                sec,
                style: Theme.of(Get.context!)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: SchoolDynamicColors.primaryTextColor),
              ),
            ),
          ),
          const SizedBox(
            width: SchoolSizes.md,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$className $sec',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                ),
                     Text(
                  teacherName,
                  style: Theme.of(Get.context!)
                      .textTheme
                      .labelMedium
                      ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                )



              ],
            ),
          ),
          InkWell(
            onTap: () => controller.onSubmitPressed(sectionId, sec, className),
            child: Container(
              alignment: Alignment.center,
              constraints: const BoxConstraints(minWidth: 110),
              padding: const EdgeInsets.symmetric(
                  horizontal: 20, vertical: SchoolSizes.sm),
              decoration: BoxDecoration(
                color
                    : SchoolDynamicColors.activeGreen,
                borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
              ),
              child: const Text(
               'Update',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
