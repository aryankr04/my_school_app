
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/text_form_feild.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/dynamic_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../user/admin/admin_main_page.dart';
import '../controllers/login_controller.dart';
import 'create_account.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Start point

    // First wave trough
    path.quadraticBezierTo(
      size.width * 0.25, size.height - 80, // Control point for peak
      size.width * 0.5, size.height - 40, // End point (trough)
    );

    // Second wave trough
    path.quadraticBezierTo(
      size.width * 0.75, size.height, // Control point for peak
      size.width, size.height - 40, // End point (trough)
    );

    path.lineTo(size.width, 0); // Right edge
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            flex: 1,
            child: ClipPath(
              clipper: BottomWaveClipper(),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff1191FD), Color(0xff5E59F2)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 3,
                        offset: const Offset(0, 3),
                      )
                    ]),
                // height: Get.width * 1.1,
                width: Get.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/logos/csd.png'),
                    ),
                    SizedBox(
                      height: SchoolSizes.md,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text('Cambridge School Dumraon',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium
                                ?.copyWith(
                                    color: SchoolDynamicColors
                                        .whiteTextColor,
                                    fontSize: 26))),
                  ],
                ),
              ),
            ),
          ),

          // TextButton(onPressed: (){SchoolHelperFunctions.navigateToScreen(context, AdminHome());}, child: Text('Admin')),

          Container(
            padding: EdgeInsets.only(
                left: SchoolSizes.lg,
                right: SchoolSizes.lg,
                bottom: SchoolSizes.lg),
            // decoration: BoxDecoration(
            //   color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
            //   borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
            //   border:
            //   Border.all(width: .5, color: SchoolDynamicColors.borderColor),
            //   boxShadow: [
            //     BoxShadow(
            //       color: Colors.black.withOpacity(0.1),
            //       spreadRadius: 1,
            //       blurRadius: 3,
            //       offset: const Offset(0, 3),
            //     ),
            //   ],
            // ),
            child: Column(
              children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Login',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(fontSize: 28))),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                      'Enter your username & password to login.',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                              color: SchoolColors.subtitleTextColor)),
                ),
                const SizedBox(
                  height: SchoolSizes.lg,
                ),
                SchoolTextFormField(
                  labelText: 'Username',
                  prefixIcon: Icons.person,
                  controller: loginController.usernameController,
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  labelText: 'Password',
                  prefixIcon: Icons.lock,
                  suffixIcon: Icons.remove_red_eye,
                  obscureText: true,
                  controller: loginController.passwordController,
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(
                              color: SchoolDynamicColors.primaryColor,
                              fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const SizedBox(
                  height: SchoolSizes.spaceBtwItems,
                ),
                ElevatedButton(
                  onPressed: () {
                    loginController.login();
                  },
                  child: const Text('Login'),
                ),
                const SizedBox(
                  height: SchoolSizes.lg,
                ),
                OutlinedButton(
                    onPressed: () {
                      SchoolHelperFunctions.navigateToScreen(
                          context, CreateAccount());
                    },
                    child: Text('Create Account')),
                // const SizedBox(
                //   height: SchoolSizes.defaultSpace / 2,
                // ),
                // Text(
                //   "---------- or ----------",
                //   style: Theme.of(context).textTheme.bodySmall,
                // ),
                // const SizedBox(
                //   height: SchoolSizes.defaultSpace / 2,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       "Don't have an account ? ",
                //       style: Theme.of(context).textTheme.labelMedium,
                //     ),
                //     InkWell(
                //       onTap: () {
                //         SchoolHelperFunctions.navigateToScreen(
                //             context, CreateAccount());
                //       },
                //       child: Text(
                //         "Create Account ",
                //         style: Theme.of(context)
                //             .textTheme
                //             .bodySmall
                //             ?.copyWith(
                //                 color: SchoolDynamicColors.primaryColor),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
