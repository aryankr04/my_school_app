import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/services/firebase_for_school.dart';

class TeacherStep2FormController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();
  final step2FormKey = GlobalKey<FormState>();

  TextEditingController selectedSchoolController = TextEditingController();

  Rx<DateTime?> dateOfJoining = Rx<DateTime?>(null);

  Rx<String> selectedDesignation = Rx<String>('');


  RxList<String> selectedSubjectTaught = <String>[].obs;
  TextEditingController subjectTaughtController = TextEditingController();

  RxList<String> selectedSkills = <String>[].obs;
  TextEditingController skillsController= TextEditingController();

  RxList<String> selectedExtraCurricularRoles = <String>[].obs;
  TextEditingController extraCurricularRolesController= TextEditingController();

  RxString selectedVehicleNo = RxString('');
  RxString selectedModeOfTransport = RxString('');

  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;

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
    selectedSchoolController.dispose();
    super.onClose();
  }

  @override
  void updateFormValidity() {}

  bool isFormValid() {
    return step2FormKey.currentState?.validate() ?? false;
  }
}
