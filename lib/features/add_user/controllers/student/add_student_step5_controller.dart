import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentStep5FormController extends GetxController {
  final GlobalKey<FormState> step5FormKey = GlobalKey<FormState>();

  RxString selectedHeightFt = RxString('');
  RxString selectedHeightInch = RxString('');
  TextEditingController weightController = TextEditingController();
  RxString selectedBloodGroup = RxString('');
  RxString selectedVisionCondition = RxString('');
  RxString selectedMedicalCondition = RxString('');
  RxString isPhysicalDisability = RxString('');

  @override
  void onClose() {
    weightController.dispose();
    super.onClose();
  }

  @override
  void updateFormValidity() {
    // TODO: implement updateFormValidity
  }

  bool isFormValid() {
    return step5FormKey.currentState?.validate() ?? false;
  }
}
