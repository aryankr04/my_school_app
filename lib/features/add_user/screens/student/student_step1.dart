import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../../../utils/constants/lists.dart';
import '../../controllers/student/add_student_step1_controller.dart';

class StudentStep1Form extends StatelessWidget {
  final StudentStep1FormController controller;

  const StudentStep1Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step1FormKey,
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: SchoolTextFormField(
                      labelText: 'First Name',
                      keyboardType: TextInputType.name,
                      controller: controller.firstNameController,
                      validator: RequiredValidator(errorText: ''),
                    ),
                  ),
                  SizedBox(
                    width: SchoolSizes.lg,
                  ),
                  Expanded(
                    child: SchoolTextFormField(
                      labelText: 'Last Name',
                      keyboardType: TextInputType.name,
                      controller: controller.lastNameController,
                      validator: RequiredValidator(errorText: ''),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              DatePickerField(
                initialDate: controller.dateOfBirth.value,
                onDateChanged: controller.dateOfBirth,
                firstDate: DateTime(2000),
                labelText: 'Date of Birth',
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.genderList,
                labelText: 'Gender',
                isValidate: true,
                selectedValue: controller.selectedGender.value,
                onSelected: (value) {
                  controller.selectedGender.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.genderList,
                labelText: 'Nationality',
                isValidate: true,
                selectedValue: controller.selectedNationality.value,
                onSelected: (value) {
                  controller.selectedNationality.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.religions,
                labelText: 'Religion',
                isValidate: true,
                selectedValue: controller.selectedReligion.value,
                onSelected: (value) {
                  controller.selectedReligion.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.categoryList,
                labelText: 'Category',
                isValidate: true,
                selectedValue: controller.selectedCategory.value,
                onSelected: (value) {
                  controller.selectedCategory.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                onTap: controller.showLanguagesSelectionDialog,
                readOnly: true,
                labelText: "Language Spoken",
                hintText: "Select Languages",
                keyboardType: TextInputType.name,
                controller: controller.languagesController,
                validator: RequiredValidator(errorText: ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
