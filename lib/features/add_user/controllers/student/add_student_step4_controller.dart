import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentStep4FormController extends GetxController {
  final step4FormKey = GlobalKey<FormState>();

  TextEditingController fatherNameController = TextEditingController();
  TextEditingController fatherMobileNoController = TextEditingController();
  TextEditingController fatherOccupationController = TextEditingController();

  TextEditingController motherNameController = TextEditingController();
  TextEditingController motherMobileNoController = TextEditingController();
  TextEditingController motherOccupationController = TextEditingController();

  TextEditingController guardianNameController = TextEditingController();
  TextEditingController guardianMobileNoController = TextEditingController();
  TextEditingController relationshipToGuardianController = TextEditingController();

  @override
  void onClose() {
    super.onClose();
    fatherNameController.dispose();
    motherNameController.dispose();
  }

  @override
  void updateFormValidity() {
    // TODO: implement updateFormValidity
  }

  bool isFormValid() {
    return step4FormKey.currentState?.validate() ?? false;
  }
}
