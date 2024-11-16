import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../utils/constants/lists.dart';
import '../../controllers/school_staff/add_school_staff_step4_controller.dart';

class SchoolStaffStep4Form extends StatelessWidget {
  final SchoolStaffStep4FormController controller;

  const SchoolStaffStep4Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step4FormKey,
          child: Column(
            children: <Widget>[
              SchoolTextFormField(
                controller: controller.mobileNoController,
                labelText: 'Mobile No.',
                keyboardType: TextInputType.phone,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please enter mobile number'),
                  LengthRangeValidator(
                    min: 10,
                    max: 10,
                    errorText: 'Please enter 10-digit mobile no.',
                  ),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                controller: controller.mobileNoController,
                labelText: 'Emergency Mobile No.',
                keyboardType: TextInputType.phone,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please enter mobile number'),
                  LengthRangeValidator(
                    min: 10,
                    max: 10,
                    errorText: 'Please enter 10-digit mobile no.',
                  ),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                controller: controller.emailAddressController,
                labelText: 'Email',
                keyboardType: TextInputType.emailAddress,
                validator:
                    EmailValidator(errorText: 'Please enter a valid email'),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                controller: controller.addressController,
                labelText: 'Address',
                keyboardType: TextInputType.streetAddress,
                validator: RequiredValidator(errorText: 'Please enter address'),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                controller: controller.mobileNoController,
                labelText: 'Pincode',
                keyboardType: TextInputType.phone,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Please enter pincode number'),
                  LengthRangeValidator(
                    min: 6,
                    max: 6,
                    errorText: 'Please enter 6 digit valid pincode.',
                  ),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.schoolTransportModes,
                labelText: "Mode of Transport",
                isValidate: true,
                selectedValue: controller.selectedModeOfTransport.value,
                onSelected: (value) {
                  controller.selectedModeOfTransport.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              Obx(() =>
                  controller.selectedModeOfTransport.value == 'School Transport'
                      ? SchoolDropdownFormField(
                          items: SchoolLists.classList,
                          labelText: "Vehicle No",
                          isValidate: true,
                          selectedValue: controller.selectedVehicleNo.value,
                          onSelected: (value) {
                            controller.selectedVehicleNo.value = value!;
                          },
                        )
                      : SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}
