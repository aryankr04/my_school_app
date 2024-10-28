import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step0.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step1.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step5.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step3.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step4.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step2.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step6.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step7.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step8.dart';
import 'package:my_school_app/utils/constants/colors.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../controllers/student/add_student0_controller.dart';

class AddStudent extends StatefulWidget {
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final AddStudent0Controller studentController =
      Get.put(AddStudent0Controller());

  // @override
  // void dispose() {
  //   // Clean up the controller when the widget is disposed
  //   studentController.onClose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: SchoolSizes.defaultSpace,
                right: SchoolSizes.defaultSpace,
                top: SchoolSizes.defaultSpace),
            child: Column(
              children: [
                // Obx(() => SchoolStepper(
                //     activeStep: studentController.activeStep.value,
                //     noOfSteps: 5)),
                // const SizedBox(height: SchoolSizes.defaultSpace),

                Row(
                  children: [
                    Expanded(
                      child: Obx(
                        () => TweenAnimationBuilder<double>(
                          tween: Tween<double>(
                            begin: 0.0,
                            end: (studentController.activeStep.value) / 8,
                          ),
                          duration: Duration(milliseconds: 500),
                          builder: (context, value, child) {
                            return ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                              child: LinearProgressIndicator(
                                value: value,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    SchoolColors.activeBlue),
                                backgroundColor: SchoolDynamicColors.grey,
                                minHeight: 8,
                                borderRadius:
                                    BorderRadius.circular(SchoolSizes.md),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    Obx(
                      () => Text(
                        '${studentController.activeStep.value}/8',
                        style: Theme.of(context)?.textTheme.titleLarge,
                      ),
                    )
                  ],
                ),
                const SizedBox(height: SchoolSizes.lg),

                Obx(
                  () => Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          studentController.getStepName(),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (studentController.activeStep.value == 0)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Welcome! This registration will guide you through 8 simple steps to create your student profile with essential information about your background and academics.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(),
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/images/illustration/signup.svg',
                              height: 150,
                              fit: BoxFit.fill,
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView(
              //physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              onPageChanged: (int page) {
                print('Page changed to $page');
                studentController.activeStep.value = page;
              },
              controller: studentController.pageController,
              children: [
                StudentStep0Form(),
                StudentStep1Form(
                  controller: studentController.step1Controller,
                ),
                StudentStep2Form(
                  controller: studentController.step2Controller,
                ),
                StudentStep3Form(
                  controller: studentController.step3Controller,
                ),
                StudentStep4Form(
                  controller: studentController.step4Controller,
                ),
                StudentStep5Form(
                  //5-2
                  controller: studentController.step5Controller,
                ),
                StudentStep6Form(
                  controller: studentController.step6Controller,
                ),
                StudentStep7Form(
                  controller: studentController.step7Controller,
                ),
                StudentStep8Form(
                  controller: studentController.step8Controller,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: SchoolSizes.defaultSpace,
              right: SchoolSizes.defaultSpace,
              bottom: SchoolSizes.defaultSpace,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: studentController.activeStep.value == 0
                          ? null
                          : studentController.decrementStep,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: SchoolColors.activeBlue,
                          disabledBackgroundColor: SchoolColors.softGrey),
                      child: Text(
                        'Back',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: studentController.activeStep.value == 0
                                    ? SchoolColors.disabledButtonColor
                                    : Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: SchoolSizes.defaultSpace),
                Expanded(
                  child: Obx(
                    () => ElevatedButton(
                      onPressed: studentController.activeStep.value <= 7
                          ? studentController.incrementStep
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: SchoolColors.activeBlue,
                          disabledBackgroundColor: SchoolColors.softGrey),
                      child: Text(
                          studentController.activeStep.value == 8
                              ? 'Finish'
                              : 'Next',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: studentController.activeStep.value < 8
                                      ? Colors.white
                                      : SchoolColors.disabledButtonColor)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
