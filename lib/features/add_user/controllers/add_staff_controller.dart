import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/firebase_for_school.dart';
import '../../../utils/constants/lists.dart';
import '../../../utils/helpers/firebase_helper_function.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../models/staff.dart';

class AddStaffController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final GlobalKey<FormState> addStaffFormKey = GlobalKey<FormState>();

  Rx<File?> staffImage = Rx<File?>(null);
  TextEditingController selectedSchoolController = TextEditingController();
  Rx<DateTime?> dateOfBirthController = DateTime.now().obs;
  Rx<String> selectedPosition = ''.obs;
  Rx<String> selectedGender = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;

  bool isFormValid() {
    return addStaffFormKey.currentState?.validate() ?? false;
  }

  Future<void> addStaffToFirebase() async {
    try {
      if (staffImage.value == null) {
        SchoolHelperFunctions.showAlertSnackBar(
          'Please select an image.',
        );
        return;
      }

      if (selectedSchoolController.text == '') {
        SchoolHelperFunctions.showErrorSnackBar(
          'Please select a valid School',
        );
      }

      if (!isFormValid()) {
        SchoolHelperFunctions.showErrorSnackBar(
          'Please enter valid details.',
        );
        return;
      }

      SchoolHelperFunctions.showLoadingOverlay();
      String imageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: staffImage.value!,
        imageName: 'staff_image',
        folder: 'staff_images',
      );

      String? staffId =
          await firebaseFunction.generateNewIdWithPrefix('STA', 'staffs');

      // Prepare data to be sent to Firestore
      Staff staff = Staff(
        uid: staffId!,
        imageUrl: imageUrl,
        staffName: nameController.text,
        schoolId: selectedSchoolController.text,
        dob: dateOfBirthController.value!,
        gender: selectedGender.value,
        position: selectedPosition.value,
        mobileNumber: mobileNumberController.text,
        address: addressController.text,
        qualification: qualificationController.text,
      );

      // Convert the Staff instance to a JSON map
      Map<String, dynamic> staffData = staff.toJson();

      // Send data to Firestore
      await FirebaseFirestore.instance
          .collection('staffs')
          .doc(staffId)
          .set(staffData);

      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
        'Staff added successfully!',
      );
    } catch (e) {
      print('Error adding staff: $e');
      SchoolHelperFunctions.showErrorSnackBar(
        'Error adding staff. Please try again.',
      );
    }
  }

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
    // Dispose of text controllers
    nameController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    qualificationController.dispose();

    // Dispose of Rx variables
    staffImage.close();
    dateOfBirthController.close();
    selectedPosition.close();
    selectedGender.close();
    schoolList.close();

    super.onClose();
  }
}
