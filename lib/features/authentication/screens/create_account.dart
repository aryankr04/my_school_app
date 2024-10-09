import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../controllers/create_account_controller.dart';

class CreateAccount extends StatelessWidget {
  final CreateAccountController controller = Get.put(CreateAccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: SchoolSizes.lg,
            horizontal: SchoolSizes.lg,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: SchoolSizes.spaceBtwSections,
              ),
              ButtonGroup(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}

class ButtonGroup extends StatelessWidget {
  final CreateAccountController controller =
      Get.find<CreateAccountController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserTypeButton(
            icon: Icons.school, label: 'Student', userType: 'Student'),
        const SizedBox(height: SchoolSizes.defaultSpace),
        UserTypeButton(
            icon: Icons.people, label: 'Teacher', userType: 'Teacher'),
        const SizedBox(height: SchoolSizes.defaultSpace),
        UserTypeButton(
            icon: Icons.account_circle,
            label: 'Principal',
            userType: 'Principal'),
        const SizedBox(height: SchoolSizes.defaultSpace),
        UserTypeButton(
            icon: Icons.business_center,
            label: 'Director',
            userType: 'Director'),
        const SizedBox(height: SchoolSizes.defaultSpace),
        UserTypeButton(
            icon: Icons.business_center,
            label: 'Management',
            userType: 'Management'),
        const SizedBox(height: SchoolSizes.defaultSpace),
        UserTypeButton(
            icon: Icons.business_center, label: 'Staff', userType: 'Staff'),
        const SizedBox(height: SchoolSizes.defaultSpace),
        UserTypeButton(
            icon: Icons.business_center, label: 'Driver', userType: 'Driver'),
      ],
    );
  }
}

class UserTypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String userType;

  UserTypeButton({
    required this.icon,
    required this.label,
    required this.userType,
  });

  @override
  Widget build(BuildContext context) {
    final CreateAccountController controller =
        Get.find<CreateAccountController>();

    return GestureDetector(
      onTap: () {
        controller.onUserTypeSelected(userType);
      },
      child: Container(
        padding: const EdgeInsets.all(SchoolSizes.md),
        decoration: BoxDecoration(
          color: SchoolDynamicColors.backgroundColorTintDarkGrey,
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusLg),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  icon,
                  size: SchoolSizes.iconLg,
                  color: SchoolDynamicColors.primaryTextColor,
                ),
                const SizedBox(width: SchoolSizes.spaceBtwItems),
                Text(
                  label,
                  style: TextStyle(
                    color: SchoolDynamicColors.primaryTextColor,
                    fontSize: SchoolSizes.fontSizeSm,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: SchoolDynamicColors.primaryColor,
            )
          ],
        ),
      ),
    );
  }
}
