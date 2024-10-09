import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../../common/widgets/elevated_button.dart';
import '../../../../../common/widgets/text_form_feild.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/date_picker.dart';
import '../../../../../utils/constants/lists.dart';

import 'package:get/get.dart';

import '../../../common/widgets/image_picker.dart';
import '../controllers/add_school_controller.dart';


class AddSchool extends StatelessWidget {
  final AddSchoolController controller = Get.put(AddSchoolController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add School'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Form(
            key: controller.addSchoolFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImagePickerWidget(
                  image: controller.image.value,
                  onImageSelected: (File value) {
                    controller.image.value = value;
                  },
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  labelText: 'School Name',
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.name,
                  controller: controller.schoolNameController,
                  validator: RequiredValidator(
                    errorText: 'Please enter school name',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                DatePickerField(
                  initialDate: controller.dateOfEstablishment.value,
                  onDateChanged: (date) {
                    controller.dateOfEstablishment.value = date;
                  },
                  firstDate: DateTime(1900),
                  labelText: 'Date of Establishment',
                  lastDate: DateTime.now(),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  labelText: 'Address',
                  prefixIcon: Icons.pin_drop,
                  keyboardType: TextInputType.streetAddress,
                  controller: controller.addressController,
                  validator: RequiredValidator(
                    errorText: 'Please enter address',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  labelText: 'Mobile No.',
                  prefixIcon: Icons.phone_android_rounded,
                  keyboardType: TextInputType.phone,
                  controller: controller.mobileNoController,
                  validator: RequiredValidator(
                    errorText: 'Please enter mobile no.',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  labelText: 'Email',
                  prefixIcon: Icons.email_rounded,
                  keyboardType: TextInputType.emailAddress,
                  controller: controller.emailController,
                  validator: RequiredValidator(
                    errorText: 'Please enter email address',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                // ... (add other text form fields as needed)
                SchoolTextFormField(
                  labelText: 'School Code',
                  prefixIcon: Icons.numbers,
                  keyboardType: TextInputType.number,
                  controller: controller.schoolCodeController,
                  validator: RequiredValidator(
                    errorText: 'Please enter school code',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolDropdownFormField(
                  labelText: "Schooling System",
                  items: SchoolLists.schoolingSystemList,
                  onSelected: (val) {
                    controller.selectedSchoolingSystem.value = val;
                  },
                  selectedValue: controller.selectedSchoolingSystem.value,
                  validator: RequiredValidator(
                    errorText: 'Select Schooling System',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolDropdownFormField(
                  labelText: 'School Board',
                  items: SchoolLists.schoolBoardList,
                  onSelected: (val) {
                    controller.selectedSchoolBoard.value = val;
                  },
                  selectedValue: controller.selectedSchoolBoard.value,
                  validator: RequiredValidator(
                    errorText: 'Select School Board',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolDropdownFormField(
                  labelText: 'Type',
                  items: SchoolLists.schoolTypeList,
                  onSelected: (val) {
                    controller.selectedSchoolType.value = val;
                  },
                  selectedValue: controller.selectedSchoolType.value,
                  validator: RequiredValidator(
                    errorText: 'Select School Type',
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  labelText: 'Affiliation (Optional)',
                  keyboardType: TextInputType.name,
                  controller: controller.affiliationController,
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  controller: controller.extraCurricularActivitiesController,
                  labelText: 'Extracurricular Activities',
                  keyboardType: TextInputType.text,
                  onTap: () {
                    controller.showExtracurricularActivitiesDialog(context);
                  },
                  readOnly: true,
                ),
                const SizedBox(height: SchoolSizes.defaultSpace),
                SchoolElevatedButton(
                  onPressed: () => controller.isFormValid()
                      ? controller.addSchoolToFirebase()
                      : controller.addSchoolToFirebase(),
                  text: 'Add',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
