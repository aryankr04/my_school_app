import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../controllers/student/add_student_step2_controller.dart';

class Step2Form extends StatelessWidget {
  final Step2FormController controller;

  const Step2Form({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step2FormKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Height', style: Theme.of(context).textTheme.labelLarge?.copyWith(fontSize: 14),),
              SizedBox(height: 8,),
              Row(
                children: [
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.heightFtList,
                      suffixText: 'Ft',
                      labelText: 'Feet',
                      validator: RequiredValidator(errorText: 'Select Feet'),
                      selectedValue: controller.heightFt.value,
                      onSelected: (value) {
                        controller.heightFt.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: SchoolSizes.defaultSpace,
                  ),
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.heightFtList,
                      suffixText: 'In',
                      labelText: 'Inch',
                      validator: RequiredValidator(errorText: 'Select Inch'),
                      selectedValue: controller.heightInch.value,
                      onSelected: (value) {
                        controller.heightInch.value = value!;
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
                items: SchoolLists.religionList,
                labelText: 'Religion',
                validator: RequiredValidator(errorText: 'Select Religion'),
                selectedValue: controller.religion.value,
                onSelected: (value) {
                  controller.religion.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.casteList,
                labelText: 'Caste',
                validator: RequiredValidator(errorText: 'Select Caste'),
                selectedValue: controller.caste.value,
                onSelected: (value) {
                  controller.caste.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.genderList,
                labelText: 'Gender',
                prefixIcon: Icons.transgender,
                validator: RequiredValidator(errorText: 'Select Gender'),
                selectedValue: controller.gender.value,
                onSelected: (value) {
                  controller.gender.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.bloodGroupList,
                labelText: 'Blood Group',
                validator: RequiredValidator(errorText: 'Select Blood Group'),
                selectedValue: controller.bloodGroup.value,
                onSelected: (value) {
                  controller.bloodGroup.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
