import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../controllers/student/add_student_step3_controller.dart';

class StudentStep3Form extends StatelessWidget {
  final StudentStep3FormController controller;

  StudentStep3Form({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step3FormKey,
          child: Column(
            children: <Widget>[
              SchoolTextFormField(
                labelText: 'Mobile No.',
                suffixIcon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                controller: controller.mobileNoController,
                validator:MultiValidator([
                  RequiredValidator(errorText: ''),
                  LengthRangeValidator(min: 10,max: 10,
                      errorText: 'Enter valid mobile no.'),
                ]) ,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),

              SchoolTextFormField(
                labelText: 'Email Address',
                keyboardType: TextInputType.emailAddress,
                controller: controller.emailAddressController,
                validator: MultiValidator([
                 RequiredValidator(errorText: ''),
                  EmailValidator(
                       errorText: 'Enter valid email address'),
                ]),
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                labelText: 'Aadhaar No.',
                keyboardType: TextInputType.number,
                validator: MultiValidator([
                  RequiredValidator(errorText: ''),
                  LengthRangeValidator(
                      max: 12, min: 12, errorText: 'Enter valid Aadhaar No.'),
                ]),
                controller: controller.aadhaarNoController,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                labelText: 'House Address',
                validator: RequiredValidator(errorText: ''),
                controller: controller.houseAddressController,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                labelText: 'Pin Code',
                validator: RequiredValidator(errorText: ''),
                controller: controller.houseAddressController,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                labelText: 'State/Union Territories',
                items: SchoolLists.indianStatesAndUTs,
                selectedValue: controller.selectedState.value,
                isValidate: true,
                onSelected: (value) {
                  controller.selectedState.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                labelText: 'District',
                items: SchoolLists.indianStatesAndUTs,
                isValidate: true,
                selectedValue: controller.selectedDistrict.value,
                onSelected: (value) {
                  controller.selectedDistrict.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                labelText: 'City',
                items: SchoolLists.indianStatesAndUTs,
                selectedValue: controller.selectedCity.value,
                onSelected: (value) {
                  controller.selectedCity.value = value!;
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
