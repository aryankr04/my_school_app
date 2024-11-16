import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/option_list0.dart';
import '../../../../common/widgets/option_list.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../management/manage_syllabus/add_new_syllabus.dart';

class Syllabus extends StatefulWidget {
  const Syllabus({Key? key}) : super(key: key);

  @override
  State<Syllabus> createState() => _SyllabusState();
}

class _SyllabusState extends State<Syllabus> {
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
            //buildExpansionPanelList(),

            Container(
              padding: EdgeInsets.only(
                  left: SchoolSizes.lg,
                  right: SchoolSizes.lg,
                  top: SchoolSizes.lg,
                  bottom: SchoolSizes.sm),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Select Options",
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: 18)),
                    ],
                  ),
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
                                      Row(
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
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                selectedSubject.value,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineSmall
                                                    ?.copyWith(fontSize: 18),
                                              ),
                                              Text(
                                                '${marks.value} Marks',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .labelMedium,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                ExamWidget(
                                  isWrite: false,
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

  fetchSyllabus() async {
    List<Map<String, dynamic>> fetchedSyllabusList =
        await fetchSyllabusToFirebase(
      'SCH0000000001',
      selectedClass.value,
      selectedSubject.value,
      selectedExam.value,
    );
    syllabusList.assignAll(fetchedSyllabusList);
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

        // Extract and return the topics data
        List<dynamic> topics = documentSnapshot['topics'];
        List<Map<String, dynamic>> syllabusTopics = [];
        marks.value = documentSnapshot['marks'];
        topics.forEach((topic) {
          syllabusTopics.add({
            'chapterTopicName': topic['chapterTopicName'],
            'subTopics': List<String>.from(topic['subTopics'] ?? []),
            'marks': topic['marks'] ?? 0,
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
}

Widget dialogSelector(
  RxString name,
  List<String> items,
  String field,
  void Function(String selectedItem)? onSelected,
) {
  return Obx(() => InkWell(
        onTap: () async {
          String? selectedItem = await _showOptionsDialog(Get.context!, items);
          if (selectedItem != null) {
            name.value = selectedItem;
            if (onSelected != null) {
              onSelected(selectedItem);
            }
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: name.value == ''
                ? SchoolDynamicColors.backgroundColorWhiteDarkGrey
                : SchoolDynamicColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
            border: Border.all(
              color: name.value == ''
                  ? SchoolHelperFunctions.isDarkMode(Get.context!)
                      ? SchoolDynamicColors.borderColor
                      : SchoolDynamicColors.subtitleTextColor
                  : SchoolDynamicColors.primaryColor,
              width: name.value == '' ? 0.5 : 0.5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$field:  ${name.value}',
                  style: Theme.of(Get.context!).textTheme.labelLarge?.copyWith(
                      color: name.value == ''
                          ? SchoolDynamicColors.subtitleTextColor
                          : SchoolDynamicColors.primaryColor,
                      fontSize: 13),
                ),

                Row(
                  children: [
                    // SizedBox(
                    //   width: SchoolSizes.xs,
                    // ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: name.value == ''
                          ? SchoolDynamicColors.iconColor
                          : SchoolDynamicColors.primaryColor,
                      size: 24
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ));
}

// Function to show the dialog
Future<String?> _showOptionsDialog(
    BuildContext context, List<String> items) async {
  return await showDialog<String>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select an option'),
        content: Container(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(items[index]),
                onTap: () {
                  // Return the selected item
                  Navigator.of(context).pop(items[index]);
                },
              );
            },
          ),
        ),
      );
    },
  );
}

class ExamWidget extends StatelessWidget {
  final List<SyllabusTopics> topics;
  final bool isWrite;

  const ExamWidget({
    Key? key,
    required this.topics,
    required this.isWrite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            for (final subject in topics)
              Column(
                children: [
                  Divider(
                    thickness: 0.5,
                    color: SchoolDynamicColors.borderColor,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.only(top: 5),
                          child:  CircleAvatar(
                            backgroundColor: SchoolDynamicColors.primaryColor,
                            radius: 4,
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          child: Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        subject.topicName,
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${subject.marks} Marks',
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        isWrite
                                            ? Row(
                                                children: [
                                                  SizedBox(
                                                    width: SchoolSizes.md,
                                                  ),
                                                  Icon(
                                                    Icons.add,
                                                    color:
                                                        SchoolDynamicColors.activeBlue,
                                                  ),
                                                  SizedBox(
                                                    width: SchoolSizes.md,
                                                  ),
                                                  Icon(
                                                    Icons.edit,
                                                    color:
                                                        SchoolDynamicColors.activeBlue,
                                                  ),
                                                  SizedBox(
                                                    width: SchoolSizes.md,
                                                  ),
                                                  Icon(
                                                    Icons.delete,
                                                    color:
                                                        SchoolDynamicColors.activeRed,
                                                  ),
                                                ],
                                              )
                                            : SizedBox()
                                      ],
                                    ),
                                  ],
                                ),
                                subject.subTopics.length > 0
                                    ? SizedBox(height: 8)
                                    : SizedBox(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (int i = 0;
                                        i < subject.subTopics.length;
                                        i++)
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8),
                                        child: Text(
                                          '${i + 1}. ${subject.subTopics[i]}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                      ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
        SizedBox(
          height: SchoolSizes.sm,
        )
      ],
    );
  }
}

class SyllabusTopics {
  final String topicName;
  final List<String> subTopics;
  final String marks;

  SyllabusTopics(
      {required this.topicName, required this.subTopics, required this.marks});
}
