import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/features/user/student/syllabus_and_routine/syllabus.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../data/services/firebase_for_teachers.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../models/class_routine.dart';
import '../../widgets/timeline_item.dart';
import '../management/add_student_routine.dart';

class TeacherClassRoutine extends StatefulWidget {
  const TeacherClassRoutine({Key? key});

  @override
  State<TeacherClassRoutine> createState() => _TeacherClassRoutineState();
}

class _TeacherClassRoutineState extends State<TeacherClassRoutine> {
  List<String> dayList = SchoolLists.dayList;
  List<String> sectionList = SchoolLists.sectionList;

  RxString selectedTeacherName = ''.obs;
  RxString selectedTeacherId = ''.obs;
  RxString selectedDay = DateFormat('EEE').format(DateTime.now()).obs;

  RxList<ClassRoutine> classRoutineList = <ClassRoutine>[].obs;

  FirebaseForTeacher firebaseForTeachers = FirebaseForTeacher();
  List<Map<String, dynamic>> teacherList = <Map<String, dynamic>>[].obs;


  RxBool isLoading = false.obs;
  @override
  void initState() {
    super.initState();
    fetchTeacherList();
  }

  void fetchTeacherList() async {
    try {
      teacherList = await firebaseForTeachers.fetchTeachers('SCH0000000001');
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  void fetchAndAssignRoutine(String teacherId, String day) {
    isLoading(true);
    fetchRoutineBySectionIdAndDay(teacherId, day).then((routines) {
      classRoutineList.assignAll(routines);
      classRoutineList.sort((a, b) => a.startsAt.compareTo(b.startsAt));
      print(classRoutineList.length);
      isLoading(false);
    }).catchError((error) {
      print('Error fetching and assigning routines: $error');
    });
  }


  Future<List<ClassRoutine>> fetchRoutineBySectionIdAndDay(
      String classTeacherId, String day) async {
    try {
      CollectionReference routineCollection =
      FirebaseFirestore.instance.collection('routine');

      QuerySnapshot querySnapshot = await routineCollection
          .where('classTeacherId', isEqualTo: classTeacherId)
          .where('day', isEqualTo: day)
          .get();

      List<ClassRoutine> routines = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Extract routine data
        ClassRoutine routine = ClassRoutine.fromSnapshot(doc);

        // Add routine to the list
        routines.add(routine);
      }

      return routines;
    } catch (e) {
      print('Error fetching routines: $e');
      return [];
    }
  }


  void fetchRoutineAndAssign() async {
    fetchAndAssignRoutine(selectedTeacherId.value, selectedDay.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Class Routine'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: SchoolSizes.lg,
                  right: SchoolSizes.lg,
                  top: SchoolSizes.lg,
                  bottom: SchoolSizes.sm),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text("Select Day",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 18)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: Row(
                    children: [
                      // dialogSelector(selectedTeacher, teacherList, 'Teacher',
                      //     (val) {
                      //   if (selectedTeacher.value != '' &&
                      //       selectedDay.value != '') {
                      //     fetchRoutineAndAssign();
                      //   }
                      // }),
                      Obx(() => InkWell(
                        onTap: () async {
                          fetchTeacherList();
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Teachers'),
                                content: Container(
                                  width: double.maxFinite,
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: teacherList.length,
                                    itemBuilder: (BuildContext context, int index) {
                                      return ListTile(
                                        title: Text(teacherList[index]['teacherName'] ?? ''),
                                        subtitle: Text(teacherList[index]['uid'] ?? ''),
                                        onTap: () {
                                          // Do something when a teacher is tapped
                                          selectedTeacherName.value=teacherList[index]['teacherName']??'';
                                          selectedTeacherId.value=teacherList[index]['uid']??'';
                                          fetchRoutineAndAssign();
                                          Navigator.of(context).pop(); // Close the dialog
                                        },
                                      );
                                    },
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: selectedTeacherName.value == ''
                                ? SchoolDynamicColors.backgroundColorWhiteDarkGrey
                                : SchoolDynamicColors.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(48),
                            border: Border.all(
                              color: selectedTeacherName.value == ''
                                  ? SchoolHelperFunctions.isDarkMode(Get.context!)
                                  ? SchoolDynamicColors.borderColor
                                  : SchoolDynamicColors.subtitleTextColor
                                  : SchoolDynamicColors.primaryColor,
                              width: selectedTeacherName.value == '' ? 0.5 : 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                            child: Row(
                              children: [
                                Text(
                                  'Teacher:  ${selectedTeacherName.value}',
                                  style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                                      color: selectedTeacherName.value == ''
                                          ? SchoolDynamicColors.subtitleTextColor
                                          : SchoolDynamicColors.primaryColor,
                                      fontSize: 13),
                                ),
                                SizedBox(
                                  width: SchoolSizes.xs,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: selectedTeacherName.value == ''
                                      ? SchoolDynamicColors.iconColor
                                      : SchoolDynamicColors.primaryColor,
                                  size: 30,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
                      SizedBox(
                        width: SchoolSizes.md,
                      ),
                      dialogSelector(selectedDay, SchoolLists.dayList, 'Day',
                          (val) {
                        if (selectedTeacherName.value != '' &&
                            selectedDay.value != '') {
                          fetchRoutineAndAssign();
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: SchoolSizes.md),
            Obx(() => Container(
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
                    borderRadius:
                        BorderRadius.circular(SchoolSizes.cardRadiusSm),
                    border:
                        Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "$selectedDay's Routine",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: SchoolDynamicColors.primaryColor),
                            ),
                            Text(
                              "Teacher: $selectedTeacherName",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SchoolSizes.spaceBtwSections,
                      ),
                      Container(
                        child: Obx(() {
                          if (isLoading.value) {
                            return _buildShimmerClassRoutine(); // Show shimmer when loading
                          } else {
                            return Wrap(
                              children: classRoutineList.map((classRoutine) {
                                bool isMatch = checkMatch(classRoutineList, classRoutine);

                                return TimelineItem(
                                  isStudent: false,
                                  isWrite: false,
                                  id: classRoutine.id,
                                  startsAt: classRoutine.startsAt,
                                  subject: classRoutine.subject,
                                  classTeacherName:
                                      classRoutine.classTeacherName,
                                  itemType: getItemType(classRoutine.eventType),
                                  className: classRoutine.className,
                                  sectionName: classRoutine.sectionName,
                                  endsAt: classRoutine.endsAt, isMatch: isMatch,
                                );
                              }).toList(),
                            );
                          }
                        }),
                      ),
                    ],
                  ),
                ))
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
