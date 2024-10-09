// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:my_school_app/features/user/director/main_page/profile/profile.dart';
// import 'package:my_school_app/features/user/student/main_page/home/home.dart';
// import 'package:my_school_app/utils/constants/colors.dart';
// import 'package:wave/config.dart';
// import 'package:wave/wave.dart';
//
// import '../../../common/widgets/text_form_feild.dart';
// import '../../../utils/constants/dynamic_colors.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/helpers/helper_functions.dart';
// import '../../user/admin/admin_main_page.dart';
// import '../controllers/login_controller.dart';
// import 'create_account.dart';
//
//
// class WaveClipper extends CustomClipper<Path> {
//   final double offset;
//
//   WaveClipper({this.offset = 0.0});
//
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     path.lineTo(0, size.height * 0.75 + offset);
//
//     double waveWidth = size.width / 4;
//     double waveHeight = size.height * 0.1;
//
//     for (double x = 0; x < size.width; x += waveWidth) {
//       path.quadraticBezierTo(
//         x + waveWidth / 4, size.height * 0.75 + waveHeight + offset,
//         x + waveWidth / 2, size.height * 0.75 + offset,
//       );
//       path.quadraticBezierTo(
//         x + 3 * waveWidth / 4, size.height * 0.75 - waveHeight + offset,
//         x + waveWidth, size.height * 0.75 + offset,
//       );
//     }
//
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();
//
//     return path;
//   }
//
//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }
//
// class OverlappingWavesWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           height: 300,
//           decoration: BoxDecoration(
//             gradient: LinearGradient(
//               colors: [Color(0xff1191FD), Color(0xff5E59F2)],
//             ),
//           ),
//         ),
//         ClipPath(
//           clipper: WaveClipper(),
//           child: Container(
//             height: 350,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.black.withOpacity(0.3),
//                   spreadRadius: 5,
//                   blurRadius: 7,
//                   offset: Offset(0, 3),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
// class Login extends StatelessWidget {
//   Login({super.key});
//
//   final LoginController loginController = Get.put(LoginController());
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         alignment: Alignment.bottomCenter,
//         decoration: BoxDecoration(
//             //gradient: LinearGradient(colors: [Color(0xff1191FD),Color(0xff5E59F2)])
//             ),
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               SvgPicture.asset(
//                 'assets/images/banners/login_bg.svg',
//                 height: 400.0,
//                 width: double.infinity,
//                 fit: BoxFit.fitWidth,
//               ),              Container(height: 300,width: double.infinity,color: SchoolColors.white,),
//               CircleAvatar(
//                 radius: 60,
//                 backgroundImage: AssetImage('assets/logos/csd.png'),
//               ),
//               // SvgPicture.asset('assets/images/illustration/tablet_login_rafiki.svg',height: Get.width*0.75,width: Get.width*0.75,),
//               SizedBox(
//                 height: SchoolSizes.md,
//               ),
//               Align(
//                   alignment: Alignment.center,
//                   child: Text('Cambridge School Dumraon',
//                       style: Theme.of(context)
//                           .textTheme
//                           .headlineMedium
//                           ?.copyWith(
//                               color: SchoolDynamicColors.headlineTextColor,
//                               fontWeight: FontWeight.w700))),
//               // const SizedBox(
//               //   height: 120,
//               // ),
//               TextButton(
//                   onPressed: () {
//                     SchoolHelperFunctions.navigateToScreen(
//                         context, AdminHome());
//                   },
//                   child: Text('Admin')),
//
//               Container(
//                 padding: EdgeInsets.all(SchoolSizes.md),
//                 // decoration: BoxDecoration(
//                 //   color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
//                 //   borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
//                 //   border:
//                 //   Border.all(width: .5, color: SchoolDynamicColors.borderColor),
//                 //   boxShadow: [
//                 //     BoxShadow(
//                 //       color: Colors.black.withOpacity(0.1),
//                 //       spreadRadius: 1,
//                 //       blurRadius: 3,
//                 //       offset: const Offset(0, 3),
//                 //     ),
//                 //   ],
//                 // ),
//                 child: Column(
//                   children: [
//                     Align(
//                         alignment: Alignment.centerLeft,
//                         child: Text("Let's Sign in",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .headlineMedium
//                                 ?.copyWith(
//                                     fontSize: 26,
//                                     fontWeight: FontWeight.w700))),
//                     // Align(
//                     //   alignment: Alignment.centerLeft,
//                     //   child: Text('Enter your username & password',
//                     //       style: Theme.of(context)
//                     //           .textTheme
//                     //           .bodySmall
//                     //           ?.copyWith(color: SchoolColors.textDisable)),
//                     // ),
//
//                     const SizedBox(
//                       height: SchoolSizes.lg,
//                     ),
//                     SchoolTextFormField(
//                       labelText: 'Username',
//                       prefixIcon: Icons.person,
//                       controller: loginController.usernameController,
//                     ),
//                     const SizedBox(
//                       height: SchoolSizes.defaultSpace,
//                     ),
//                     SchoolTextFormField(
//                       labelText: 'Password',
//                       prefixIcon: Icons.lock,
//                       suffixIcon: Icons.remove_red_eye,
//                       obscureText: true,
//                       controller: loginController.passwordController,
//                     ),
//                     Align(
//                       alignment: AlignmentDirectional.centerStart,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: Text(
//                           'Forgot Password',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodySmall
//                               ?.copyWith(
//                                   color: SchoolDynamicColors.primaryColor,
//                                   fontWeight: FontWeight.w600),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: SchoolSizes.spaceBtwItems,
//                     ),
//                     ElevatedButton(
//                       onPressed: () {
//                         loginController.login();
//                       },
//                       child: const Text('Login'),
//                     ),
//                     const SizedBox(
//                       height: SchoolSizes.defaultSpace / 2,
//                     ),
//                     Text(
//                       "---------- or ----------",
//                       style: Theme.of(context).textTheme.bodySmall,
//                     ),
//                     const SizedBox(
//                       height: SchoolSizes.defaultSpace / 2,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           "Don't have an account ? ",
//                           style: Theme.of(context).textTheme.labelMedium,
//                         ),
//                         InkWell(
//                           onTap: () {
//                             SchoolHelperFunctions.navigateToScreen(
//                                 context, CreateAccount());
//                           },
//                           child: Text(
//                             "Create Account ",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .bodySmall
//                                 ?.copyWith(
//                                     color: SchoolDynamicColors.primaryColor),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//




import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../common/widgets/text_form_feild.dart';
import '../../../utils/constants/dynamic_colors.dart';
import '../../../utils/constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../../user/admin/admin_main_page.dart';
import '../controllers/login_controller.dart';
import 'create_account.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final LoginController loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xff1191FD),Color(0xff5E59F2)])
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage('assets/logos/csd.png'),
              ),
              SizedBox(height: SchoolSizes.md,),
              Align(
                  alignment: Alignment.center,
                  child: Text('Cambridge School Dumraon',
                      style:
                      Theme.of(context).textTheme.headlineMedium?.copyWith(color: SchoolDynamicColors.whiteTextColor))),
              const SizedBox(
                height: 120,
              ),
              TextButton(onPressed: (){SchoolHelperFunctions.navigateToScreen(context, AdminHome());}, child: Text('Admin')),

              Container(
                padding: EdgeInsets.all(SchoolSizes.md),
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
                  border:
                  Border.all(width: .5, color: SchoolDynamicColors.borderColor),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.center,
                        child: Text('Login',
                            style:
                            Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 28))),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text('Enter your username & password',
                    //       style: Theme.of(context)
                    //           .textTheme
                    //           .bodySmall
                    //           ?.copyWith(color: SchoolColors.textDisable)),
                    // ),

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
                      height: SchoolSizes.defaultSpace / 2,
                    ),
                    Text(
                      "---------- or ----------",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(
                      height: SchoolSizes.defaultSpace / 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account ? ",
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                        InkWell(
                          onTap: () {
                            SchoolHelperFunctions.navigateToScreen(
                                context, CreateAccount());
                          },
                          child: Text(
                            "Create Account ",
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: SchoolDynamicColors.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
