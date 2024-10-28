import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../controllers/teacher/add_teacher_step4_controller.dart';

class TeacherStep4Form extends StatelessWidget {
  final TeacherStep4FormController controller;

  const TeacherStep4Form({super.key, required this.controller});

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
                controller: controller.mobileNoController,
                labelText: 'Mobile No.',
                keyboardType: TextInputType.phone,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please enter mobile number'),
                  LengthRangeValidator(
                    min: 10,
                    max: 10,
                    errorText: 'Please enter 10-digit mobile no.',
                  ),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                controller: controller.addressController,
                labelText: 'Address',
                keyboardType: TextInputType.streetAddress,
                validator: RequiredValidator(errorText: 'Please enter address'),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                controller: controller.emailAddressController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator:
                EmailValidator(errorText: 'Please enter a valid email'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
