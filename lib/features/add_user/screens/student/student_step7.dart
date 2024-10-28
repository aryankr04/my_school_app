import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../common/widgets/image_picker.dart';
import '../../../../utils/constants/lists.dart';
import '../../controllers/student/add_student_step6_controller.dart';
import '../../controllers/student/add_student_step7_controller.dart';

class StudentStep7Form extends StatelessWidget {
  final StudentStep7FormController controller;

  const StudentStep7Form({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Obx(() => ImagePickerWidget(
              image: controller.profileImage.value,
              onImageSelected: controller.setPassportSizeImage,
              label: 'Profile',
            )),
            const SizedBox(height: SchoolSizes.defaultSpace),
            Obx(() => ImagePickerWidget(
                  image: controller.birthCertificateImage.value,
                  onImageSelected: controller.setBirthCertificateImage,
                  label: 'Birth Certificate',
                )),
            const SizedBox(height: SchoolSizes.defaultSpace),
            Obx(() => ImagePickerWidget(
              image: controller.transferCertificateImage.value,
              onImageSelected: controller.setTransferCertificateImage,
              label: 'Transfer Certificate',
            )),
            const SizedBox(height: SchoolSizes.defaultSpace),
            Obx(() => ImagePickerWidget(
              image: controller.aadhaarCardImage.value,
              onImageSelected: controller.setAadhaarCardImage,
              label: 'Aadhaar Card',
            )),
            const SizedBox(height: SchoolSizes.defaultSpace),

          ],
        ),
      ),
    );
  }
}
