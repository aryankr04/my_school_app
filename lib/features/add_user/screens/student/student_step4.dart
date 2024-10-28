import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/utils/constants/colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../../../../common/widgets/text_form_feild.dart';
import '../../controllers/student/add_student_step4_controller.dart';

class StudentStep4Form extends StatelessWidget {
  final StudentStep4FormController controller;

  const StudentStep4Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step4FormKey,
          child: Column(
            children: <Widget>[
              SchoolTextFormField(
                labelText: "Father's Name",
                keyboardType: TextInputType.name,
                controller: controller.fatherNameController,
                validator: RequiredValidator(errorText: ''),
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolTextFormField(
                labelText: "Father's Mobile No.",
                suffixIcon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                controller: controller.fatherMobileNoController,
                validator: MultiValidator([
                  RequiredValidator(errorText: ''),
                  LengthRangeValidator(
                      min: 10, max: 10, errorText: 'Enter valid mobile no.'),
                ]),
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolTextFormField(
                labelText: "Father's Occupation",
                keyboardType: TextInputType.name,
                controller: controller.fatherOccupationController,
                validator:
                    RequiredValidator(errorText: ""),
              ),
              const SizedBox(height: SchoolSizes.md),
              Divider(
                thickness: 0.5,
                color: SchoolColors.grey,
              ),
              const SizedBox(height: SchoolSizes.md),
              SchoolTextFormField(
                labelText: "Mother's Name",
                keyboardType: TextInputType.name,
                controller: controller.motherNameController,
                validator: RequiredValidator(errorText: ''),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: "Mother's Mobile No.",
                suffixIcon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                controller: controller.motherMobileNoController,
                validator: MultiValidator([
                  RequiredValidator(errorText: ""),
                  LengthRangeValidator(
                      min: 10, max: 10, errorText: 'Enter valid mobile no.'),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: "Mother's Occupation",
                keyboardType: TextInputType.name,
                controller: controller.motherOccupationController,
                validator:
                    RequiredValidator(errorText: ""),
              ),
              const SizedBox(height: SchoolSizes.md),
              Divider(
                thickness: 0.5,
                color: SchoolColors.grey,
              ),
              const SizedBox(height: SchoolSizes.md),
              SchoolTextFormField(
                labelText: "Guardian's Name",
                keyboardType: TextInputType.name,
                controller: controller.guardianNameController,
                validator:
                    RequiredValidator(errorText: ''),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: "Relationship to Guardian",
                keyboardType: TextInputType.name,
                controller: controller.relationshipToGuardianController,
                validator: RequiredValidator(
                    errorText: ''),
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolTextFormField(
                labelText: "Guardian's Mobile No.",
                suffixIcon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                controller: controller.guardianMobileNoController,
                validator: MultiValidator([
                  RequiredValidator(errorText: ''),
                  LengthRangeValidator(
                      min: 10, max: 10, errorText: 'Enter valid mobile no.'),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
