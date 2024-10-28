import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../common/widgets/date_picker.dart';
import '../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/lists.dart';
import '../../controllers/student/add_student_step2_controller.dart';

class StudentStep2Form extends StatelessWidget {
  final StudentStep2FormController controller;

  const StudentStep2Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step2FormKey,
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'School',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  )),
              SizedBox(
                height: SchoolSizes.sm,
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
                  controller.selectedSchoolController.text = item["schoolId"];
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
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: SchoolDynamicColors.placeholderColor),
                    hintText: 'School',
                    // prefixIcon: Icon(
                    //   Icons.search,
                    //   color: SchoolDynamicColors.iconColor,
                    // ),
                    border: InputBorder.none,
                    enabledBorder: const OutlineInputBorder().copyWith(
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.inputFieldRadius),
                      borderSide: BorderSide(
                          width: 0,
                          color:
                              SchoolDynamicColors.backgroundColorWhiteDarkGrey),
                    ),
                    focusedBorder: const OutlineInputBorder().copyWith(
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.inputFieldRadius),
                      borderSide: BorderSide(
                          width: 1.5, color: SchoolDynamicColors.primaryColor),
                    ),
                    filled: true,
                    fillColor: SchoolDynamicColors.backgroundColorTintLightGrey,
                    suffixIcon: IconButton(
                      color: SchoolDynamicColors.iconColor,
                      icon: controller.selectedSchoolController.value == null
                          ? Icon(Icons.search)
                          : Icon(Icons.close_rounded),
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
              SizedBox(
                height: SchoolSizes.lg,
              ),
              DatePickerField(
                initialDate: controller.admissionDate.value,
                onDateChanged: controller.admissionDate,
                firstDate: DateTime(2000),
                labelText: 'Admission Date',
                lastDate: DateTime.now(),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              Row(
                children: [
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.classList,
                      labelText: 'Class',
                      isValidate: true,
                      selectedValue: controller.selectedClass.value,
                      onSelected: (value) {
                        controller.selectedClass.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: SchoolSizes.defaultSpace),
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.sectionList,
                      labelText: 'Section',
                      isValidate: true,
                      selectedValue: controller.selectedSection.value,
                      onSelected: (value) {
                        controller.selectedSection.value = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Roll No',
                keyboardType: TextInputType.number,
                controller: controller.rollNoController,
                validator: MultiValidator([
                  RequiredValidator(errorText: ''),
                  RangeValidator(
                    min: 1,
                    max: 100,
                    errorText: 'Enter Valid Roll No.',
                  ),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.schoolHouses,
                labelText: 'House/Team Allocation',
                isValidate: true,
                selectedValue: controller.selectedHouseOrTeam.value,
                onSelected: (value) {
                  controller.selectedHouseOrTeam.value = value!;
                },
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.yesNoList,
                labelText: 'Transport Required',
                isValidate: true,
                selectedValue: controller.isTransportRequired.value,
                onSelected: (value) {
                  controller.isTransportRequired.value = value!;
                },
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: 'Vehicle No.',
                selectedValue: controller.selectedVehicleNo.value,
                onSelected: (value) {
                  controller.selectedVehicleNo.value = value!;
                },
              ),
              SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.schoolTransportModes,
                labelText: 'Mode of Transport',
                isValidate: true,
                selectedValue: controller.selectedModeOfTransport.value,
                onSelected: (value) {
                  controller.selectedModeOfTransport.value = value!;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
