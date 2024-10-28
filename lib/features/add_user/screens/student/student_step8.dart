import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../controllers/student/add_student_step8_controller.dart';

class StudentStep8Form extends StatelessWidget {
  final StudentStep8FormController controller;

  const StudentStep8Form({super.key, required this.controller});

  void _showOtpBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'OTP Verification',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              SizedBox(height: SchoolSizes.sm),
              Text(
                textAlign: TextAlign.center,
                'Please enter the OTP sent to your registered mobile number ${controller.mobileNoController.text.trim()}.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
              ),
              SizedBox(height: SchoolSizes.spaceBtwSections + 16),
              Obx(
                    () => PinFieldAutoFill(
                  textInputAction: TextInputAction.done,
                  controller: controller.otpEditingController,
                  decoration: UnderlineDecoration(
                    textStyle: Theme.of(context).textTheme.titleLarge,
                    colorBuilder: const FixedColorBuilder(Colors.transparent),
                    bgColorBuilder: FixedColorBuilder(Colors.grey.withOpacity(0.2)),
                  ),
                  currentCode: controller.messageOtpCode.value,
                  onCodeSubmitted: (code) {
                    controller.verifyOtp(code!);
                  },
                  onCodeChanged: (code) {
                    controller.messageOtpCode.value = code!;
                    if (code.length == 6) {
                      controller.verifyOtp(code);
                    }
                  },
                ),
              ),
              const SizedBox(height: SchoolSizes.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Didn't get OTP Code?",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Obx(
                        () => controller.remainingTime.value == 0
                        ? GestureDetector(
                      onTap: () {
                        controller.resendOtp(controller.mobileNoController.text.trim());
                      },
                      child: Text(
                        " Resend OTP",
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: SchoolDynamicColors.activeBlue),
                      ),
                    )
                        : Obx(()=>Text(
                          " Wait ${controller.remainingTime.value} seconds",
                          style: Theme.of(context).textTheme.bodyLarge,
                        )),
                  ),
                ],
              ),
              SizedBox(height: SchoolSizes.spaceBtwSections + 16),
              ElevatedButton(
                onPressed: () {
                  controller.verifyOtp(controller.messageOtpCode.value);
                },
                child: const Text('Verify'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step8FormKey,
          child: Column(
            children: [
              SchoolTextFormField(
                labelText: 'Mobile No.',
                prefixIcon: Icons.phone_android_rounded,
                controller: controller.mobileNoController,
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Username',
                prefixIcon: Icons.person,
                controller: controller.usernameController,
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Password',
                prefixIcon: Icons.lock,
                keyboardType: TextInputType.visiblePassword,
                suffixIcon: Icons.visibility_off,
                controller: controller.passwordController,
              ),
              SizedBox(height: SchoolSizes.lg),
              ElevatedButton(
                  onPressed: () {
                    // Call sendOtp when the Register button is clicked
                    controller.sendOtp(controller.mobileNoController.text.trim());
                    _showOtpBottomSheet(Get.context!);
                  },
                  child: const Text('Register')),
              SizedBox(height: SchoolSizes.lg),
            ],
          ),
        ),
      ),
    );
  }
}
