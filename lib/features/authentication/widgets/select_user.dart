import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/director/main_page/0_director_main_page.dart';
import 'package:my_school_app/features/user/management/main_page/0_main_page.dart';
import 'package:my_school_app/features/user/student/main_page/0_main_page.dart';
import 'package:my_school_app/features/user/teacher/main_page/0_main_page.dart';
import '../../../utils/constants/dynamic_colors.dart';
import '../../../utils/constants/sizes.dart';

class SelectUser extends StatelessWidget {
  const SelectUser({super.key});

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
              UserTypeButton(
                  icon: Icons.school, label: 'Student', destinationPage: StudentMainPage(),),
              const SizedBox(height: SchoolSizes.defaultSpace),
              UserTypeButton(
                  icon: Icons.people, label: 'Teacher', destinationPage: TeacherMainPage(),),
              const SizedBox(height: SchoolSizes.defaultSpace),
              UserTypeButton(
                  icon: Icons.account_circle,
                  label: 'Principal',
                  destinationPage: SelectUser(),),
              const SizedBox(height: SchoolSizes.defaultSpace),
              UserTypeButton(
                  icon: Icons.business_center,
                  label: 'Director',
                  destinationPage: DirectorMainPage(),),
              const SizedBox(height: SchoolSizes.defaultSpace),
              UserTypeButton(
                  icon: Icons.business_center,
                  label: 'Management',
                  destinationPage: ManagementMainPage(),),
              const SizedBox(height: SchoolSizes.defaultSpace),
              UserTypeButton(
                  icon: Icons.business_center, label: 'Staff', destinationPage: SelectUser(),),
              const SizedBox(height: SchoolSizes.defaultSpace),
              UserTypeButton(
                  icon: Icons.business_center, label: 'Driver', destinationPage: SelectUser()),              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
class UserTypeButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget destinationPage; // Updated userType to destinationPage

  UserTypeButton({
    required this.icon,
    required this.label,
    required this.destinationPage,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destinationPage),
        );
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
                  size: 24.0,
                  color: SchoolDynamicColors.primaryTextColor,
                ),
                const SizedBox(width: 8.0),
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
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}