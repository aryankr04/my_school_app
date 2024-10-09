import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../controllers/management/add_student_routine_controller.dart';
import '../../models/class_routine.dart';
import '../../widgets/day_card_button.dart';
import '../../widgets/timeline_item.dart';

class AddStudentRoutine extends StatefulWidget {
  final String sectionId;
  final String name;
  final String className;
  const AddStudentRoutine({
    Key? key,
    required this.sectionId,
    required this.name,
    required this.className,
  }) : super(key: key);

  @override
  State<AddStudentRoutine> createState() => _AddStudentRoutineState();
}

class _AddStudentRoutineState extends State<AddStudentRoutine> {
  late String sectionId;
  late String name;
  late String className;

  final AddStudentRoutineController controller =
      Get.put(AddStudentRoutineController());

  @override
  void initState() {
    super.initState();

    // Access parameters from widget property
    sectionId = widget.sectionId;
    name = widget.name;
    className = widget.className;

    controller.fetchAndAssignRoutine(sectionId, controller.selectedDay.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Update Routine'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(SchoolSizes.lg),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Select Day",
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontSize: 18)),
                  ),
                  SizedBox(
                    height: SchoolSizes.md,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                        () => Wrap(
                          runSpacing: 8.0,
                          spacing: 12.0,
                          children:
                              controller.dayList.asMap().entries.map((entry) {
                            String day = entry.value;

                            return DayCardButton(
                              text: day,
                              isSelected: day == controller.selectedDay.value,
                              onPressed: () {
                                controller.selectedDay.value = day;
                                controller.fetchAndAssignRoutine(
                                    sectionId, day);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Obx(
              () => Container(
                margin: EdgeInsets.all(SchoolSizes.lg),
                padding: EdgeInsets.all(SchoolSizes.md),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
                  border:
                      Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${controller.selectedDay}'s Routine",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: SchoolDynamicColors.primaryColor,
                                    ),
                              ),
                              Text(
                                "Class:  $className $name",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                          GestureDetector(
                            onTap: () async {
                              controller.fetchTeacherList();
                              controller.showAddDialog(
                                  sectionId: sectionId,
                                  className: className,
                                  sectionName: name);
                            },
                            child: Container(
                              constraints: BoxConstraints(minWidth: 100),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                  vertical: SchoolSizes.sm + 4,
                                  horizontal: SchoolSizes.md),
                              decoration: BoxDecoration(
                                color: SchoolHelperFunctions.isDarkMode(
                                        Get.context!)
                                    ? SchoolDynamicColors.activeBlue.withOpacity(0.8)
                                    : SchoolDynamicColors.activeBlue,
                                borderRadius: BorderRadius.circular(
                                    SchoolSizes.cardRadiusSm),
                              ),
                              child: Text(
                                "Add",
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: SchoolSizes.spaceBtwSections,
                    ),
                    Container(
                      child: Obx(() {
                        if (controller.isLoading.value) {
                          return _buildShimmerClassRoutine(); // Show shimmer when loading
                        } else {
                          return Wrap(
                            children: controller.classRoutineList.map((classRoutine) {
                              // Check if there is a previous routine and its endsAt matches the current startsAt
                              bool isMatch = checkMatch(controller.classRoutineList, classRoutine);
                                  print(isMatch);
                              // Update the previousEndsAt for the next iteration
                              //previousEndsAt = classRoutine.endsAt;

                              return TimelineItem(
                                isMatch: isMatch,
                                isStudent: true,
                                isWrite: true,
                                id: classRoutine.id,
                                startsAt: classRoutine.startsAt,
                                subject: classRoutine.subject,
                                classTeacherName: classRoutine.classTeacherName,
                                itemType: getItemType(classRoutine.eventType),
                                onDeletePressed: () {
                                  controller.deleteRoutine(classRoutine.id, sectionId);
                                },
                                onEditPressed: () {
                                  controller.showAddDialog(
                                    sectionId: sectionId,
                                    eventType: classRoutine.eventType,
                                    time: classRoutine.startsAt,
                                    subject: classRoutine.subject,
                                    teacherUid: classRoutine.classTeacherId,
                                    classTeacherName: classRoutine.classTeacherName,
                                    routineId: classRoutine.id,
                                    className: className,
                                    sectionName: name,
                                    endTime: classRoutine.endsAt,
                                  );
                                },
                                endsAt: classRoutine.endsAt,
                              );
                            }).toList(),
                          );



                        }
                      }),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildShimmerClassRoutine() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[100]!,
      highlightColor: Colors.grey[100]!,
      child: SingleChildScrollView(
        child: Column(
          children: List.generate(
            5, // Number of shimmering items
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: SchoolSizes.md, horizontal: SchoolSizes.md),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
                  color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                ),
                height: 80,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
bool checkMatch(List<ClassRoutine> routines, ClassRoutine currentRoutine) {
  if (routines.isEmpty || routines.length == 1) {
    return false; // If no routines or only one routine, return false
  }

  // Get the index of currentRoutine in the list
  int currentIndex = routines.indexOf(currentRoutine);

  if (currentIndex == -1) {
    return false;
  }

  if (currentIndex == 0) {
    // If currentRoutine is the first routine, check if its end time matches the start time of the next routine
    return currentRoutine.endsAt == routines[currentIndex + 1].startsAt;
  }

  if (currentIndex == routines.length - 1) {
    // If currentRoutine is the last routine, return false as there's no next routine to match its end time
    return false;
  }

  // Check if currentRoutine's end time matches the start time of the next routine
  return currentRoutine.endsAt == routines[currentIndex + 1].startsAt;
}
