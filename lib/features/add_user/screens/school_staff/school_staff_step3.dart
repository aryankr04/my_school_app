import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../../../utils/constants/lists.dart';
import '../../controllers/school_staff/add_school_staff_step3_controller.dart';

class SchoolStaffStep3Form extends StatelessWidget {
  final SchoolStaffStep3FormController controller;

  const SchoolStaffStep3Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step3FormKey,
          child: Column(
            children: <Widget>[
              Obx(() => Column(
                    children: List.generate(controller.educationEntries.length,
                        (index) {
                      final education = controller.educationEntries[index];
                      return Column(
                        key: ValueKey(education),
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${index + 1}. Education", // Display current index + 1
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              TextButton(
                                onPressed: () {
                                  index==0?SchoolHelperFunctions.showErrorSnackBar('Please enter education'):controller.removeEducationEntry(index);
                                  controller
                                      .update(); // Ensure UI updates if necessary
                                },
                                child: Text(
                                  'Remove',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                          color: SchoolDynamicColors.activeRed),
                                ),
                              ),
                            ],
                          ),
                          // Dropdown for Highest Degree
                          SchoolDropdownFormField(
                            items: SchoolLists.educationDegrees,
                            labelText: "Education",
                            isValidate: true,
                            selectedValue: education['degree'],
                            onSelected: (value) {
                              education['degree'] = value!;
                              controller
                                  .update(); // Trigger UI update on value change
                            },
                          ),
                          const SizedBox(height: SchoolSizes.defaultSpace),

                          // Text Field for University
                          SchoolTextFormField(
                            controller: education['universityController'],
                            labelText: 'University/College/School',
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'This field is required'),
                            ]),
                          ),
                          const SizedBox(height: SchoolSizes.defaultSpace),

                          SchoolTextFormField(
                            controller: education['yearController'],
                            labelText: 'Year of Completion',
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'This field is required'),
                            ]),
                          ),
                          const SizedBox(height: SchoolSizes.defaultSpace),
                        ],
                      );
                    }),
                  )),

              // Button to add new education entry
              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Add Education"),
                  onPressed: controller.addEducationEntry,
                ),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              Obx(()=>
                 Column(
                    children: List.generate(
                        controller.certificationEntries.length, (index) {
                  final certification = controller.certificationEntries[index];
                  return Column(
                    key: ValueKey(certification),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${index + 1}. Certification",
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                          TextButton(
                            onPressed: () {
                              index==0?null:controller.removeCertificationEntry(index);
                              controller.update();
                            },
                            child: Text(
                              'Remove',
                              style:
                                  Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: SchoolDynamicColors.activeRed,
                                      ),
                            ),
                          ),
                        ],
                      ),

                      // Text Field for Certification Name
                      SchoolTextFormField(
                        controller: certification['nameController'],
                        labelText: 'Certification Name',
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'This field is required'),
                        ]),
                      ),
                      const SizedBox(height: SchoolSizes.defaultSpace),

                      // Text Field for Issuing Organization
                      SchoolTextFormField(
                        controller: certification['organizationController'],
                        labelText: 'Issuing Organization',
                        keyboardType: TextInputType.text,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'This field is required'),
                        ]),
                      ),
                      const SizedBox(height: SchoolSizes.defaultSpace),

                      // Text Field for Year of Completion
                      SchoolTextFormField(
                        controller: certification['yearController'],
                        labelText: 'Year of Completion',
                        keyboardType: TextInputType.number,
                        validator: MultiValidator([
                          RequiredValidator(errorText: 'This field is required'),
                        ]),
                      ),
                      const SizedBox(height: SchoolSizes.defaultSpace),
                    ],
                  );
                })),
              ),


              Align(
                alignment: Alignment.centerRight,
                child: TextButton.icon(
                  icon: Icon(Icons.add),
                  label: Text("Add Certifiation"),
                  onPressed: controller.addCertificationEntry,
                ),
              ),

              // const SizedBox(height: SchoolSizes.defaultSpace),
              // SchoolDropdownFormField(
              //   items: SchoolLists.subjectList,
              //   labelText: "Specialization",
              //   isValidate: true,
              //   selectedValue: controller.selectedSpecialization.value,
              //   onSelected: (value) {
              //     controller.selectedSpecialization.value = value!;
              //   },
              // ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: controller.yearList,
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
