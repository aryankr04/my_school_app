import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/authentication/widgets/select_user.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';


class LoginController extends GetxController {
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  RxBool isPasswordVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }


  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    SchoolHelperFunctions.navigateToScreen(Get.context!, SelectUser());
    // Your login logic here
    // You can access and modify state variables here if needed
    print('Logging in with username: $username, password: $password');
    // Add your logic for authentication and navigation here
  }
}