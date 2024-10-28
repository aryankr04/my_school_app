import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../../../data/services/firebase_for_teachers.dart';
import '../../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../../utils/constants/lists.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../../common/widgets/time_picker.dart';
import '../../models/class_routine.dart';

class AddStudentRoutineController extends GetxController {
  List<String> dayList = SchoolLists.dayList;

  RxString selectedDay = DateFormat('EEE').format(DateTime.now()).obs;
  RxString selectedEventType = ''.obs;
  String selectedStartTime = '';
  String selectedEndTime = '';
  TextEditingController subjectController = TextEditingController();
  TextEditingController teacherName = TextEditingController();
  TextEditingController teacherId = TextEditingController();
  TextEditingController sectionName = TextEditingController();
  List<Map<String, dynamic>> teacherList = <Map<String, dynamic>>[].obs;
  RxList<ClassRoutine> classRoutineList = <ClassRoutine>[].obs;
  RxBool isLoading = false.obs;
  FirebaseForTeacher firebaseForTeachers = FirebaseForTeacher();

  @override
  void onInit() {
    super.onInit();
  }

  void fetchTeacherList() async {
    try {
      teacherList = await firebaseForTeachers.fetchTeachers('SCH0000000001');
    } catch (e) {
      print('Error fetching data: $e');
    }
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

      // classRoutineList.sort((a, b) => a.time.compareTo(b.time));

      print(classRoutineList.length);
      update();
      isLoading(false);
    }).catchError((error) {
      print('Error fetching and assigning routines: $error');
    });
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> deleteRoutine(String id, String sectionId) async {
    try {
      SchoolHelperFunctions.showLoadingOverlay();
      await _firestore.collection('routine').doc(id).delete();
      Get.back();
      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar('Routine deleted successfully');
      fetchAndAssignRoutine(sectionId, selectedDay.value);
      print('Routine deleted successfully');
    } catch (e) {
      print('Error deleting routine: $e');
    }
  }

  Future<void> uploadTimelineItem(
      String sectionId, String className, String sectionName) async {
    try {
      SchoolHelperFunctions.showLoadingOverlay();
      CollectionReference routine =
          FirebaseFirestore.instance.collection('routine');

      ClassRoutine classRoutine = ClassRoutine(
          id: routine.doc().id,
          startsAt: selectedStartTime,
          subject: subjectController.text,
          sectionId: sectionId,
          classTeacherId: teacherId.text,
          classTeacherName: teacherName.text,
          eventType: selectedEventType.value,
          day: selectedDay.value,
          className: className,
          sectionName: sectionName, endsAt: selectedEndTime, );

      Map<String, dynamic> classRoutineData = classRoutine.toMap();

      await routine.add(classRoutineData);

      print('Timeline item uploaded successfully!');
      SchoolHelperFunctions.showLoadingOverlay();
      Get.back();
      Get.back();
      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
          'Routine item uploaded successfully!');
      fetchAndAssignRoutine(sectionId, selectedDay.value);
    } catch (e) {
      print('Error uploading timeline item: $e');
      SchoolHelperFunctions.showLoadingOverlay();
      Get.back();
      Get.back();
      Get.back();
      SchoolHelperFunctions.showErrorSnackBar(
          'Error uploading timeline item: $e');
    }
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

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final time = DateTime(
        now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);
    final formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }

  Future<void> showAddDialog({
    required String sectionId,
    required String className,
    required String sectionName,
    String? eventType,
    String? time,
    String? endTime,
    String? subject,
    String? classTeacherName,
    String? teacherUid,
    String? routineId,
  }) async {
    selectedEventType.value = eventType ?? 'Start';
    selectedStartTime = time ?? formatTimeOfDay(TimeOfDay(hour: 1, minute: 23));
    selectedEndTime = endTime ?? formatTimeOfDay(TimeOfDay(hour: 1, minute: 23));
    subjectController.text = subject ?? '';
    teacherName.text = classTeacherName ?? '';
    teacherId.text = teacherUid ?? '';

    Get.defaultDialog(
      backgroundColor: Colors.white,
      titlePadding: const EdgeInsets.only(top: SchoolSizes.lg),
      title: sectionId.isNotEmpty
          ? eventType != null
              ? 'Update Routine'
              : 'Add Routine'
          : '',
      content: Container(
        padding: const EdgeInsets.all(SchoolSizes.md),
        constraints: BoxConstraints(minHeight: double.minPositive,maxHeight: Get.width),
        //height: Get.width,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => SchoolDropdownFormField(
                selectedValue: selectedEventType.value,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                  hintText: 'Select event type',
                  hintStyle: Theme.of(Get.context!)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                items: SchoolLists.eventType,
                labelText: 'Event Type',
                prefixIcon: Icons.class_,
                isValidate: true,
                onSelected: (val) {
                  selectedEventType.value = val;
                  subjectController.clear();
                  teacherName.clear();
                  teacherId.clear();
                },
              ),),
              SizedBox(
                height: SchoolSizes.md,
              ),
              TimePickerField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                  suffixIcon: Icon(Icons.access_time),
                  hintText: 'Starting Time',
                  hintStyle: Theme.of(Get.context!)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                initialTime: time,
                onTimeChanged: (time) {
                  selectedStartTime = formatTimeOfDay(time);
                },
                labelText: 'Starts At',
              ),
              TimePickerField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                  suffixIcon: Icon(Icons.access_time),
                  hintText: 'Starting Time',
                  hintStyle: Theme.of(Get.context!)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                initialTime: endTime,
                onTimeChanged: (endTime) {
                  selectedEndTime = formatTimeOfDay(endTime);
                },
                labelText: 'Ends At',
              ),
              Obx(
                () => selectedEventType.value == 'Class'
                    ? Column(
                        children: [
                          const SizedBox(
                            height: SchoolSizes.lg,
                          ),
                          SchoolTextFormField(
                            labelText: 'Subject',
                            controller: subjectController,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                              suffixIcon: Icon(Icons.class_),
                              hintText: 'Select a subject',
                              hintStyle: Theme.of(Get.context!)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ),
              Obx(() => selectedEventType.value == 'Class'
                  ? Column(
                      children: [
                        const SizedBox(
                          height: SchoolSizes.md,
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Teacher',
                            style: Theme.of(Get.context!)
                                .textTheme
                                .labelLarge
                                ?.copyWith(fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: SchoolSizes.sm,
                        ),
                        AutoCompleteTextField<Map<String, dynamic>>(
                          key: GlobalKey(),
                          controller: teacherName,
                          clearOnSubmit: false,
                          suggestions: teacherList,
                          itemFilter: (item, query) {
                            return item["teacherName"]
                                .toLowerCase()
                                .contains(query.toLowerCase() ?? '');
                          },
                          itemSorter: (a, b) {
                            return a["teacherName"].compareTo(b["teacherName"]);
                          },
                          itemSubmitted: (item) {
                            teacherName.text = item['teacherName'];
                            teacherId.text = item['uid'];
                          },
                          itemBuilder: (context, item) {
                            return Container(
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.all(SchoolSizes.sm),
                              color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                              child: Row(
                                children: [
                                  const SizedBox(
                                    width: SchoolSizes.md,
                                  ),
                                  Icon(
                                    Icons.school,
                                    color: SchoolDynamicColors.iconColor,
                                  ),
                                  const SizedBox(
                                    width: SchoolSizes.md + 8,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['teacherName'] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge,
                                      ),
                                      Text(
                                        item['uid'] ?? '',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                          decoration: InputDecoration(
                            hintStyle: Theme.of(Get.context!)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                            hintText: 'Class Teacher',
                            filled: true,
                            fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                            suffixIcon: IconButton(
                              color: SchoolDynamicColors.iconColor,
                              icon: const Icon(Icons.clear),
                              onPressed: () {
                                teacherName.clear();
                              },
                            ),
                          ),
                          textChanged: (query) {},
                        ),
                      ],
                    )
                  : SizedBox()),
              const SizedBox(height: SchoolSizes.defaultSpace),
              ElevatedButton(
                onPressed: () {
                  if (sectionId.isNotEmpty) {
                    if (eventType != null) {
                      // Update existing event
                      updateTimelineItem(sectionId, routineId ?? '');
                    } else {
                      // Add new event
                      uploadTimelineItem(sectionId, className, sectionName);
                    }
                  }
                },
                child: sectionId.isNotEmpty
                    ? eventType != null
                        ? Text('Update')
                        : Text('Add')
                    : SizedBox(), // If sectionId is empty, return an empty SizedBox
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> updateTimelineItem(String sectionId, String routineId) async {
    try {
      SchoolHelperFunctions
          .showLoadingOverlay(); // Update the document in Firestore with the new event details
      await FirebaseFirestore.instance
          .collection('routine')
          .doc(routineId)
          .update({
        'eventType': selectedEventType.value,
        'startsAt': selectedStartTime,
        'subject':
            selectedEventType.value == 'Class' ? subjectController.text : '',
        'classTeacherName':
            selectedEventType.value == 'Class' ? teacherName.text : '',
        'teacherUid':
            selectedEventType.value == 'Class' ? teacherId.text : '',
        'endsAt':selectedEndTime,
      });
      selectedEventType.value = '';
      selectedStartTime = '';
      subjectController.clear();
      teacherName.clear();
      teacherId.clear();
      Get.back();
      Get.back();
      fetchAndAssignRoutine(sectionId, selectedDay.value);
      SchoolHelperFunctions.showSuccessSnackBar('Event updated successfully');
      print('Event updated successfully');
      isLoading(false);
    } catch (e) {
      print('Error updating event: $e');
      SchoolHelperFunctions.showErrorSnackBar('Failed to update event');
    }
  }
}
