import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../../../utils/constants/lists.dart';
import '../../../controllers/teacher/add_teacher_step3_controller.dart';

class TeacherStep3Form extends StatelessWidget {
  final TeacherStep3FormController controller;

  const TeacherStep3Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step3FormKey,
          child: Column(
            children: <Widget>[

              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: "Highest Degree",
                isValidate: true,
                selectedValue: controller.selectedHighestDegree.value,
                onSelected: (value) {
                  controller.selectedHighestDegree.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              SchoolTextFormField(
                controller: controller.universityController,
                labelText: 'University',
                keyboardType: TextInputType.name,
                validator: MultiValidator([
                  RequiredValidator(errorText: ''),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              SchoolTextFormField(
                controller: controller.graduationYearController,
                labelText: 'Graduation Year',
                keyboardType: TextInputType.number,
                validator: MultiValidator([
                  RequiredValidator(errorText: ''),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: "Specialization",
                isValidate: true,
                selectedValue: controller.selectedSpecialization.value,
                onSelected: (value) {
                  controller.selectedSpecialization.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: "Teaching Experience (Years)",
                isValidate: true,
                selectedValue: controller.selectedTeachingExperience.value,
                onSelected: (value) {
                  controller.selectedTeachingExperience.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              SchoolTextFormField(
                controller: controller.previousInstitutionController,
                labelText: 'Previous Institution',
                keyboardType: TextInputType.name,
                validator: MultiValidator([
                  RequiredValidator(errorText: ''),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
