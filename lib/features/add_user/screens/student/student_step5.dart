import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../controllers/student/add_student_step5_controller.dart';

class StudentStep5Form extends StatelessWidget {
  final StudentStep5FormController controller;

  const StudentStep5Form({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step5FormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.heightFtList,
                      labelText: 'Height (Feet)',
                      hintText: 'Select Feet',
                      isValidate: true,
                      selectedValue: controller.selectedHeightFt.value,
                      onSelected: (value) {
                        controller.selectedHeightFt.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: SchoolSizes.defaultSpace,
                  ),
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.heightInchList,
                      labelText: 'Height(Inch)',
                      hintText: 'Select Inch',
                      isValidate: true,
                      selectedValue: controller.selectedHeightInch.value,
                      onSelected: (value) {
                        controller.selectedHeightInch.value = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                validator: RequiredValidator(errorText: 'Enter Weight'),
                labelText: 'Weight',
                suffixText: 'Kg',
                keyboardType: TextInputType.number,
                controller: controller.weightController,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.bloodGroupList,
                labelText: 'Blood Group',
                isValidate: true,
                selectedValue: controller.selectedBloodGroup.value,
                onSelected: (value) {
                  controller.selectedBloodGroup.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.visionConditionList,
                labelText: 'Vision Condition',
                isValidate: true,
                selectedValue: controller.selectedVisionCondition.value,
                onSelected: (value) {
                  controller.selectedVisionCondition.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.medicalConditions,
                labelText: 'Medical Conditions',
                isValidate: true,
                selectedValue: controller.selectedVisionCondition.value,
                onSelected: (value) {
                  controller.selectedMedicalCondition.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.yesNoList,
                labelText: 'Physical Disability',
                hintText: 'Select Yes or No',
                isValidate: true,
                selectedValue: controller.isPhysicalDisability.value,
                onSelected: (value) {
                  controller.isPhysicalDisability.value = value!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
