import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/firebase_for_school.dart';
import '../../../utils/helpers/firebase_helper_function.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../models/manager.dart';

class AddManagementController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final GlobalKey<FormState> addManagementFormKey = GlobalKey<FormState>();

  TextEditingController selectedSchoolController = TextEditingController();
  final nameController = TextEditingController();
  final dateOfBirthController = Rx<DateTime?>(null);
  final mobileNumberController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final qualificationController = TextEditingController();
  Rx<File?> managementImage = Rx<File?>(null);

  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;

  bool isFormValid() {
    return addManagementFormKey.currentState?.validate() ?? false;
  }

  Future<void> addManagementToFirebase() async {
    try {
      if (managementImage.value == null) {
        SchoolHelperFunctions.showAlertSnackBar(
          'Please select an image and school.',
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
        imageFile: managementImage.value!,
        imageName: 'manager_image',
        folder: 'managers_images',
      );



      String? managerId =
          await firebaseFunction.generateNewIdWithPrefix('MAN', 'managers');

      Manager manager = Manager(
        schoolId: selectedSchoolController.text,
        uid: managerId!,
        managerName: nameController.text,
        dateOfBirth: dateOfBirthController.value!,
        mobileNumber: mobileNumberController.text,
        address: addressController.text,
        email: emailController.text,
        qualification: qualificationController.text,
        profileImageUrl: imageUrl,
      );

      // Convert the Management instance to a JSON map
      Map<String, dynamic> managerData = manager.toJson();


      await FirebaseFirestore.instance
          .collection('managers')
          .doc(managerId)
          .set(managerData);

      Get.back();

      SchoolHelperFunctions.showSuccessSnackBar(
        'Management added successfully!',
      );
    } catch (e) {
      SchoolHelperFunctions.showErrorSnackBar(
        'Error adding management. Please try again.',
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
    emailController.dispose();
    qualificationController.dispose();

    // Dispose of Rx variables
    dateOfBirthController.close();
    managementImage.close();
    schoolList.close();

    super.onClose();
  }
}
