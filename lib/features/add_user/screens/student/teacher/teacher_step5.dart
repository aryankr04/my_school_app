import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../controllers/teacher/add_teacher_step4_controller.dart';
import '../../../controllers/teacher/add_teacher_step5_controller.dart';

class TeacherStep5Form extends StatelessWidget {
  final TeacherStep5FormController controller;

  const TeacherStep5Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step5FormKey,
          child: Column(
            children: <Widget>[

              SchoolTextFormField(
                labelText: 'Username',
                prefixIcon: Icons.person,
                controller: controller.usernameController,
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Password',
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: Icons.visibility_off,
                controller: controller.passwordController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
