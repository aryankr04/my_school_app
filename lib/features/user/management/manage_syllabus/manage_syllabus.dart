import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/management/manage_syllabus/add_new_syllabus_topics.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../student/syllabus_and_routine/syllabus.dart';
import 'add_new_syllabus.dart';

class ManageSyllabus extends StatefulWidget {
  const ManageSyllabus({Key? key}) : super(key: key);

  @override
  State<ManageSyllabus> createState() => _ManageSyllabusState();
}

class _ManageSyllabusState extends State<ManageSyllabus> {
  List<String> classList = SchoolLists.classList;
  List<String> subjectList = SchoolLists.subjectList;
  List<String> examList = SchoolLists.examList;

  RxString selectedClass = ''.obs;
  RxString selectedSubject = ''.obs;
  RxString selectedExam = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syllabus'),
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
            Container(
              padding: EdgeInsets.only(
                  left: SchoolSizes.lg,
                  right: SchoolSizes.lg,
                  top: SchoolSizes.lg,
                  bottom: SchoolSizes.sm),
              child: Column(
                children: [
                  Text("Select Options",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontSize: 18)),
                ],
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
                          selectedSubject.value != '' &&
                          selectedExam.value != '') {
                        marks.value = '';
                        topicNames.clear();
                        topicMarks.clear();
                        fetchSyllabus();
                      }
                    }),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    dialogSelector(selectedSubject, subjectList, 'Subject',
                        (val) {
                      if (selectedClass.value != '' &&
                          selectedSubject.value != '' &&
                          selectedExam.value != '') {
                        marks.value = '';
                        topicNames.clear();
                        topicMarks.clear();
                        fetchSyllabus();
                      }
                    }),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    dialogSelector(selectedExam, examList, 'Exam', (val) {
                      if (selectedClass.value != '' &&
                          selectedSubject.value != '' &&
                          selectedExam.value != '') {
                        marks.value = '';
                        topicNames.clear();
                        topicMarks.clear();

                        fetchSyllabus();
                      }
                    }),
                  ],
                ),
              ),
            ),
            const SizedBox(height: SchoolSizes.md),
            Divider(
              thickness: 1,
              color: SchoolDynamicColors.grey,
            ),
            const SizedBox(height: SchoolSizes.lg),
            Obx(() => Container(
                  padding: EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              selectedExam.value == ''
                                  ? 'Select Exam'
                                  : selectedExam.value,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    // color: SchoolColors.primary
                                  ),
                            ),
                            Text(
                              "Class $selectedClass ",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: SchoolSizes.md,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                            borderRadius:
                                BorderRadius.circular(SchoolSizes.cardRadiusMd),
                            border: Border.all(
                                color: SchoolDynamicColors.borderColor, width: 0.5),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: SchoolSizes.md,
                                      right: SchoolSizes.md,
                                      top: SchoolSizes.md,
                                      bottom: SchoolSizes.sm),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Row(
                                          children: [
                                            Container(
                                              alignment: Alignment.center,
                                              padding:
                                                  EdgeInsets.all(SchoolSizes.sm),
                                              decoration: BoxDecoration(
                                                color: SchoolDynamicColors
                                                    .backgroundColorTintLightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        SchoolSizes.cardRadiusSm),
                                              ),
                                              child: Icon(
                                                Icons.school,
                                                color: SchoolDynamicColors.primaryIconColor,
                                                size: 24,
                                              ),
                                            ),
                                            SizedBox(width: SchoolSizes.md),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          '${selectedSubject.value}',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .headlineSmall
                                                              ?.copyWith(
                                                                  fontSize: 18),
                                                          overflow:
                                                              TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${marks.value} Marks',
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .labelMedium,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          if (selectedClass.value != '' &&
                                              selectedSubject.value != '' &&
                                              selectedExam.value != '') {
                                            SchoolHelperFunctions
                                                .navigateToScreen(
                                                    Get.context!,
                                                    AddNewSyllabusTopics(
                                                        schoolId:
                                                            'SCH0000000001',
                                                        className:
                                                            selectedClass.value,
                                                        examName:
                                                            selectedExam.value,
                                                        marks: marks.value,
                                                        subject: selectedSubject
                                                            .value,
                                                        topicNames: topicNames,
                                                        topicMarks:
                                                            topicMarks));
                                          }
                                        },
                                        child: Container(
                                          constraints:
                                              BoxConstraints(minWidth: 100),
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: SchoolSizes.sm + 4,
                                              horizontal: SchoolSizes.md),
                                          decoration: BoxDecoration(
                                            color: SchoolHelperFunctions
                                                    .isDarkMode(Get.context!)
                                                ? SchoolDynamicColors.activeBlue
                                                    .withOpacity(0.8)
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
                                ExamWidget(
                                  isWrite: true,
                                  topics: syllabusList.map((syllabusItem) {
                                    return SyllabusTopics(
                                      topicName:
                                          syllabusItem['chapterTopicName'],
                                      subTopics: syllabusItem['subTopics'],
                                      marks: syllabusItem['marks'],
                                    );
                                  }).toList(),
                                ),
                              ])),
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }

  RxList<Map<String, dynamic>> syllabusList = <Map<String, dynamic>>[].obs;
  List<String> topicNames = [];
  List<String> topicMarks = [];
  fetchSyllabus() async {
    List<Map<String, dynamic>> fetchedSyllabusList =
        await fetchSyllabusToFirebase(
      'SCH0000000001',
      selectedClass.value,
      selectedSubject.value,
      selectedExam.value,
    );
    syllabusList.assignAll(fetchedSyllabusList);
    topicNames = syllabusList.map((syllabusItem) {
      return syllabusItem['chapterTopicName'] as String;
    }).toList();
    topicMarks = syllabusList.map((syllabusItem) {
      return syllabusItem['marks'] as String;
    }).toList();
  }

  RxString marks = ''.obs;
  Future<List<Map<String, dynamic>>> fetchSyllabusToFirebase(String schoolId,
      String className, String subject, String examName) async {
    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Check if a document with matching criteria already exists
      QuerySnapshot querySnapshot = await firestore
          .collection('syllabus')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .where('subject', isEqualTo: subject)
          .where('examName', isEqualTo: examName)
          .get();

      // If a matching document exists
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first matching document
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
        marks.value = documentSnapshot['marks'];
        // Extract and return the topics data
        List<dynamic> topics = documentSnapshot['topics'];
        List<Map<String, dynamic>> syllabusTopics = [];
        topics.forEach((topic) {
          syllabusTopics.add({
            'chapterTopicName': topic['chapterTopicName'],
            'subTopics': List<String>.from(topic['subTopics'] ?? []),
            'marks': topic['marks'] ?? [],
          });
        });
        return syllabusTopics;
      } else {
        // No matching document found
        return [];
      }
    } catch (error) {
      print('Error fetching syllabus from Firebase: $error');
      // Handle the error appropriately, e.g., show an error message to the user
      return [];
    }
  }

//Class, Subject, Exam Selection Widget
}
