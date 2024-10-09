import 'dart:io';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';

import '../../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../../common/widgets/elevated_button.dart';
import '../../../../../common/widgets/text_form_feild.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/lists.dart';
import '../../../../../utils/constants/sizes.dart';

import 'package:get/get.dart';

import '../../../common/widgets/image_picker.dart';
import '../controllers/add_teacher_controller.dart';



class SubjectDialog extends StatelessWidget {
  final RxList<String> tags;
  final List<String> options;
  final List<String> initialSelectedTags;
  final Function(List<String>) onSelectionChanged;

  SubjectDialog({
    required this.tags,
    required this.options,
    required this.initialSelectedTags,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.all(16.0),
      title: const Text('Select Subjects'),
      content: SizedBox(
        width: double.maxFinite,
        child: ChipsChoice<String>.multiple(
          value: tags.toList(),
          wrapped: true,
          choiceStyle: const C2ChipStyle(),
          choiceCheckmark: true,
          spacing: SchoolSizes.defaultSpace,
          onChanged: (val) {
            tags.assignAll(val);
          },
          choiceItems: C2Choice.listFrom<String, String>(
            source: options,
            value: (i, v) => v,
            label: (i, v) => v,
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            onSelectionChanged(tags.toList());
            Navigator.of(context).pop();
          },
          child: const Text(
            'OK',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class AddTeacher extends StatelessWidget {
  final AddTeacherController controller = Get.put(AddTeacherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Teacher'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(SchoolSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ImagePickerWidget(
              image: controller.teacherImage.value,
              onImageSelected: (File value) {
                controller.teacherImage.value = value;
              },
            ),
            const SizedBox(height: SchoolSizes.defaultSpace),
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
                            item['schoolName'] ?? '', // Default to an empty string if 'schoolName' is null
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            item['schoolId'] ?? '', // Default to an empty string if 'schoolId' is null
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
              firstDate: DateTime(1950),
              labelText: 'Date of Birth',
              lastDate: DateTime.now(),
            ),
            const SizedBox(height: SchoolSizes.defaultSpace),
            SchoolDropdownFormField(
              items: SchoolLists.genderList,
              labelText: 'Gender',
              prefixIcon: Icons.transgender,
              validator: RequiredValidator(errorText: 'Select your Gender'),
              onSelected: (val) {
                controller.selectedGender.value = val;
              },
            ),
            const SizedBox(height: SchoolSizes.defaultSpace),
            SchoolTextFormField(
              controller: controller.mobileNoController,
              labelText: 'Mobile No.',
              prefixIcon: Icons.phone_android_rounded,
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
              controller: controller.addressController,
              labelText: 'Address',
              prefixIcon: Icons.pin_drop,
              keyboardType: TextInputType.streetAddress,
              validator: RequiredValidator(errorText: 'Please enter address'),
            ),
            const SizedBox(height: SchoolSizes.defaultSpace),
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
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: SchoolSizes.defaultSpace),
            SchoolTextFormField(
              labelText: 'Subjects Taught',
              prefixIcon: Icons.menu_book,
              keyboardType: TextInputType.text,
              onTap: () {
                controller.showSubjectDialog(context);
              },
              readOnly: true,
              controller: controller.subjectsController,
            ),
            const SizedBox(height: SchoolSizes.defaultSpace),
            SchoolElevatedButton(
              onPressed: () => controller.isFormValid()
                  ? controller.addTeacherToFirebase()
                  : controller.addTeacherToFirebase(),
              text: 'Add',
            ),
          ],
        ),
      ),
    );
  }
}
