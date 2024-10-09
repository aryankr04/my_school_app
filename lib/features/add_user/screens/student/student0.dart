import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step1.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step2.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step3.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step4.dart';
import 'package:my_school_app/features/add_user/screens/student/student_step5.dart';
import '../../../../../../common/widgets/elevated_button.dart';
import '../../widgets/stepper.dart';
import '../../../../../../utils/constants/sizes.dart';
import '../../controllers/student/add_student0_controller.dart';


class AddStudent extends StatefulWidget {
  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final AddStudent0Controller studentController = Get.put(AddStudent0Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),leading: IconButton(onPressed: () { },icon: const Icon(Icons.arrow_back_rounded),),
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
                Obx(() => SchoolStepper(
                    activeStep: studentController.activeStep.value,
                    noOfSteps: 5)),
                const SizedBox(height: SchoolSizes.defaultSpace),

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
                Step1Form(
                  controller: studentController.step1Controller,
                ),
                Step2Form(
                  controller: studentController.step2Controller,
                ),
                Step3Form(
                  controller: studentController.step3Controller,
                ),
                Step4Form(
                  controller: studentController.step4Controller,
                ),
                Step5Form(
                  controller: studentController.step5Controller,
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
                        backgroundColor: studentController.activeStep.value == 0
                            ? Colors.grey
                            : null,
                      ),
                      child: const Text('Back'),
                    ),
                  ),
                ),
                const SizedBox(width: SchoolSizes.defaultSpace),
                Expanded(
                  child: Obx(
                    () => SchoolElevatedButton(
                      text: studentController.activeStep.value == 4
                          ? 'Finish'
                          : 'Next',
                      onPressed: studentController.incrementStep,
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
