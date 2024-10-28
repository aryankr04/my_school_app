import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/services/firebase_for_school.dart';

class StudentStep2FormController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();
  final step2FormKey = GlobalKey<FormState>();

  TextEditingController selectedSchoolController = TextEditingController();
  Rx<DateTime?> admissionDate = Rx<DateTime?>(null);
  Rx<String> selectedClass = Rx<String>('');
  Rx<String> selectedSection = Rx<String>('');
  TextEditingController rollNoController = TextEditingController();
  Rx<String> selectedHouseOrTeam = Rx<String>('');
  RxString isTransportRequired = RxString('');
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
    rollNoController.dispose();
    super.onClose();
  }

  @override
  void updateFormValidity() {}

  bool isFormValid() {
    return step2FormKey.currentState?.validate() ?? false;
  }
}
