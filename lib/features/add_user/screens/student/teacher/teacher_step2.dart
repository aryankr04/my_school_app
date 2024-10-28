import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../../../utils/constants/lists.dart';
import '../../../controllers/teacher/add_teacher_step2_controller.dart';

class TeacherStep2Form extends StatelessWidget {
  final TeacherStep2FormController controller;

  const TeacherStep2Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step2FormKey,
          child: Column(
            children: <Widget>[
              DatePickerField(
                initialDate: controller.dateOfJoining.value,
                onDateChanged: controller.dateOfJoining,
                firstDate: DateTime(2000),
                labelText: 'Date of Joining',
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: 'Designation',
                isValidate: true,
                selectedValue: controller.selectedDesignation.value,
                onSelected: (value) {
                  controller.selectedDesignation.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                // onTap: controller.showLanguagesSelectionDialog,
                readOnly: true,
                labelText: "Subject Taught",
                hintText: "Select Subjects",
                keyboardType: TextInputType.name,
                controller: controller.subjectTaughtController,
                validator: RequiredValidator(errorText: ''),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                // onTap: controller.showLanguagesSelectionDialog,
                readOnly: true,
                labelText: "Skills",
                keyboardType: TextInputType.name,
                controller: controller.skillsController,
                validator: RequiredValidator(errorText: ''),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                // onTap: controller.showLanguagesSelectionDialog,
                readOnly: true,
                labelText: "Extra Curricular Roles",
                hintText: "Select Languages",
                keyboardType: TextInputType.name,
                controller: controller.extraCurricularRolesController,
                validator: RequiredValidator(errorText: ''),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: "Mode of Transport",
                isValidate: true,
                selectedValue: controller.selectedModeOfTransport.value,
                onSelected: (value) {
                  controller.selectedModeOfTransport.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: "Vehicle No",
                isValidate: true,
                selectedValue: controller.selectedVehicleNo.value,
                onSelected: (value) {
                  controller.selectedVehicleNo.value = value!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
