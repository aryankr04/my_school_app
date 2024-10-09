import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../../../data/services/firebase_for_school.dart';

class Step1FormController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final GlobalKey<FormState> step5FormKey = GlobalKey<FormState>();

  TextEditingController selectedSchoolController = TextEditingController();

  Rx<File?> image = Rx<File?>(null);
  TextEditingController studentNameController = TextEditingController();
  Rx<String> selectedClassController = Rx<String>('');
  Rx<String> selectedSectionController = Rx<String>('');
  TextEditingController rollNoController = TextEditingController();
  Rx<DateTime?> dateOfBirth = Rx<DateTime?>(null);
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;

  Future<void> fetchSchools(String query) async {
    try {
      final schools = await firebaseFunction.fetchSchools(query);
      schoolList.assignAll(schools);
    } catch (e) {
      print('Error fetching schools: $e');
    }
  }

  @override
  void onClose() {
    studentNameController.dispose();
    rollNoController.dispose();
    fatherNameController.dispose();
    motherNameController.dispose();
    super.onClose();
  }

  void setImage(File value) {
    image.value = value;
  }

  bool isFormValid() {
    if (image.value == null) {
      SchoolHelperFunctions.showAlertSnackBar( 'Please Select Profile Image');
      return false;
    }

    return step5FormKey.currentState?.validate() ?? false;
  }

}
