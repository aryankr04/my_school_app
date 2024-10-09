import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step2FormController extends GetxController {
  final GlobalKey<FormState> step2FormKey = GlobalKey<FormState>();

  RxString heightFt = RxString('');
  RxString heightInch = RxString('');
  TextEditingController weightController = TextEditingController();
  RxString religion = RxString('');
  RxString caste = RxString('');
  RxString gender = RxString('');
  RxString bloodGroup = RxString('');

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
    return step2FormKey.currentState?.validate() ?? false;
  }
}
