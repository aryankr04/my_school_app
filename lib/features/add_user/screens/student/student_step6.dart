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
import '../../controllers/student/add_student_step6_controller.dart';

class StudentStep6Form extends StatelessWidget {
  final StudentStep6FormController controller;

  const StudentStep6Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step6FormKey,
          child: Column(
            children: [
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: 'Subject',
                hintText: "Select Favorite Subject",
                isValidate:
                true,
                selectedValue: controller.selectedFavoriteSubject.value,
                onSelected: (value) {
                  controller.selectedFavoriteSubject.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.favoriteSports,
                labelText: 'Sport',
                hintText: "Select Favorite Sport",
                isValidate:
                true,
                selectedValue: controller.selectedFavoriteSport.value,
                onSelected: (value) {
                  controller.selectedFavoriteSport.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: 'Teacher',
                hintText: "Select Favorite Teacher",
                isValidate: true,
                selectedValue: controller.selectedFavoriteTeacher.value,
                onSelected: (value) {
                  controller.selectedFavoriteTeacher.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                labelText: "Food",
                hintText: "Enter Favorite Food",
                keyboardType: TextInputType.name,
                controller: controller.favoriteFoodController,
                validator: RequiredValidator(errorText: 'Enter Favorite Food'),
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolTextFormField(
                labelText: "Goal",
                hintText: "Ex - Engineer, Doctor, Scientist, Businessman etc.",
                keyboardType: TextInputType.name,
                controller: controller.goalController,
                validator: RequiredValidator(errorText: 'Enter Goal'),
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),

              SchoolTextFormField(
                onTap: controller.showHobbySelectionDialog,
                readOnly: true,
                labelText: "Hobbies",
                hintText: "Select Hobbies",
                keyboardType: TextInputType.name,
                controller: controller.hobbyController,
                validator: RequiredValidator(errorText: 'Enter Favorite Food'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
