import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/services/firebase_for_school.dart';

class TeacherStep3FormController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();
  final step3FormKey = GlobalKey<FormState>();


  Rx<DateTime?> dateOfJoining = Rx<DateTime?>(null);

  Rx<String> selectedHighestDegree = Rx<String>('');
  TextEditingController universityController = TextEditingController();
  TextEditingController graduationYearController = TextEditingController();
  Rx<String> selectedSpecialization = Rx<String>('');
  Rx<String> selectedTeachingExperience = Rx<String>('');
  TextEditingController previousInstitutionController = TextEditingController();




  @override
  void onClose() {
    super.onClose();
  }

  @override
  void updateFormValidity() {}

  bool isFormValid() {
    return step3FormKey.currentState?.validate() ?? false;
  }
}
