import 'package:get/get.dart';

import '../../../utils/helpers/helper_functions.dart';
import '../../add_user/screens/school_staff/school_staff0.dart';
import '../../add_user/screens/student/student0.dart';

class CreateAccountController extends GetxController {
  void onUserTypeSelected(String userType) {
    switch (userType) {
      case 'Student':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddStudent());
        break;
      case 'Teacher':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddSchoolStaff());
        break;
      case 'Principal':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddSchoolStaff());
        break;
      case 'Director':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddSchoolStaff());
        break;
      case 'Management':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddSchoolStaff());
        break;
      case 'Staff':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddSchoolStaff());
        break;
      case 'Driver':
        SchoolHelperFunctions.navigateToScreen(Get.context!, AddSchoolStaff());
        break;
    }
  }
}
