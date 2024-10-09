import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../controllers/student/add_student_step5_controller.dart';


class Step5Form extends StatelessWidget {
  final Step5FormController controller;

  const Step5Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step5FormKey,
          child: Column(
            children: [
              SchoolTextFormField(
                labelText: 'Username',
                prefixIcon: Icons.person,
                //validator: Validators.requiredValidator,
                controller: controller.usernameController,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                labelText: 'Password',
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                //validator: Validators.requiredValidator,
                controller: controller.passwordController,
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
