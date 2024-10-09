import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/services/firebase_for_school.dart';
import '../../../utils/helpers/firebase_helper_function.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../models/driver.dart';

class AddDriverController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final GlobalKey<FormState> addDriverFormKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final mobileNumberController = TextEditingController();
  final addressController = TextEditingController();
  final qualificationController = TextEditingController();
  final licenceNumberController = TextEditingController();
  final dateOfBirthController = Rx<DateTime?>(null);
  Rx<File?> directorImage = Rx<File?>(null);
  TextEditingController selectedSchoolController = TextEditingController();
  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;
  final selectedVehicle = ''.obs;
  final selectedGender = ''.obs;

  bool isFormValid() {
    return addDriverFormKey.currentState?.validate() ?? false;
  }

  Future<void> addDriverToFirebase() async {
    try {
      if (directorImage.value == null) {
        SchoolHelperFunctions.showAlertSnackBar('Please select an image.');
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
        imageFile: directorImage.value!,
        imageName: 'driver_image',
        folder: 'driver_images',
      );



      String? driverId =
          await firebaseFunction.generateNewIdWithPrefix('DRI', 'drivers');

      Driver driver = Driver(
        uid: driverId!,
        schoolId: selectedSchoolController.text,
        driverName: nameController.text,
        dateOfBirth: dateOfBirthController.value!,
        gender: selectedGender.value,
        mobileNumber: mobileNumberController.text,
        address: addressController.text,
        qualification: qualificationController.text,
        selectedVehicle: selectedVehicle.toString(),
        licenceNumber: licenceNumberController.text,
        profileImageUrl: imageUrl,
      );

      // Convert the Driver instance to a JSON map
      Map<String, dynamic> driverData = driver.toJson();

      await FirebaseFirestore.instance
          .collection('drivers')
          .doc(driverId)
          .set(driverData);

      Get.back();

      SchoolHelperFunctions.showSuccessSnackBar('Driver added successfully!');
    } catch (e) {
      print('Error adding driver: $e');
      SchoolHelperFunctions.showErrorSnackBar(
          'Error adding driver. Please try again.');
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
    licenceNumberController.dispose();

    // Dispose of Rx variables
    dateOfBirthController.close();
    directorImage.close();
    schoolList.close();
    selectedVehicle.close();
    selectedGender.close();

    super.onClose();
  }
}
