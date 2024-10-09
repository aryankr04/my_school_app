
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';

import '../../../../../../common/widgets/text_form_feild.dart';
import '../../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../../utils/constants/lists.dart';
import '../../../../common/widgets/image_picker.dart';
import '../../controllers/student/add_student_step1_controller.dart';


class Step1Form extends StatelessWidget {
  final Step1FormController controller;

  const Step1Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step5FormKey,
          child: Column(
            children: <Widget>[

              Obx(() => ImagePickerWidget(

                image: controller.image.value,
                onImageSelected: controller.setImage,
              )),
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

              const SizedBox(height: SchoolSizes.defaultSpace),

              SchoolTextFormField(
                labelText: 'Student Name',
                hintText: 'Enter Student Name',
                keyboardType: TextInputType.name,
                controller: controller.studentNameController,
                validator:
                RequiredValidator(errorText: 'Please enter your name'),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: 'Class',
                validator: RequiredValidator(errorText: 'Select Your Class'),
                selectedValue: controller.selectedClassController.value,
                onSelected: (value) {
                  controller.selectedClassController.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.sectionList,
                labelText: 'Sec',
                validator: RequiredValidator(errorText: 'Select Your Section'),
                selectedValue: controller.selectedSectionController.value,
                onSelected: (value) {
                  controller.selectedSectionController.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Roll No',
                keyboardType: TextInputType.number,
                controller: controller.rollNoController,
                validator: MultiValidator([
                  RequiredValidator(errorText: 'Enter your roll no.'),
                  RangeValidator(
                    min: 1,
                    max: 100,
                    errorText: 'Enter Valid Roll No.',
                  ),
                ]),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              DatePickerField(
                initialDate: controller.dateOfBirth.value,
                onDateChanged: controller.dateOfBirth,
                firstDate: DateTime(2000),
                labelText: 'Date of Birth',
                lastDate: DateTime.now(),

              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Father Name',
                keyboardType: TextInputType.name,
                controller: controller.fatherNameController,
                validator:
                RequiredValidator(errorText: 'Enter your Father Name'),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Mother Name',
                keyboardType: TextInputType.name,
                controller: controller.motherNameController,
                validator:
                RequiredValidator(errorText: 'Enter your Mother Name'),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
            ],
          ),
        ),
      ),
    );
  }
}
