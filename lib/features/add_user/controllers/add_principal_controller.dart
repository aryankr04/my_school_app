import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/firebase_for_school.dart';
import '../../../utils/helpers/firebase_helper_function.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../models/principal.dart';

class AddPrincipalController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final GlobalKey<FormState> addPrincipalFormKey = GlobalKey<FormState>();

  Rx<File?> principalImage = Rx<File?>(null);
  TextEditingController selectedSchoolController = TextEditingController();
  Rx<DateTime?> dateOfBirthController = Rx<DateTime?>(null);
  Rx<String> selectedGender = ''.obs;

  TextEditingController principalNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;

  bool isFormValid() {
    return addPrincipalFormKey.currentState?.validate() ?? false;
  }

  Future<void> addPrincipalToFirebase() async {
    try {


      if (principalImage.value == null) {
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

      // if (!isFormValid()) {
      //   SchoolHelperFunctions.showErrorSnackBar(
      //     'Please enter valid details.',
      //   );
      //   return;
      // }

      SchoolHelperFunctions.showLoadingOverlay();

      // Upload image to Firebase Storage
      String imageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: principalImage.value!,
        imageName: 'principal_image',
        folder: 'principal_images',
      );



      String? principalId =
          await firebaseFunction.generateNewIdWithPrefix('PRI', 'principals');

      // Prepare data to be sent to Firestore
      Principal principal = Principal(
        uid: principalId!,
        imageUrl: imageUrl,
        principalName: principalNameController.text,
        schoolId: selectedSchoolController.text,
        dob: dateOfBirthController.value!,
        gender: selectedGender.value,
        mobileNumber: mobileNumberController.text,
        address: addressController.text,
        email: emailController.text,
        qualification: qualificationController.text,
      );

      // Convert the Principal instance to a JSON map
      Map<String, dynamic> principalData = principal.toJson();


      // Send data to Firestore
      await FirebaseFirestore.instance
          .collection('principals')
          .doc(principalId)
          .set(principalData);
      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
        'Principal added successfully!',
      );
    } catch (e) {
      print('Error adding principal: $e');
      SchoolHelperFunctions.showErrorSnackBar(
        'Error adding principal. Please try again.',
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

  void clearForm() {
    principalImage.value = null;
    dateOfBirthController.value = null;
    selectedGender.value = '';
    selectedSchoolController.clear();
    principalNameController.clear();
    mobileNumberController.clear();
    addressController.clear();
    emailController.clear();
    qualificationController.clear();
    schoolList.clear();
    addPrincipalFormKey.currentState?.reset();
  }

  @override
  void onClose() {
    // Dispose of text controllers
    principalNameController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    emailController.dispose();
    qualificationController.dispose();

    // Dispose of Rx variables
    principalImage.close();
    dateOfBirthController.close();
    selectedGender.close();
    schoolList.close();

    super.onClose();
  }
}
