import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../controllers/student/add_student_step3_controller.dart';

class Step3Form extends StatelessWidget {
  final Step3FormController controller;

  Step3Form({Key? key, required this.controller}) : super(key: key);

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
                prefixIcon: Icons.phone_android,
                keyboardType: TextInputType.phone,
                controller: controller.mobileNoController,
                validator:MultiValidator([
                  RequiredValidator(errorText: 'Enter your email address'),
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
                 RequiredValidator(errorText: 'Enter your email address'),
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
                  RequiredValidator(errorText: 'Enter your Aadhaar No.'),
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
                validator: RequiredValidator(errorText: 'Enter House Address'),
                controller: controller.houseAddressController,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                labelText: 'State',
                items: SchoolLists.subjectList,
                selectedValue: controller.state.value,
                onSelected: (value) {
                  controller.state.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                labelText: 'District',
                items: SchoolLists.subjectList,
                selectedValue: controller.district.value,
                onSelected: (value) {
                  controller.district.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                labelText: 'City',
                items: SchoolLists.subjectList,
                selectedValue: controller.city.value,
                onSelected: (value) {
                  controller.city.value = value!;
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
