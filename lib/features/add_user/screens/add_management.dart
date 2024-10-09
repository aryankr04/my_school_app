import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import '../../../../../common/widgets/text_form_feild.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/date_picker.dart';
import '../../../common/widgets/image_picker.dart';
import '../controllers/add_manager_controller.dart';


class AddManagement extends StatelessWidget {
  final AddManagementController controller = Get.put(AddManagementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Management'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Form(
            key: controller.addManagementFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ImagePickerWidget(
                  image: controller.managementImage.value,
                  onImageSelected: (File value) {
                    controller.managementImage.value = value;
                  },
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                AutoCompleteTextField<Map<String, dynamic>>(
                  key: GlobalKey(),
                  controller: controller.selectedSchoolController,
                  clearOnSubmit: false,
                  suggestions: controller.schoolList,
                  itemFilter: (item, query) {
                    return item["schoolName"].toLowerCase().contains(
                        query?.toLowerCase() ?? ''); // Handle null query
                  },
                  itemSorter: (a, b) {
                    return a["schoolName"].compareTo(b["schoolName"]);
                  },
                  itemSubmitted: (item) {
                    controller.selectedSchoolController.text =
                    item["schoolId"];
                  },
                  itemBuilder: (context, item) {
                    return Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.all(SchoolSizes.sm),
                      color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                      child: Row(
                        children: [
                          SizedBox(width: SchoolSizes.md,),

                          Icon(Icons.school,color: SchoolDynamicColors.iconColor,),
                          SizedBox(width: SchoolSizes.md+8,),
                          Column(mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['schoolName'] ?? '',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              Text(
                                item['schoolId'] ?? '',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },

                  decoration: InputDecoration(
                      hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(color: SchoolDynamicColors.placeholderColor),
                      hintText: 'School',
                      prefixIcon: Icon(Icons.search,color: SchoolDynamicColors.iconColor,),
                      filled: true,
                      fillColor: SchoolDynamicColors.backgroundColorTintLightGrey,
                      suffixIcon: IconButton(
                        color: SchoolDynamicColors.iconColor,
                        icon: Icon(Icons.cancel_outlined),
                        onPressed: () {
                          controller.selectedSchoolController.clear();
                        },
                      )),
                  textChanged: (query) {
                    if (query != null) {
                      if (query.isNotEmpty) {
                        // Fetch schools based on the query
                        controller.fetchSchools(query);
                        // Filter the suggestions based on the query
                        controller.schoolList.assignAll(controller.schoolList
                            .where((school) =>
                        school["schoolName"] != null &&
                            school["schoolName"]
                                .toLowerCase()
                                .contains(query.toLowerCase())));
                      } else {
                        // If the query is empty, fetch all schools
                        controller.fetchSchools(query);
                      }
                    }
                  },
                ),

                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  controller: controller.nameController,
                  labelText: 'Name',
                  prefixIcon: Icons.person,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                DatePickerField(
                  initialDate: controller.dateOfBirthController.value,
                  onDateChanged: (date) {
                    controller.dateOfBirthController.value = date;
                  },
                  firstDate: DateTime(2000),
                  labelText: 'Date of Birth',
                  lastDate: DateTime.now(),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  controller: controller.mobileNumberController,
                  labelText: 'Mobile No.',
                  prefixIcon: Icons.phone_android_rounded,
                  keyboardType: TextInputType.phone,
                  validator: MultiValidator([
                    RequiredValidator(errorText: 'Please enter mobile number'),
                    LengthRangeValidator(
                      min: 10,
                      max: 10,
                      errorText: 'Please enter a 10-digit mobile no.',
                    ),
                  ]),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  controller: controller.addressController,
                  labelText: 'Address',
                  prefixIcon: Icons.pin_drop,
                  keyboardType: TextInputType.emailAddress,
                  validator:
                  RequiredValidator(errorText: 'Please enter a valid email'),
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                SchoolTextFormField(
                  controller: controller.emailController,
                  labelText: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator:
                  EmailValidator(errorText: 'Please enter a valid email'),
                ),
                const SizedBox(height: SchoolSizes.defaultSpace),
                SchoolTextFormField(
                  controller: controller.qualificationController,
                  labelText: 'Qualification',
                  prefixIcon: Icons.school,
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
                ElevatedButton(
                  onPressed: (){
                    controller.isFormValid()
                        ? controller.addManagementToFirebase()
                        : controller.addManagementToFirebase();
                  },
                  style: ElevatedButton.styleFrom(),
                  child: const Text('Add'),

                ),
                const SizedBox(
                  height: SchoolSizes.defaultSpace,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
