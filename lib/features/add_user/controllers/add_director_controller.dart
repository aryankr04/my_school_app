import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/helpers/firebase_helper_function.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../data/services/firebase_for_school.dart';
import '../models/director.dart';

class AddDirectorController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final GlobalKey<FormState> addDirectorFormKey = GlobalKey<FormState>();

  Rx<File?> directorImage = Rx<File?>(null);
  Rx<DateTime?> dateOfBirthController = Rx<DateTime?>(null);
  Rx<String> selectedGender = ''.obs;

  TextEditingController selectedSchoolController = TextEditingController();
  TextEditingController directorNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController qualificationController = TextEditingController();

  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;

  bool get isFormValid => addDirectorFormKey.currentState?.validate() ?? false;

  Future<void> addDirectorToFirebase() async {
    try {
      if (directorImage.value == null) {
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

      // if (!isFormValid) {
      //   SchoolHelperFunctions.showErrorSnackBar(
      //     'Please enter valid details.',
      //   );
      //   return;
      // }

      SchoolHelperFunctions.showLoadingOverlay();

      // Upload image to Firebase Storage
      String imageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: directorImage.value!,
        imageName: 'director_image',
        folder: 'director_images',
      );



      String? directorId =
          await firebaseFunction.generateNewIdWithPrefix('DIR', 'directors');

      // Prepare data to be sent to Firestore
      Director director = Director(
        uid: directorId!,
        imageUrl: imageUrl,
        directorName: directorNameController.text,
        schoolId: selectedSchoolController.value.toString(),
        dob: dateOfBirthController.value!,
        gender: selectedGender.value,
        mobileNumber: mobileNumberController.text,
        address: addressController.text,
        email: emailController.text,
        qualification: qualificationController.text,
      );

      // Convert the Director instance to a JSON map
      Map<String, dynamic> directorData = director.toJson();

      // Send data to Firestore
      await FirebaseFirestore.instance
          .collection('directors')
          .doc(directorId)
          .set(directorData);
      Get.back();

      SchoolHelperFunctions.showSuccessSnackBar(
        'Director added successfully!',
      );
    } catch (e) {
      print('Error adding director: $e');
      SchoolHelperFunctions.showErrorSnackBar(
        'Error adding director. Please try again.',
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
    directorImage.value = null;
    dateOfBirthController.value = null;
    selectedGender.value = '';
    selectedSchoolController.clear();
    directorNameController.clear();
    mobileNumberController.clear();
    addressController.clear();
    emailController.clear();
    qualificationController.clear();
    schoolList.clear();
    addDirectorFormKey.currentState?.reset();
  }

  @override
  void onClose() {
    // Dispose of text controllers
    selectedSchoolController.dispose();
    directorNameController.dispose();
    mobileNumberController.dispose();
    addressController.dispose();
    emailController.dispose();
    qualificationController.dispose();

    // Dispose of Rx variables
    directorImage.close();
    dateOfBirthController.close();
    selectedGender.close();

    super.onClose();
  }
}
