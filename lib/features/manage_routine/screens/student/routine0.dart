import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/common/widgets/confirmationDialog.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/common/widgets/time_picker.dart';
import 'package:my_school_app/features/manage_routine/screens/student/timetable.dart';
import 'package:my_school_app/features/user/student/syllabus_and_routine/syllabus.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/date_and_time.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import '../../../user/student/attendence/screens/my_attendance.dart';
import '../../models/class_routine0.dart';

class Routine0 extends StatefulWidget {
  const Routine0({Key? key});

  @override
  State<Routine0> createState() => _Routine0State();
}

class _Routine0State extends State<Routine0> {
  List<String> dayList = SchoolLists.dayList;
  List<String> classList = SchoolLists.classList;
  List<String> sectionList = SchoolLists.sectionList;

  RxString selectedClass = ''.obs;
  RxString selectedSection = ''.obs;
  RxString selectedDay = RxString(DateFormat('EEEE').format(DateTime.now()));
  RxBool isLoading = false.obs;
  final Rx<Routine?> routine = Rx<Routine?>(null);
  void deleteEvent(int index) {
    if (routine.value != null) {
      CustomConfirmationDialog.show(DialogAction.Delete, onConfirm: () {
        List<DayEvent> events =
            List.from(routine.value!.days[selectedDay.value] ?? []);

        if (events.isNotEmpty && index >= 0 && index < events.length) {
          // Remove the event at the specified index
          events.removeAt(index);

          // Update the routine's day events with the modified list
          routine.value!.days[selectedDay.value] = events;

          // Trigger a UI update by using RxState (since routine is an Rx)
          routine.refresh();
          print('Delete successful');
          print('Selected day: ${selectedDay.value}');
          print('Events list: ${routine.value!.days[selectedDay.value]}');
        } else {
          print('Invalid index or empty list');
        }
      });
    }
  }

  void editEvent(int index, DayEvent updatedEvent) {
    if (routine.value != null) {
      List<DayEvent> events =
          List.from(routine.value!.days[selectedDay.value] ?? []);

      if (events.isNotEmpty && index >= 0 && index < events.length) {
        // Replace the event at the specified index with the updated event
        events[index] = updatedEvent;

        // Update the routine's day events with the modified list
        routine.value!.days[selectedDay.value] = events;

        // Trigger a UI update by using RxState (since routine is an Rx)
        routine.refresh();
      } else {
        print('Invalid index or empty list');
      }
    }
  }

  Future<void> fetchRoutineBySchoolClass(
      String schoolId, String className, String section) async {
    try {
      isLoading.value = true;

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('schoolClasses')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .where('section', isEqualTo: section)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot schoolClassDoc = querySnapshot.docs.first;

        if (schoolClassDoc['routine'] != null) {
          routine.value =
              Routine.fromMap(schoolClassDoc['routine'], schoolClassDoc.id);
          print("Routine found");
        } else {
          print("Routine field not found in the document.");
        }
      } else {
        print("No matching school class found.");
      }
    } catch (e) {
      print("Error fetching routine: $e");
    } finally {
      isLoading.value = false;
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dialogSelector(selectedClass, classList, 'Class',
                        (val) async {
                      if (selectedClass.value.isNotEmpty &&
                          selectedSection.value.isNotEmpty) {
                        await fetchRoutineBySchoolClass('SCH0000000001',
                            selectedClass.value, selectedSection.value);
                      }
                    }),
                    SizedBox(width: SchoolSizes.md),
                    dialogSelector(selectedSection, sectionList, 'Sec',
                        (val) async {
                      if (selectedClass.value.isNotEmpty &&
                          selectedSection.value.isNotEmpty) {
                        await fetchRoutineBySchoolClass('SCH0000000001',
                            selectedClass.value, selectedSection.value);
                      }
                    }),
                    SizedBox(width: SchoolSizes.md),
                    dialogSelector(selectedDay, SchoolLists.dayList, 'Day',
                        (val) async {
                      if (selectedClass.value.isNotEmpty &&
                          selectedSection.value.isNotEmpty) {
                        // await fetchRoutineBySchoolClass('SCH0000000001',
                        //     selectedClass.value, selectedSection.value);
                      }
                    }),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(SchoolSizes.lg),
              child: Obx(
                () => TimelineItem(
                  isWrite: false,
                  isMatch: true,
                  events: routine.value?.days[selectedDay.value] ?? [],
                  dayName: selectedDay.value,
                  isStudent: true,
                  onDelete: (int index) {
                    // Call delete function to update routine in Routine0
                    deleteEvent(index);
                  },
                  onEdit: (int index, DayEvent updatedEvent) {
                    // Call edit function to update routine in Routine0
                    // editEvent(index, updatedEvent);
                    showTwoTextFieldDialog();
                  },
                ),
              ),
            ),


          ],
        ),
      ),
    );
  }

  List<String> eventType = ['Class', 'Start', 'Assembly', 'Break', 'Departure'];
  Future<void> showTwoTextFieldDialog() async {
    final TextEditingController firstController = TextEditingController();
    final TextEditingController secondController = TextEditingController();

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: Text('Edit Routine'),
          content: Container(
            color: Colors.white,
            width: Get.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,

              children: [
                SchoolDropdownFormField(
                  items: eventType,
                  labelText: 'Event Type',
                ),
                SchoolTextFormField(
                  labelText: 'Class Teacher',
                ),
                TimePickerField(
                    initialTime: null,
                    onTimeChanged: (t) {},
                    labelText: 'Starts At'),
                TimePickerField(
                    initialTime: null,
                    onTimeChanged: (t) {},
                    labelText: 'Ends At'),
                const SizedBox(height: 16),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancel"),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     onSubmit(firstController.text, secondController.text);
            //     Navigator.of(context).pop();
            //   },
            //   child: const Text("Submit"),
            // ),
          ],
        );
      },
    );
  }
}
