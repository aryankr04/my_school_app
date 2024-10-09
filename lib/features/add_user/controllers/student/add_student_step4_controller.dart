import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step4FormController extends GetxController {
  final step4FormKey = GlobalKey<FormState>();

  RxString transportation = RxString('');
  RxString vehicleNo = RxString('');
  RxString subject = RxString('');
  RxString teacher = RxString('');
  RxString sports = RxString('');
  RxString activities = RxString('');

  @override
  void onClose() {
    super.onClose();
  }

  @override
  void updateFormValidity() {
    // TODO: implement updateFormValidity
  }

  bool isFormValid() {
    return step4FormKey.currentState?.validate() ?? false;
  }
}
