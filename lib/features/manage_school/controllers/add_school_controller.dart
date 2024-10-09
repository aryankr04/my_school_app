// AddSchoolController.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/option_list.dart';
import '../../../../../data/services/firebase_for_school.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/lists.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/firebase_helper_function.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../models/school_model.dart';

class AddSchoolController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final image = Rx<File?>(null);

  final TextEditingController schoolNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController schoolCodeController = TextEditingController();
  final TextEditingController affiliationController = TextEditingController();
  final TextEditingController extraCurricularActivitiesController =
      TextEditingController();

  Rx<String> selectedSchoolingSystem = ''.obs;
  Rx<String> selectedSchoolBoard = ''.obs;
  Rx<String> selectedSchoolType = ''.obs;
  Rx<String> selectedCountry = ''.obs;
  Rx<String> selectedState = ''.obs;
  Rx<String> selectedCity = ''.obs;

  Rx<DateTime?> dateOfEstablishment = Rx<DateTime?>(null);

  List<String> selectedExtraCurricularActivities = [];

  final GlobalKey<FormState> addSchoolFormKey = GlobalKey<FormState>();

  Future<void> addSchoolToFirebase() async {
    try {
      if (image.value == null) {
        SchoolHelperFunctions.showAlertSnackBar(
          'Please select an image.',
        );
        return;
      }

      if (!isFormValid()) {
        SchoolHelperFunctions.showErrorSnackBar(
          'Please enter valid details.',
        );
        return;
      }
      SchoolHelperFunctions.showLoadingOverlay();

      String imageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: image.value!,
        imageName: 'school_image',
        folder: 'school_images',
      );

      String? schoolId =
          await firebaseFunction.generateNewIdWithPrefix('SCH', 'schools');
      if (schoolId == null) {
        // Handle error
        return;
      }

      School school = School(
        schoolId: schoolId,
        profileImageUrl: imageUrl,
        schoolName: schoolNameController.text,
        dateOfEstablishment: dateOfEstablishment.value!,
        address: addressController.text,
        mobileNo: mobileNoController.text,
        email: emailController.text,
        schoolingSystem: selectedSchoolingSystem.value,
        schoolBoard: selectedSchoolBoard.value,
        schoolCode: schoolCodeController.text,
        schoolType: selectedSchoolType.value,
        affiliation: affiliationController.text,
        extracurricularActivities: selectedExtraCurricularActivities,


        classes: [],
        numberOfDirectors: 0,
        numberOfPrincipal: 0,
        numberOfManagements: 0,
        numberOfTeachers: 0,
        numberOfStudents: 0,
        numberOfStaffs: 0,
        numberOfDrivers:0,
        date: DateTime.now(),
        country: selectedCountry.value,
        state: selectedState.value,
        city: selectedCity.value,
      );

      // Convert the School instance to a JSON map
      Map<String, dynamic> schoolData = school.toJson();

      FirebaseFirestore firestore = FirebaseFirestore.instance;

      await firestore.collection('schools').doc(schoolId).set(schoolData);

      clearForm();


      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
        '${schoolNameController.text} added successfully!',
      );
    } catch (e) {
      print('Error adding school: $e');
      SchoolHelperFunctions.showErrorSnackBar(
        'Error adding school. Please try again. $e',
      );
    }
  }

  void showExtracurricularActivitiesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
          title: const Text('Select Extracurricular Activities'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Class",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 18),
                ),
                const SizedBox(
                  height: SchoolSizes.md,
                ),
                OptionList(
                  options: SchoolLists.extraCurricularActivitiesList,
                  onItemSelected: (selectedItem) {
                    extraCurricularActivitiesController.text = selectedItem!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  fixedSize: const Size(double.infinity, 50)),
              onPressed: () {
                // Add your filter logic here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Apply',
                style: TextStyle(fontSize: 13),
              ),
            ),
            const SizedBox(
              height: SchoolSizes.md,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        );
      },
    );
  }

  bool isFormValid() => addSchoolFormKey.currentState?.validate() ?? false;

  void clearForm() {
    image.value = null;
    schoolNameController.clear();
    addressController.clear();
    mobileNoController.clear();
    emailController.clear();
    schoolCodeController.clear();
    affiliationController.clear();
    extraCurricularActivitiesController.clear();
    dateOfEstablishment.value = null;
    selectedExtraCurricularActivities.clear();
  }

  @override
  void onClose() {
    // Dispose of controllers
    schoolNameController.dispose();
    addressController.dispose();
    mobileNoController.dispose();
    emailController.dispose();
    schoolCodeController.dispose();
    affiliationController.dispose();
    extraCurricularActivitiesController.dispose();

    // Dispose of Rx variables
    dateOfEstablishment.close();
    selectedSchoolingSystem.close();
    selectedSchoolBoard.close();
    selectedSchoolType.close();

    super.onClose();
  }
}
