import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../../../utils/constants/lists.dart';
import '../../../../../common/widgets/image_picker.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../controllers/school_staff/add_school_staff_step1_controller.dart';

class SchoolStaffStep1Form extends StatelessWidget {
  final SchoolStaffStep1FormController controller;

  const SchoolStaffStep1Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step1FormKey,
          child: Column(
            children: <Widget>[
              // ImagePickerWidget(
              //   image: controller.teacherImage.value,
              //   onImageSelected: (File value) {
              //     controller.teacherImage.value = value;
              //   },
              // ),
              // const SizedBox(height: SchoolSizes.defaultSpace),
              AutoCompleteTextField<Map<String, dynamic>>(
                key: GlobalKey(),
                controller: controller.schoolController,
                clearOnSubmit: false,
                suggestions: controller.schoolList,
                itemFilter: (item, query) {
                  return item["schoolName"]
                      .toLowerCase()
                      .contains(query?.toLowerCase() ?? ''); // Handle null query
                },
                itemSorter: (a, b) {
                  return a["schoolName"].compareTo(b["schoolName"]);
                },
                itemSubmitted: (item) {
                  controller.schoolController.text = item["schoolId"];
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
                        controller.schoolController.clear();
                      },
                    )),
                textChanged: (query) {
                  if (query != null) {
                    if (query.isNotEmpty) {
                      // Fetch schools based on the query
                      controller.fetchSchools(query);
                      // Filter the suggestions based on the query
                      controller.schoolList.assignAll(controller.schoolList.where(
                              (school) =>
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
                keyboardType: TextInputType.name,
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              DatePickerField(
                initialDate: controller.dateOfBirth.value,
                onDateChanged: controller.dateOfBirth,
                firstDate: DateTime(2000),
                labelText: 'Date of Birth',
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.genderList,
                labelText: 'Gender',
                isValidate: true,
                onSelected: (val) {
                  controller.selectedGender.value = val;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              SchoolDropdownFormField(
                items: SchoolLists.nationality,
                labelText: 'Nationality',
                isValidate: true,
                selectedValue: controller.selectedNationality.value,
                onSelected: (value) {
                  controller.selectedNationality.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.religions,
                labelText: 'Religion',
                isValidate: true,
                selectedValue: controller.selectedReligion.value,
                onSelected: (value) {
                  controller.selectedReligion.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.categoryList,
                labelText: 'Category',
                isValidate: true,
                selectedValue: controller.selectedCategory.value,
                onSelected: (value) {
                  controller.selectedCategory.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.bloodGroupList,
                labelText: 'Blood Group',
                isValidate: true,
                selectedValue: controller.selectedBloodGroup.value,
                onSelected: (value) {
                  controller.selectedBloodGroup.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              Row(
                children: [
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.heightFtList,
                      labelText: 'Height (Feet)',
                      hintText: 'Select Feet',
                      isValidate: true,
                      selectedValue: controller.selectedHeightFt.value,
                      onSelected: (value) {
                        controller.selectedHeightFt.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: SchoolSizes.defaultSpace,
                  ),
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.heightInchList,
                      labelText: 'Height(Inch)',
                      hintText: 'Select Inch',
                      isValidate: true,
                      selectedValue: controller.selectedHeightInch.value,
                      onSelected: (value) {
                        controller.selectedHeightInch.value = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              SchoolDropdownFormField(
                items: SchoolLists.bloodGroupList,
                labelText: 'Marital Status',
                isValidate: true,
                selectedValue: controller.selectedMaritalStatus.value,
                onSelected: (value) {
                  controller.selectedMaritalStatus.value = value!;
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
