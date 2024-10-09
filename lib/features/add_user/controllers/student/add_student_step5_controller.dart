import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Step5FormController extends GetxController {
  final step5FormKey = GlobalKey<FormState>();

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onClose() {
    // Clean up your controllers when the widget is disposed
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  @override
  void updateFormValidity() {
  }

  bool isFormValid() {
    return step5FormKey.currentState?.validate() ?? false;
  }
}
