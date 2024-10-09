import 'dart:io';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';
import '../../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../../common/widgets/text_form_feild.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/image_picker.dart';
import '../controllers/add_principal_controller.dart';

class AddPrincipal extends StatelessWidget {
  final AddPrincipalController controller = Get.put(AddPrincipalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Principal'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: GetBuilder<AddPrincipalController>(
            builder: (controller) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ImagePickerWidget(
                    image: controller.principalImage.value,
                    onImageSelected: (File value) {
                      controller.principalImage.value = value;
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
                            SizedBox(
                              width: SchoolSizes.md,
                            ),
                            Icon(
                              Icons.school,
                              color: SchoolDynamicColors.iconColor,
                            ),
                            SizedBox(
                              width: SchoolSizes.md + 8,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item['schoolName'] ??
                                      '', // Default to an empty string if 'schoolName' is null
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  item['schoolId'] ??
                                      '', // Default to an empty string if 'schoolId' is null
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    decoration: InputDecoration(
                        hintStyle: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(color: SchoolDynamicColors.placeholderColor),
                        hintText: 'School',
                        prefixIcon: Icon(
                          Icons.search,
                          color: SchoolDynamicColors.iconColor,
                        ),
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
                          print(controller.schoolList);
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
                    controller: controller.principalNameController,
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
                  SchoolDropdownFormField(
                    items: SchoolLists.genderList,
                    labelText: 'Gender',
                    prefixIcon: Icons.transgender,
                    validator:
                        RequiredValidator(errorText: 'Select your Gender'),
                    onSelected: (val) {
                      controller.selectedGender.value = val;
                    },
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
                      RequiredValidator(
                          errorText: 'Please enter mobile number'),
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
                    prefixIcon: Icons.location_on,
                    keyboardType: TextInputType.streetAddress,
                    validator:
                        RequiredValidator(errorText: 'Please enter address'),
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
                  const SizedBox(
                    height: SchoolSizes.defaultSpace,
                  ),
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
                    onPressed: () {
                      controller.isFormValid()
                          ? controller.addPrincipalToFirebase()
                          : controller.addPrincipalToFirebase();
                    },
                    style: ElevatedButton.styleFrom(),
                    child: const Text('Add'),
                  ),
                  const SizedBox(
                    height: SchoolSizes.defaultSpace,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}