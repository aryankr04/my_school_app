import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../data/services/firebase_for_school.dart';
import '../../../../../../utils/helpers/firebase_helper_function.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../models/student.dart';
import 'add_student_step1_controller.dart';
import 'add_student_step5_controller.dart';
import 'add_student_step3_controller.dart';
import 'add_student_step4_controller.dart';
import 'add_student_step2_controller.dart';
import 'add_student_step6_controller.dart';
import 'add_student_step7_controller.dart';
import 'add_student_step8_controller.dart';

final List<String> stepNames = [
  'Introduction to Student Registration',
  'Basic Information',
  'Academic Information',
  'Contact Information',
  'Parental/Guardian Information',
  'Physical and Health Information',
  'Favorites and Personal Interests',
  'Document Uploads',
  'Authentication'
];

class AddStudent0Controller extends GetxController {
  final FirebaseForSchool firebaseFunction = FirebaseForSchool();
  final StudentStep1FormController step1Controller = StudentStep1FormController();
  final StudentStep2FormController step2Controller = StudentStep2FormController();
  final StudentStep3FormController step3Controller = StudentStep3FormController();
  final StudentStep4FormController step4Controller = StudentStep4FormController();
  final StudentStep5FormController step5Controller = StudentStep5FormController();
  final StudentStep6FormController step6Controller = StudentStep6FormController();
  final StudentStep7FormController step7Controller = StudentStep7FormController();
  final StudentStep8FormController step8Controller = StudentStep8FormController();

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
        step6Controller.isFormValid(),
        step7Controller.isFormValid(),
      ][activeStep.value];

      if (isValid) {
        activeStep.value++;
        pageController.jumpToPage(activeStep.value);
      } else {
        print('Form is not valid for step $activeStep');
      }
    } else {
      await addStudentToFirebase();
    }
  }

  void decrementStep() {
    if (activeStep.value > 0) {
      activeStep.value--;
      pageController.jumpToPage(activeStep.value);
    }
  }

  Future<void> addStudentToFirebase() async {
    try {
      SchoolHelperFunctions.showLoadingOverlay();
      String? selectedSchool = step2Controller.selectedSchoolController.text;
      if (selectedSchool == null) return;

      String? studentId =
          await firebaseFunction.generateNewIdWithPrefix('STU', 'students');
      if (studentId == null) return;

      final profileImageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: step7Controller.profileImage.value!,
        imageName: studentId,
        folder: 'student_profile_images',
      );

      final birthCertificateImageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: step7Controller.birthCertificateImage.value!,
        imageName: studentId,
        folder: 'student_birth_certificate_images',
      );

      final transferCertificateImageUrl =
          await FirebaseHelperFunction.uploadImage(
        imageFile: step7Controller.transferCertificateImage.value!,
        imageName: studentId,
        folder: 'student_transfer_certificate_images',
      );

      final aadhaarCardImageUrl = await FirebaseHelperFunction.uploadImage(
        imageFile: step7Controller.aadhaarCardImage.value!,
        imageName: studentId,
        folder: 'student_aadhaar_card_images',
      );

      final student = Student(
        uid: studentId,
        role: 'student',
        schoolId: selectedSchool,
        studentName:
            '${step1Controller.firstNameController.text.trim()} ${step1Controller.lastNameController.text.trim()}',
        firstName: step1Controller.firstNameController.text.trim(),
        lastName: step1Controller.lastNameController.text.trim(),
        admissionDate: step2Controller.admissionDate.value.toString().trim(),
        admissionNo: '',
        className: step2Controller.selectedClass.toString().trim(),
        sectionName: step2Controller.selectedSection.toString().trim(),
        rollNo: step2Controller.rollNoController.text.trim(),
        dob: step1Controller.dateOfBirth.value.toString().trim(),
        fatherName: step4Controller.fatherNameController.text.trim(),
        fatherMobileNo: step4Controller.fatherMobileNoController.text.trim(),
        fatherOccupation:
            step4Controller.fatherOccupationController.text.trim(),
        motherName: step4Controller.motherNameController.text.trim(),
        motherMobileNo: step4Controller.motherMobileNoController.text.trim(),
        motherOccupation:
            step4Controller.motherOccupationController.text.trim(),
        nationality: step1Controller.selectedNationality.value.trim(),
        heightFt: step5Controller.selectedHeightFt.value.trim(),
        heightInch: step5Controller.selectedHeightInch.value.trim(),
        weight: step5Controller.weightController.text.trim(),
        visionCondition: step5Controller.selectedVisionCondition.value.trim(),
        medicalCondition: step5Controller.selectedMedicalCondition.value.trim(),
        isPhysicalDisability:
            step5Controller.isPhysicalDisability.value.trim() == 'Yes',
        religion: step1Controller.selectedReligion.value.trim(),
        category: step1Controller.selectedCategory.value.trim(),
        gender: step1Controller.selectedGender.value.trim(),
        bloodGroup: step5Controller.selectedBloodGroup.value.trim(),
        mobileNo: step3Controller.mobileNoController.text.trim(),
        email: step3Controller.emailAddressController.text.trim(),
        aadhaarNo: step3Controller.aadhaarNoController.text.trim(),
        address: step3Controller.houseAddressController.text.trim(),
        state: step3Controller.selectedState.value.trim(),
        district: step3Controller.selectedDistrict.value.trim(),
        city: step3Controller.selectedCity.value.trim(),
        pincode: step3Controller.pinCodeController.value.toString().trim(),
        isTransportRequired:
            step2Controller.isTransportRequired.value.trim() == 'Yes',
        modeOfTransportation:
            step2Controller.selectedModeOfTransport.value.trim(),
        vehicleNo: step2Controller.selectedVehicleNo.value.trim(),
        houseOrTeam: step2Controller.selectedHouseOrTeam.value.trim(),
        favSubject: step6Controller.selectedFavoriteSubject.value.trim(),
        favTeacher: step6Controller.selectedFavoriteTeacher.value.trim(),
        favSports: step6Controller.selectedFavoriteSport.value.trim(),
        favFood: step6Controller.favoriteFoodController.value.toString().trim(),
        hobbies: step6Controller.selectedHobbies.value,
        goal: step6Controller.goalController.text.trim(),
        username: step8Controller.usernameController.text.trim(),
        password: step8Controller.passwordController.text.trim(),
        profileImageUrl: profileImageUrl,
        birthCertificateImageUrl: birthCertificateImageUrl,
        transferCertificateImageUrl: transferCertificateImageUrl,
        aadhaarCardImageUrl: aadhaarCardImageUrl,
        isActive: true,
        accountStatus: 'active',
        lastLogin: DateTime.now(),
        createdAt: DateTime.now(),
        followers: [],
        following: [],
        noOfPosts: 0,
        totalPoints: 0,
        classRank: 0,
        schoolRank: 0,
        allIndiaRank: 0,
        totalPresent: 0,
        totalAbsent: 0,
        totalDueFee: 0,
      );

      await FirebaseFirestore.instance
          .collection('students')
          .doc(studentId)
          .set(student.toJson());
      SchoolHelperFunctions.showSuccessSnackBar('Student added successfully!');
    } catch (e) {
      print('Error adding student: $e');
      SchoolHelperFunctions.showErrorSnackBar(
          'Error adding student. Please try again.');
    } finally {
      Get.back();
    }
  }

  @override
  void onClose() {
    step1Controller.onClose();
    step2Controller.onClose();
    step3Controller.onClose();
    step4Controller.onClose();
    step5Controller.onClose();
    step6Controller.onClose();
    step7Controller.onClose();
    step8Controller.onClose();
    super.onClose();
  }

  double ftToCm(int ft, double inch) => ((ft * 12) + inch) * 2.54;
}
