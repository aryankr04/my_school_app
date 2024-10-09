import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../data/services/firebase_for_school.dart';
import '../../../../../../utils/helpers/firebase_helper_function.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../models/student.dart';
import 'add_student_step1_controller.dart';
import 'add_student_step2_controller.dart';
import 'add_student_step3_controller.dart';
import 'add_student_step4_controller.dart';
import 'add_student_step5_controller.dart';

class AddStudent0Controller extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  // Add controllers for each step
  final Step1FormController step1Controller = Step1FormController();
  final Step2FormController step2Controller = Step2FormController();
  final Step3FormController step3Controller = Step3FormController();
  final Step4FormController step4Controller = Step4FormController();
  final Step5FormController step5Controller = Step5FormController();

  RxInt activeStep = 0.obs;
  late final PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: activeStep.value);
  }

  void incrementStep() {
    print('Incrementing step');

    if (activeStep.value < 4) {
      bool isValid = false;

      switch (activeStep.value) {
        case 0:
          isValid = step1Controller.isFormValid();
          break;
        case 1:
          isValid = step2Controller.isFormValid();
          break;
        case 2:
          isValid = step3Controller.isFormValid();
          break;
        case 3:
          isValid = step4Controller.isFormValid();
          break;
        default:
          return;
      }

      if (isValid) {
        activeStep.value++;
        pageController.jumpToPage(activeStep.value);
      } else {
        // Form is not valid, handle accordingly (show an error message, etc.)
        print('Form is not valid for step $activeStep');
      }
    } else {
      print('Already at the last step.');
      addStudentToFirebase();
    }
  }

  void decrementStep() {
    print('Decrementing step');
    if (activeStep.value > 0) {
      activeStep.value--;
      pageController.jumpToPage(activeStep.value);
    }
  }

  Future<void> addStudentToFirebase() async {
    try {
      print('Sending data to Firebase...');

      SchoolHelperFunctions.showLoadingOverlay();



      // Retrieve data from each step controller
      String selectedSchool = step1Controller.selectedSchoolController.text;

      if (selectedSchool == null) {
        return;
      }

      String? studentId =
          await firebaseFunction.generateNewIdWithPrefix('STU', 'students');

      // Upload image to Firebase Storage
      String imageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: step1Controller.image.value!,
        imageName: studentId!,
        folder: 'student_profile_images',
      );

      Student student = Student(
        uid: studentId,
        schoolId: selectedSchool,
        studentName: step1Controller.studentNameController.text,
        className: step1Controller.selectedClassController.toString(),
        sectionName: step1Controller.selectedSectionController.toString(),
        rollNo: step1Controller.rollNoController.text,
        dob: step1Controller.dateOfBirth.value.toString(),
        fatherName: step1Controller.fatherNameController.text,
        motherName: step1Controller.motherNameController.text,
        heightFt: step2Controller.heightFt.value,
        heightInch: step2Controller.heightInch.value,
        weight: step2Controller.weightController.text,
        religion: step2Controller.religion.value,
        category: step2Controller.caste.value,
        gender: step2Controller.gender.value,
        bloodGroup: step2Controller.bloodGroup.value,
        mobileNo: step3Controller.mobileNoController.text,
        email: step3Controller.emailAddressController.text,
        aadhaarNo: step3Controller.aadhaarNoController.text,
        address: step3Controller.houseAddressController.text,
        state: step3Controller.state.value,
        district: step3Controller.district.value,
        city: step3Controller.city.value,
        pincode: '',
        transportation: step4Controller.transportation.value,
        vehicleNo: step4Controller.vehicleNo.value,
        favSubject: step4Controller.subject.value,
        favTeacher: step4Controller.teacher.value,
        favSports: step4Controller.sports.value,
        otherActivities: step4Controller.activities.value,
        username: step5Controller.usernameController.text,
        password: step5Controller.passwordController.text,
      );

      // Convert the Student instance to a JSON map
      Map<String, dynamic> studentData = student.toJson();
      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .set(studentData);

      SchoolHelperFunctions.showSuccessSnackBar(
        'Student added successfully!',
      );
    } catch (e) {
      print('Error adding student: $e');
      SchoolHelperFunctions.showErrorSnackBar(
        'Error adding student. Please try again.',
      );
    } finally {
      // Any final cleanup or actions can be added here
      Get.back();
    }
  }

  @override
  void onClose() {
    // Close all controllers when the widget is disposed
    step1Controller.onClose();
    step2Controller.onClose();
    step3Controller.onClose();
    step4Controller.onClose();
    step5Controller.onClose();
    super.onClose();
  }
  double ftToCm(int ft,double inch){
    double cm=((ft*12)+inch)*2.54;
    return cm;
  }


}
