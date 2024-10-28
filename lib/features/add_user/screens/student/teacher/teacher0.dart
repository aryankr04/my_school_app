import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/add_user/controllers/teacher/add_teacher0_controller.dart';
import 'package:my_school_app/features/add_user/screens/student/teacher/teacher_step0.dart';
import 'package:my_school_app/features/add_user/screens/student/teacher/teacher_step1.dart';
import 'package:my_school_app/features/add_user/screens/student/teacher/teacher_step2.dart';
import 'package:my_school_app/features/add_user/screens/student/teacher/teacher_step3.dart';
import 'package:my_school_app/features/add_user/screens/student/teacher/teacher_step4.dart';
import 'package:my_school_app/features/add_user/screens/student/teacher/teacher_step5.dart';
import 'package:my_school_app/utils/constants/colors.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import '../../../../../../utils/constants/sizes.dart';

class AddTeacher extends StatefulWidget {
  @override
  State<AddTeacher> createState() => _AddTeacherState();
}

class _AddTeacherState extends State<AddTeacher> {
  final AddTeacher0Controller teacherController =
      Get.put(AddTeacher0Controller());

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
        title: const Text('Add Teacher'),
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
                            end: (teacherController.activeStep.value) / 5,
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
                        '${teacherController.activeStep.value}/5',
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
                          teacherController.getStepName(),
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      if (teacherController.activeStep.value == 0)
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Welcome! This registration will guide you through 5 simple steps to create your teacher profile with essential information about your background and academics.",
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
                teacherController.activeStep.value = page;
              },
              controller: teacherController.pageController,
              children: [
                TeacherStep0Form(),
                TeacherStep1Form(
                  controller: teacherController.step1Controller,
                ),
                TeacherStep2Form(
                  controller: teacherController.step2Controller,
                ),
                TeacherStep3Form(
                  controller: teacherController.step3Controller,
                ),
                TeacherStep4Form(
                  controller: teacherController.step4Controller,
                ),
                TeacherStep5Form(
                  controller: teacherController.step5Controller,
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
                      onPressed: teacherController.activeStep.value == 0
                          ? null
                          : teacherController.decrementStep,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: SchoolColors.activeBlue,
                          disabledBackgroundColor: SchoolColors.softGrey),
                      child: Text(
                        'Back',
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium
                            ?.copyWith(
                                color: teacherController.activeStep.value == 0
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
                      onPressed: teacherController.activeStep.value <= 4
                          ? teacherController.incrementStep
                          : null,
                      style: ElevatedButton.styleFrom(
                          backgroundColor: SchoolColors.activeBlue,
                          disabledBackgroundColor: SchoolColors.softGrey),
                      child: Text(
                          teacherController.activeStep.value == 5
                              ? 'Finish'
                              : 'Next',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: teacherController.activeStep.value < 5
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
