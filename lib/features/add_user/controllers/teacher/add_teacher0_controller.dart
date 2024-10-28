import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/add_user/controllers/teacher/add_teacher_step1_controller.dart';

import '../../../../../../data/services/firebase_for_school.dart';
import 'add_teacher_step2_controller.dart';
import 'add_teacher_step3_controller.dart';
import 'add_teacher_step4_controller.dart';
import 'add_teacher_step5_controller.dart';

final List<String> stepNames = [
  'Introduction to Teacher Registration',
  'Basic Information',
  'Academic Information',
  'Educational Qualifications',
  'Contact Information',
  'Authentication'
];

class AddTeacher0Controller extends GetxController {
  final FirebaseForSchool firebaseFunction = FirebaseForSchool();
  final TeacherStep1FormController step1Controller =
      TeacherStep1FormController();
  final TeacherStep2FormController step2Controller =
      TeacherStep2FormController();
  final TeacherStep3FormController step3Controller =
      TeacherStep3FormController();
  final TeacherStep4FormController step4Controller =
      TeacherStep4FormController();
  final TeacherStep5FormController step5Controller =
      TeacherStep5FormController();

  RxInt activeStep = 0.obs;
  late final PageController pageController =
      PageController(initialPage: activeStep.value);

  String getStepName() => stepNames[activeStep.value] ?? 'Unknown Step';

  void incrementStep() async {
    if (activeStep.value < stepNames.length - 1) {
      bool isValid = [
        true,
        step1Controller.isFormValid(),
        step2Controller.isFormValid(),
        step3Controller.isFormValid(),
        step4Controller.isFormValid(),
        step5Controller.isFormValid(),
      ][activeStep.value];

      if (isValid) {
        activeStep.value++;
        pageController.jumpToPage(activeStep.value);
      } else {
        print('Form is not valid for step $activeStep');
      }
    } else {
      // await addStudentToFirebase();
    }
  }

  void decrementStep() {
    if (activeStep.value > 0) {
      activeStep.value--;
      pageController.jumpToPage(activeStep.value);
    }
  }

  // Future<void> addStudentToFirebase() async {
  //   try {
  //     SchoolHelperFunctions.showLoadingOverlay();
  //     String? selectedSchool = step2Controller.selectedSchoolController.text;
  //     if (selectedSchool == null) return;
  //
  //     String? studentId =
  //     await firebaseFunction.generateNewIdWithPrefix('STU', 'students');
  //     if (studentId == null) return;
  //
  //     // final profileImageUrl = await FirebaseHelperFunction.uploadImage(
  //     //   imageFile: step7Controller.profileImage.value!,
  //     //   imageName: studentId,
  //     //   folder: 'student_profile_images',
  //     // );
  //
  //
  //
  //     await FirebaseFirestore.instance
  //         .collection('students')
  //         .doc(studentId)
  //         .set(student.toJson());
  //     SchoolHelperFunctions.showSuccessSnackBar('Student added successfully!');
  //   } catch (e) {
  //     print('Error adding student: $e');
  //     SchoolHelperFunctions.showErrorSnackBar(
  //         'Error adding student. Please try again.');
  //   } finally {
  //     Get.back();
  //   }
  // }

  @override
  void onClose() {
    step1Controller.onClose();
    step2Controller.onClose();
    step3Controller.onClose();
    step4Controller.onClose();
    step5Controller.onClose();

    super.onClose();
  }

  double ftToCm(int ft, double inch) => ((ft * 12) + inch) * 2.54;
}
