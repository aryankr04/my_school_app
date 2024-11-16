import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/features/manage_routine/screens/student/timetable.dart';
import 'package:my_school_app/features/user/student/syllabus_and_routine/syllabus.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../models/class_routine0.dart';

class MyRoutine extends StatefulWidget {
  const MyRoutine({Key? key});

  @override
  State<MyRoutine> createState() => _MyRoutineState();
}

class _MyRoutineState extends State<MyRoutine> {
  List<String> dayList = SchoolLists.dayList;
  List<String> classList = SchoolLists.classList;
  List<String> sectionList = SchoolLists.sectionList;

  RxString selectedClass = ''.obs;
  RxString selectedSection = ''.obs;
  RxString selectedDay = DateFormat('EEE').format(DateTime.now()).obs;


  RxBool isLoading = false.obs;


// Function to import DayEvents
  final Rx<Routine?> routine = Rx<Routine?>(null);
  final RxList<DayEvent> dayEvents = <DayEvent>[].obs;
// Convert list of DayEvent to a list of maps

// Step 2: Send the data to Firebase Firestore
  Future<void> sendRoutineToFirebase(String schoolId, String className, String section) async {
    try {
      // Create reference to Firestore collection
      final List<DayEvent> dayEvents = [
        DayEvent(
          period: 'Start',
          subject: null, // Not a class period, so subject is null
          teacher: 'Mr. Smith',
          startTime: '8:00 AM',
          endTime: '8:00 AM',
        ),
        DayEvent(
          period: 'Assembly',
          subject: null, // Not a class period, so subject is null
          teacher: null, // No teacher for assembly
          startTime: '8:00 AM',
          endTime: '8:30 AM',
        ),
        DayEvent(
          period: 'Class',
          subject: 'Data Structure',
          teacher: 'Amit Shukla',
          startTime: '8:30 AM',
          endTime: '9:30 AM',
        ),
        DayEvent(
          period: 'Class',
          subject: 'English Class',
          teacher: 'Ms. Johnson',
          startTime: '9:30 AM',
          endTime: '10:30 AM',
        ),
        DayEvent(
          period: 'Class',
          subject: 'Science Class',
          teacher: 'Dr. Williams',
          startTime: '10:30 AM',
          endTime: '11:30 AM',
        ),
        DayEvent(
          period: 'Break',
          subject: null, // Break, no subject
          teacher: null, // No teacher for break
          startTime: '11:30 AM',
          endTime: '12:00 PM',
        ),
        DayEvent(
          period: 'Class',
          subject: 'History Class',
          teacher: 'Mr. Brown',
          startTime: '12:00 PM',
          endTime: '1:00 PM',
        ),
        DayEvent(
          period: 'Class',
          subject: 'Physical Education',
          teacher: 'Coach Taylor',
          startTime: '1:00 PM',
          endTime: '2:00 PM',
        ),
        DayEvent(
          period: 'Departure',
          subject: null, // No subject for departure
          teacher: null, // No teacher for departure
          startTime: '2:00 PM',
          endTime: '', // No end time for departure
        ),
      ];

      List<Map<String, dynamic>> dayEventsMap = dayEvents.map((event) => event.toMap()).toList();

      CollectionReference schoolClasses = FirebaseFirestore.instance.collection('schoolClasses');

      // Add routine data (example: routine is a field within the document)
      await schoolClasses
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .where('section', isEqualTo: section)
          .limit(1)
          .get()
          .then((querySnapshot) async {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot schoolClassDoc = querySnapshot.docs.first;
          String documentId = schoolClassDoc.id;

          // Update the document with the routine field
          await schoolClasses.doc(documentId).update({
            'routine': {
              'days': {
                // Assuming this is the data for a specific day (for example, Monday)
                'Monday': dayEventsMap, // You can map this to any day (e.g., 'Monday', 'Tuesday', etc.)
              }
            }
          });

          print("Routine data sent to Firebase successfully.");
        } else {
          print("School class not found.");
        }
      });
    } catch (e) {
      print("Error sending routine to Firebase: $e");
    }
  }
  void importDayEvents() {
    if (routine.value != null) {
      // Clear existing dayEvents list
      dayEvents.clear();

      // Iterate over all days in the routine and collect DayEvent objects
      routine.value!.days.forEach((day, events) {
        dayEvents.addAll(events); // Add all events for the current day
      });

      print("DayEvents imported: ${dayEvents.length}");
    } else {
      print("Routine is null; no data to import.");
    }
  }


  @override
  void initState() {
    super.initState();
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

          // Print routine data after fetching and setting in desired format
          print("Routine fetched:\n");

          // Ensure routine value is not null and iterate over the days
          if (routine.value != null) {
            routine.value!.days.forEach((day, events) {
              print("$day:");

              // Iterate over the list of events for the current day
              for (var event in events) {
                // Print each event in the format "1: Math by Mr. A (09:00 AM - 09:45 AM)"
                print("${event.period}: ${event.subject} by ${event.teacher} (${event.startTime} - ${event.endTime})");
              }
              print(""); // Add a blank line for better readability
            });
          }
        } else {
          print("Routine field not found in the document.");
          routine.value = null;
        }
      } else {
        print("No matching school class found.");
        routine.value = null;
      }
    } catch (e) {
      print("Error fetching routine: $e");
      routine.value = null;
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
                  mainAxisAlignment:
                  MainAxisAlignment.start, // Align items to the start
                  crossAxisAlignment: CrossAxisAlignment
                      .center, // Align items vertically to center
                  children: [
                    dialogSelector(selectedClass, classList, 'Class',
                            (val) async {
                          if (selectedClass.value.isNotEmpty &&
                              selectedSection.value.isNotEmpty &&
                              selectedDay.value.isNotEmpty) {
                            await fetchRoutineBySchoolClass('SCH0000000001',
                                selectedClass.value, selectedSection.value);
                            importDayEvents();

                          }
                        }),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    dialogSelector(selectedSection, sectionList, 'Sec',
                            (val) async {
                          if (selectedClass.value.isNotEmpty &&
                              selectedSection.value.isNotEmpty &&
                              selectedDay.value.isNotEmpty) {
                            await fetchRoutineBySchoolClass('SCH0000000001',
                                selectedClass.value, selectedSection.value);
                            importDayEvents();

                          }
                        }),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    dialogSelector(selectedDay, SchoolLists.dayList, 'Day',
                            (val) async {
                          if (selectedClass.value.isNotEmpty &&
                              selectedSection.value.isNotEmpty &&
                              selectedDay.value.isNotEmpty) {
                            await fetchRoutineBySchoolClass('SCH0000000001',
                                selectedClass.value, selectedSection.value);
                            importDayEvents();

                          }
                        }),
                  ],
                ),
              ),
            ),
            // const SizedBox(height: SchoolSizes.md),
            TextButton(onPressed: (){sendRoutineToFirebase('SCH0000000001', '4', 'A');}, child: Text('Send')),
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
                    editEvent(index, updatedEvent);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  void deleteEvent(int index) {
    if (routine.value != null) {
      // Get the current list of events for the selected day
      List<DayEvent> events = List.from(routine.value!.days[selectedDay.value] ?? []);

      // Remove the event at the specified index
      events.removeAt(index);

      // Update the routine's day events with the modified list
      routine.value!.days[selectedDay.value] = events;

      // Trigger a UI update by using RxState (since routine is an Rx)
      routine.refresh();
    }
  }

  void editEvent(int index, DayEvent updatedEvent) {
    if (routine.value != null) {
      // Get the current list of events for the selected day
      List<DayEvent> events = List.from(routine.value!.days[selectedDay.value] ?? []);

      // Replace the event at the specified index with the updated event
      events[index] = updatedEvent;

      // Update the routine's day events with the modified list
      routine.value!.days[selectedDay.value] = events;

      // Trigger a UI update by using RxState (since routine is an Rx)
      routine.refresh();
    }
  }
}