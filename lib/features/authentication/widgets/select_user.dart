import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/director/main_page/0_director_main_page.dart';
import 'package:my_school_app/features/user/management/main_page/0_main_page.dart';
import 'package:my_school_app/features/user/student/main_page/0_main_page.dart';
import 'package:my_school_app/features/user/teacher/main_page/0_main_page.dart';
import '../../../utils/constants/dynamic_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../user/admin/admin_main_page.dart';
import '../screens/create_account.dart';

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

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      UserTypeButton(
                        assetPath: 'assets/images/role_icon/student.svg',
                        label: 'Student',
                        destinationPage: StudentMainPage(), // Replace with your actual page widget
                      ),
                      UserTypeButton(
                        assetPath: 'assets/images/role_icon/teacher.svg',
                        label: 'Teacher',
                        destinationPage: TeacherMainPage(), // Replace with your actual page widget
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
                        destinationPage: SelectUser(), // Replace with your actual page widget
                      ),
                      UserTypeButton(
                        assetPath: 'assets/images/role_icon/director.svg',
                        label: 'Director',
                        destinationPage: DirectorMainPage(), // Replace with your actual page widget
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
                        destinationPage: ManagementMainPage(), // Replace with your actual page widget
                      ),
                      UserTypeButton(
                        assetPath: 'assets/images/role_icon/staff.svg',
                        label: 'Staff',
                        destinationPage: SelectUser(), // Replace with your actual page widget
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
                        destinationPage: SelectUser(), // Replace with your actual page widget
                      ),
                      UserTypeButton(
                        assetPath: 'assets/images/role_icon/admin.svg',
                        label: 'Admin',
                        destinationPage: AdminHome(), // Replace with your actual page widget
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
