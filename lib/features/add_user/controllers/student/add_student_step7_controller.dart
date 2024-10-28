import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentStep7FormController extends GetxController {

  Rx<File?> birthCertificateImage = Rx<File?>(null);
  Rx<File?> transferCertificateImage = Rx<File?>(null);
  Rx<File?> aadhaarCardImage = Rx<File?>(null);
  Rx<File?> profileImage = Rx<File?>(null);

  void setBirthCertificateImage(File value) {
    birthCertificateImage.value = value;
  }

  void setTransferCertificateImage(File value) {
    transferCertificateImage.value = value;
  }

  void setAadhaarCardImage(File value) {
    aadhaarCardImage.value = value;
  }

  void setPassportSizeImage(File value) {
    profileImage.value = value;
  }

  @override
  void onClose() {
    super.onClose();
  }

  bool isFormValid() {
    // Check if all required images are selected
    return birthCertificateImage.value != null &&
        transferCertificateImage.value != null &&
        aadhaarCardImage.value != null &&
        profileImage.value != null;
  }
}
