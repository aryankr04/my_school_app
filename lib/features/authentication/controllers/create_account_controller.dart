import 'package:get/get.dart';

import '../../../utils/helpers/helper_functions.dart';
import 'package:my_school_app/features/add_user/screens/add_driver.dart';
import 'package:my_school_app/features/add_user/screens/add_staff.dart';

import '../../add_user/screens/add_director.dart';
import '../../add_user/screens/add_management.dart';
import '../../add_user/screens/add_principal.dart';
import '../../add_user/screens/student/student0.dart';
import '../../add_user/screens/student/teacher/teacher0.dart';

class CreateAccountController extends GetxController {
  void onUserTypeSelected(String userType) {
    switch (userType) {
      case 'Student':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddStudent());
        break;
      case 'Teacher':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddTeacher());
        break;
      case 'Principal':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddPrincipal());
        break;
      case 'Director':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddDirector());
        break;
      case 'Management':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddManagement());
        break;
      case 'Staff':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddStaff());
        break;
      case 'Driver':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddDriver());
        break;
    }
  }
}
