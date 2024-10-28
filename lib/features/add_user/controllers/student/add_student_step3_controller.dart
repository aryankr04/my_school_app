import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentStep3FormController extends GetxController {
  final step3FormKey = GlobalKey<FormState>();

  final mobileNoController = TextEditingController();
  final emailAddressController = TextEditingController();
  final aadhaarNoController = TextEditingController();
  final houseAddressController = TextEditingController();
  final pinCodeController = TextEditingController();
  RxString selectedState = RxString('');
  RxString selectedDistrict = RxString('');
  RxString selectedCity = RxString('');

  @override
  void onClose() {
    mobileNoController.dispose();
    emailAddressController.dispose();
    aadhaarNoController.dispose();
    houseAddressController.dispose();
    pinCodeController.dispose();
    super.onClose();
  }


  @override
  void updateFormValidity() {
    // TODO: implement updateFormValidity
  }

  bool isFormValid() {
    return step3FormKey.currentState?.validate() ?? false;
  }
}
