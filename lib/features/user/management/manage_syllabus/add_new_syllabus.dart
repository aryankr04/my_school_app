import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

import '../../../../common/widgets/text_form_feild.dart';

class AddNewSyllabus extends StatefulWidget {
  final String schoolId;
  final String className;
  final String subject;
  final String examName;
  final String marks;
  const AddNewSyllabus(
      {Key? key,
      required this.schoolId,
      required this.className,
      required this.subject,
      required this.examName, required this.marks})
      : super(key: key);

  @override
  _AddNewSyllabusState createState() => _AddNewSyllabusState();
}

class _AddNewSyllabusState extends State<AddNewSyllabus> {
  late String schoolId;
  late String className;
  late String subject;
  late String examName;
  late String marks;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    schoolId = widget.schoolId;
    className = widget.className;
    subject = widget.subject;
    examName = widget.examName;
    subjectController.text=subject;
    marks=widget.marks;
    subjectMarksController.text=marks;

  }

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController subjectMarksController = TextEditingController();
  final TextEditingController chapterTopicNameController =
      TextEditingController();
  final TextEditingController topicMarksController = TextEditingController();
  final List<TextEditingController> _subTopicControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Syllabus'),
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
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: SchoolTextFormField(
                      labelText: 'Subject',
                      controller: subjectController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                        hintText: 'Enter subject name',
                        hintStyle: Theme.of(Get.context!)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SchoolSizes.md,
                  ),
                  Flexible(
                    child: SchoolTextFormField(
                      keyboardType: TextInputType.number,
                      labelText: 'Marks',
                      controller: subjectMarksController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                        hintText: 'Marks',
                        hintStyle: Theme.of(Get.context!)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              Row(
                children: [
                  Flexible(
                    flex: 2,
                    child: SchoolTextFormField(
                      labelText: 'Chapter/Topic Name',
                      controller: chapterTopicNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                        hintText: 'Enter chapter or topic name',
                        hintStyle: Theme.of(Get.context!)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: SchoolSizes.md,
                  ),
                  Flexible(
                    child: SchoolTextFormField(
                      keyboardType: TextInputType.number,
                      labelText: 'Marks',
                      controller: topicMarksController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                        hintText: 'Marks',
                        hintStyle: Theme.of(Get.context!)
                            .textTheme
                            .bodySmall
                            ?.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              ..._subTopicControllers.asMap().entries.map((entry) {
                int index = entry.key;
                TextEditingController controller = entry.value;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sub-Topic',
                      style: Theme.of(Get.context!)
                          .textTheme
                          .labelLarge
                          ?.copyWith(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: SchoolSizes.xs,
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: TextFormField(
                            controller: controller,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                              suffixIcon: Icon(Icons.class_),
                              hintText: 'Enter sub-topic name',
                              hintStyle: Theme.of(Get.context!)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              _subTopicControllers.removeAt(index);
                            });
                          },
                          icon: Icon(
                            Icons.remove_circle,
                            color: SchoolDynamicColors.activeRed,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SchoolSizes.lg,
                    )
                  ],
                );
              }).toList(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _subTopicControllers.add(TextEditingController());
                    });
                  },
                  child: Text('Add New Sub-Topic'),
                ),
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              ElevatedButton(
                onPressed: () {
                  sendSyllabusToFirebase();
                },
                child: Text('Update'),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> fetchSyllabusToFirebase() async {
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
        topics.forEach((topic) {
          syllabusTopics.add({
            'chapterTopicName': topic['chapterTopicName'],
            'subTopics': List<String>.from(topic['subTopics']),
            'marks': topic['marks']
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

  Future<void> deleteTopicFromFirebase(String schoolId, String className,
      String subject, String examName, String topicName) async {
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

        // Get the topics data
        List<dynamic> topics = documentSnapshot['topics'];

        // Remove the specified topic from the topics list
        topics.removeWhere((topic) => topic['chapterTopicName'] == topicName);

        // Update the document with the modified topics data
        await documentSnapshot.reference.update({
          'topics': topics,
        });

        // Show success message or perform other actions if needed
      } else {
        // No matching document found, handle the case accordingly
      }
    } catch (error) {
      print('Error deleting topic from Firebase: $error');
      // Handle the error appropriately, e.g., show an error message to the user
    }
  }

  Future<void> sendSyllabusToFirebase() async {
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

        // Check if the provided topic already exists in the syllabus
        List<dynamic> topics = documentSnapshot['topics'];
        bool topicExists = topics.any((topic) =>
            topic['chapterTopicName'] == chapterTopicNameController.text);

        if (topicExists) {
          // Topic exists, so update it by replacing the subtopics
          String docId = documentSnapshot.id;
          List<dynamic> updatedTopics = List.from(topics);
          updatedTopics.removeWhere((topic) =>
              topic['chapterTopicName'] == chapterTopicNameController.text);
          updatedTopics.add({
            'chapterTopicName': chapterTopicNameController.text,
            'subTopics': _subTopicControllers
                .map((controller) => controller.text)
                .toList(),
            'marks': topicMarksController.text
          });
          await firestore.collection('syllabus').doc(docId).update({
            'marks':subjectMarksController.text,
            'topics': updatedTopics,
          });
        } else {
          // Topic doesn't exist, so create a new topic with the provided data
          await firestore
              .collection('syllabus')
              .doc(documentSnapshot.id)
              .update({
            'topics': FieldValue.arrayUnion([
              {
                'chapterTopicName': chapterTopicNameController.text,
                'subTopics': _subTopicControllers
                    .map((controller) => controller.text)
                    .toList(),
                'marks': topicMarksController.text
              }
            ])
          });
        }
      } else {
        // Add new document with the syllabus data under a subcollection
        DocumentReference documentRef =
            await firestore.collection('syllabus').add({
          'schoolId': schoolId,
          'className': className,
          'subject': subject,
          'examName': examName,
              'marks':subjectMarksController.text,
          'topics': [
            {
              'chapterTopicName': chapterTopicNameController.text,
              'subTopics': _subTopicControllers
                  .map((controller) => controller.text)
                  .toList(),
              'marks': topicMarksController.text
            }
          ]
        });
      }

      Get.back();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Syllabus added successfully')),
      );
    } catch (error) {
      print('Error sending syllabus to Firebase: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to add syllabus. Please try again later.')),
      );
    }
  }

  @override
  void dispose() {
    // Dispose all the TextEditingController objects
    _subTopicControllers.forEach((controller) {
      controller.dispose();
    });
    super.dispose();
  }
}

class SyllabusTopicData {
  final String topicName;
  final List<String> subTopics;
  final int marks;

  SyllabusTopicData({
    required this.topicName,
    required this.subTopics,
    required this.marks,
  });

  factory SyllabusTopicData.fromJson(Map<String, dynamic> json) {
    return SyllabusTopicData(
      topicName: json['topicName'] ?? '',
      subTopics: (json['subTopics'] as List<dynamic>).cast<String>(),
      marks: json['marks'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topicName': topicName,
      'subTopics': subTopics,
      'marks': marks,
    };
  }
}

class SyllabusData {
  final String schoolId;
  final String className;
  final String subject;
  final String examName;
  final int marks;

  SyllabusData({
    required this.schoolId,
    required this.className,
    required this.subject,
    required this.examName,
    required this.marks,
  });

  factory SyllabusData.fromJson(Map<String, dynamic> json) {
    return SyllabusData(
      schoolId: json['schoolId'] ?? '',
      className: json['className'] ?? '',
      subject: json['subject'] ?? '',
      examName: json['examName'] ?? '',
      marks: json['marks'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolId': schoolId,
      'className': className,
      'subject': subject,
      'examName': examName,
      'marks': marks,
    };
  }
}
