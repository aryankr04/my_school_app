import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../data/services/firebase_for_school.dart';

class AssignHomeworkController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();
  RxString selectedClass = ''.obs;
  RxString selectedSection = ''.obs;
  RxString selectedSubject = ''.obs;
  TextEditingController homeworkController = TextEditingController();

  Future<void> storeHomeworkData() async {
    try {
      // Ensure all required fields are selected
      if (selectedClass.isEmpty ||
          selectedSection.isEmpty ||
          selectedSubject.isEmpty ||
          homeworkController.value=='') {
        SchoolHelperFunctions.showErrorSnackBar('Please Enter the details');
        return;
      }
      SchoolHelperFunctions.showLoadingOverlay();

      String timestamp = DateFormat('dd MMM yyyy').format(DateTime.now());

      // Add a new document with homework data
      await FirebaseFirestore.instance.collection('homework').add({
        'teacherId': 'TEA0000000001',
        'schoolId': 'SCH0000000001',
        'sectionId': 'SEC0000000001',
        'className': selectedClass.value,
        'sectionName': selectedSection.value,
        'subject': selectedSubject.value,
        'homeworkText': homeworkController.text,
        'timestamp': timestamp, // Optional timestamp
      });

      // Optionally, you can reset form fields after storing data
      selectedClass.value = '';
      selectedSection.value = '';
      selectedSubject.value = '';
      homeworkController.clear();

      // Perform any additional actions after storing data

      // Display a success message
      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
          'Success, Homework data stored successfully');
    } catch (error) {
      // Handle the error, display an error message, or log it
      print('Error storing homework data: $error');
      SchoolHelperFunctions.showErrorSnackBar(
          'Error Failed to store homework data');
    }
  }

  Future<List<DocumentSnapshot>> getSectionsForClass6() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('section')
        .where('class', isEqualTo: '6')
        .get();

    return querySnapshot.docs;
  }
}
