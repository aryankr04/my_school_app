import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/features/user/student/syllabus_and_routine/syllabus.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../utils/constants/dynamic_colors.dart';
import '../../models/class_routine.dart';
import '../../widgets/timeline_item.dart';
import '../management/add_student_routine.dart';

class Routine extends StatefulWidget {
  const Routine({Key? key});

  @override
  State<Routine> createState() => _RoutineState();
}

class _RoutineState extends State<Routine> {
  List<String> dayList = SchoolLists.dayList;
  List<String> classList = SchoolLists.classList;
  List<String> sectionList = SchoolLists.sectionList;

  RxString selectedClass = ''.obs;
  RxString selectedSection = ''.obs;
  RxString selectedDay = DateFormat('EEE').format(DateTime.now()).obs;

  RxList<ClassRoutine> classRoutineList = <ClassRoutine>[].obs;

  RxBool isLoading = false.obs;
  @override
  void initState() {
    super.initState();
  }

  void fetchAndAssignRoutine(String sectionId, String day) {
    isLoading(true);
    fetchRoutineBySectionIdAndDay(sectionId, day).then((routines) {
      classRoutineList.assignAll(routines);
      classRoutineList.sort((a, b) {
        // First compare based on time
        int timeComparison = a.startsAt.compareTo(b.startsAt);
        if (timeComparison != 0) {
          return timeComparison; // If times are different, return the comparison result
        } else {
          // If times are equal, compare based on eventType
          if (a.eventType == 'Start' &&
              (b.eventType == 'Class' || b.eventType == 'Departure')) {
            return -1; // 'Start' comes before 'Class' and 'Departure'
          } else if (b.eventType == 'Start' &&
              (a.eventType == 'Class' || a.eventType == 'Departure')) {
            return 1; // 'Class' and 'Departure' come after 'Start'
          } else {
            // If both have the same eventType or neither is 'Start', return 0
            return 0;
          }
        }
      });
      print(classRoutineList.length);
      isLoading(false);
    }).catchError((error) {
      print('Error fetching and assigning routines: $error');
    });
  }

  Future<List<ClassRoutine>> fetchRoutineBySectionIdAndDay(
      String sectionId, String day) async {
    try {
      CollectionReference routineCollection =
          FirebaseFirestore.instance.collection('routine');

      QuerySnapshot querySnapshot = await routineCollection
          .where('sectionId', isEqualTo: sectionId)
          .where('day', isEqualTo: day)
          .get();

      List<ClassRoutine> routines = querySnapshot.docs
          .map((doc) => ClassRoutine.fromSnapshot(doc))
          .toList();

      return routines;
    } catch (e) {
      print('Error fetching routines: $e');
      return [];
    }
  }

  void fetchRoutineAndAssign() async {
    String? sectionId = await findSectionId(
        'SCH0000000001', selectedClass.value, selectedSection.value);
    if (sectionId != null) {
      fetchAndAssignRoutine(sectionId, selectedDay.value);
    } else {
      // Handle the case where sectionId is not found
      print('Section ID not found.');
    }
  }

  Future<String?> findSectionId(
      String schoolId, String className, String sectionName) async {
    try {
      // Access the Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query the Firestore collection based on schoolId, className, and sectionName
      QuerySnapshot querySnapshot = await firestore
          .collection('sections')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .where('sectionName', isEqualTo: sectionName)
          .get();

      // If the section is found, return its sectionId
      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.id;
      } else {
        // If the section is not found, return null
        return null;
      }
    } catch (e) {
      // Handle any errors that occur during the process
      print('Error finding sectionId: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Routine'),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(
                  children: [
                    dialogSelector(selectedClass, classList, 'Class', (val) {
                      if (selectedClass.value != '' &&
                          selectedSection.value != '' &&
                          selectedDay.value != '') {
                        fetchRoutineAndAssign();
                      }
                    }),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    dialogSelector(selectedSection, sectionList, 'Sec', (val) {
                      if (selectedClass.value != '' &&
                          selectedSection.value != '' &&
                          selectedDay.value != '') {
                        fetchRoutineAndAssign();
                      }
                    }),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    dialogSelector(selectedDay, SchoolLists.dayList, 'Day',
                        (val) {
                      if (selectedClass.value != '' &&
                          selectedSection.value != '' &&
                          selectedDay.value != '') {
                        fetchRoutineAndAssign();
                      }
                    }),
                  ],
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
                              "Class $selectedClass $selectedSection",
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
                                  isStudent: true,
                                  isWrite: false,
                                  id: classRoutine.id,
                                  startsAt: classRoutine.startsAt,
                                  subject: classRoutine.subject,
                                  classTeacherName:
                                      classRoutine.classTeacherName,
                                  itemType: getItemType(classRoutine.eventType),
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
