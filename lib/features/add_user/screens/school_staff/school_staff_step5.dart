import 'package:flutter/material.dart';
import 'package:my_school_app/common/widgets/elevated_button.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../controllers/school_staff/add_school_staff_step5_controller.dart';

class SchoolStaffStep5Form extends StatelessWidget {
  final SchoolStaffStep5FormController controller;

  const SchoolStaffStep5Form({super.key, required this.controller});

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
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolElevatedButton(text: 'Register', onPressed: (){})
            ],
          ),
        ),
      ),
    );
  }
}
