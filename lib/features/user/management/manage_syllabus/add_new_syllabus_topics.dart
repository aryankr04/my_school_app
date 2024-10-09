import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

import '../../../../common/widgets/text_form_feild.dart';

class AddNewSyllabusTopics extends StatefulWidget {
  final String schoolId;
  final String className;
  final String subject;
  final String examName;
  final String marks;
  final List<String> topicNames;
  final List<String> topicMarks;
  const AddNewSyllabusTopics(
      {Key? key,
      required this.schoolId,
      required this.className,
      required this.subject,
      required this.examName,
      required this.marks,
      required this.topicNames,
      required this.topicMarks})
      : super(key: key);

  @override
  _AddNewSyllabusTopicsState createState() => _AddNewSyllabusTopicsState();
}

class _AddNewSyllabusTopicsState extends State<AddNewSyllabusTopics> {
  late String schoolId;
  late String className;
  late String subject;
  late String examName;
  late String marks;
  late List<String> topicNames;
  late List<String> topicMarks;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topicNames = widget.topicNames;
    topicMarks = widget.topicMarks;

    for (int i = 0; i < widget.topicNames.length; i++) {
      topicControllers.add(TextEditingController(text: topicNames[i]));
      topicMarksControllers.add(TextEditingController(text: topicMarks[i]));
    }
    topicControllers.add(TextEditingController());
    topicMarksControllers.add(TextEditingController());
    schoolId = widget.schoolId;
    className = widget.className;
    subject = widget.subject;
    examName = widget.examName;
    subjectController.text = subject;
    marks = widget.marks;
    subjectMarksController.text = marks;
  }

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController subjectMarksController = TextEditingController();

  final List<TextEditingController> topicMarksControllers = [];
  final List<TextEditingController> topicControllers = [];

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
              // Divider(color: SchoolColors.activeBlue.withOpacity(0.5),thickness: 0.75,),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              ...buildTopicFormFields(),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      topicControllers.add(TextEditingController());
                      topicMarksControllers.add(TextEditingController());
                    });
                  },
                  child: Text('Add New Topic'),
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

  List<Widget> buildTopicFormFields() {
    return topicControllers.asMap().entries.map((entry) {
      int index = entry.key;
      TextEditingController controller = entry.value;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                flex: 2,
                child: SchoolTextFormField(
                  controller: controller,
                  labelText: 'Chapter/Topic Name',
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                    hintText: 'Enter a chapter/topic name',
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
                flex: 1,
                child: SchoolTextFormField(
                  controller: topicMarksControllers[index],
                  keyboardType: TextInputType.number,
                  labelText: 'Marks',
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
              IconButton(
                onPressed: () {
                  setState(() {
                    topicControllers.removeAt(index);
                    topicMarksControllers.removeAt(
                        index); // Remove corresponding marks controller
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
    }).toList();
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

        // Get existing topics
        List<dynamic> topics = documentSnapshot['topics'];

        // Check if the provided topics already exist in the syllabus
        List<String> newTopics =
            topicControllers.map((controller) => controller.text).toList();
        List existingTopics =
            topics.map((topic) => topic['chapterTopicName']).toList();

        // Filter out existing topics from new topics list
        List<String> uniqueNewTopics = newTopics
            .where((newTopic) => !existingTopics.contains(newTopic))
            .toList();

        if (uniqueNewTopics.isNotEmpty) {
          // Add new topics with their marks
          List<Map<String, dynamic>> newTopicsData = [];
          uniqueNewTopics.forEach((topic) {
            int index = topicControllers
                .indexWhere((controller) => controller.text == topic);
            if (index != -1 && index < topicMarksControllers.length) {
              newTopicsData.add({
                'chapterTopicName': topic,
                'subTopics': [],
                'marks': topicMarksControllers[index].text,
              });
            }
          });

          await firestore
              .collection('syllabus')
              .doc(documentSnapshot.id)
              .update({
            'topics': FieldValue.arrayUnion(newTopicsData),
          });
        }
      } else {
        // Add new document with the syllabus data under a subcollection
        List<Map<String, dynamic>> topicsData = [];
        for (int i = 0; i < topicControllers.length; i++) {
          topicsData.add({
            'chapterTopicName': topicControllers[i].text,
            'subTopics': [],
            'marks': topicMarksControllers[i].text,
          });
        }

        await firestore.collection('syllabus').add({
          'schoolId': schoolId,
          'className': className,
          'subject': subject,
          'examName': examName,
          'marks': subjectMarksController.text,
          'topics': topicsData,
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
          content: Text('Failed to add syllabus. Please try again later.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    // Dispose all the TextEditingController objects
    topicMarksControllers.forEach((controller) {
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
