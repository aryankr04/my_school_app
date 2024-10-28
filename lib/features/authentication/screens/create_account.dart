import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/add_user/screens/add_director.dart';
import 'package:my_school_app/features/add_user/screens/add_driver.dart';
import 'package:my_school_app/features/add_user/screens/add_management.dart';
import 'package:my_school_app/features/add_user/screens/add_principal.dart';
import 'package:my_school_app/features/add_user/screens/add_staff.dart';
import 'package:my_school_app/features/add_user/screens/student/student0.dart';
import 'package:my_school_app/features/user/admin/admin_main_page.dart';

import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../../add_user/screens/student/teacher/teacher0.dart';
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              ButtonGroup(),
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UserTypeButton(
              assetPath: 'assets/images/role_icon/student.svg',
              label: 'Student',
              destinationPage: AddStudent(), // Replace with your actual page widget
            ),
            UserTypeButton(
              assetPath: 'assets/images/role_icon/teacher.svg',
              label: 'Teacher',
              destinationPage: AddTeacher(), // Replace with your actual page widget
            ),
          ],
        ),
        const SizedBox(height: SchoolSizes.defaultSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UserTypeButton(
              assetPath: 'assets/images/role_icon/principal.svg',
              label: 'Principal',
              destinationPage: AddPrincipal(), // Replace with your actual page widget
            ),
            UserTypeButton(
              assetPath: 'assets/images/role_icon/director.svg',
              label: 'Director',
              destinationPage: AddDirector(), // Replace with your actual page widget
            ),
          ],
        ),
        const SizedBox(height: SchoolSizes.defaultSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UserTypeButton(
              assetPath: 'assets/images/role_icon/management.svg',
              label: 'Management',
              destinationPage: AddManagement(), // Replace with your actual page widget
            ),
            UserTypeButton(
              assetPath: 'assets/images/role_icon/staff.svg',
              label: 'Staff',
              destinationPage: AddStaff(), // Replace with your actual page widget
            ),
          ],
        ),
        const SizedBox(height: SchoolSizes.defaultSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            UserTypeButton(
              assetPath: 'assets/images/role_icon/driver.svg',
              label: 'Driver',
              destinationPage: AddDriver(), // Replace with your actual page widget
            ),
            UserTypeButton(
              assetPath: 'assets/images/role_icon/admin.svg',
              label: 'Admin',
              destinationPage: AdminHome(), // Replace with your actual page widget
            ),
          ],
        ),

      ],
    );
  }
}

class UserTypeButton extends StatelessWidget {
  final String assetPath; // Change from IconData to String for SVG path
  final String label;
  final Widget destinationPage; // New parameter for the destination page

  UserTypeButton({
    required this.assetPath, // Updated parameter name
    required this.label,
    required this.destinationPage, // Include destination page in constructor
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage), // Navigate to destinationPage
        );
      },
      child: Column(
        children: [
          Container(
            height: Get.width * 0.35,
            width: Get.width * 0.35,
            padding: const EdgeInsets.all(SchoolSizes.md),
            decoration: BoxDecoration(
              color: SchoolDynamicColors.backgroundColorTintDarkGrey,
              borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusLg),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  assetPath, // Use the assetPath instead of icon
                  height: Get.width * 0.25,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(height: SchoolSizes.sm),
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              // color: SchoolDynamicColors.activeBlue,
            ),
          ),
        ],
      ),
    );
  }
}
