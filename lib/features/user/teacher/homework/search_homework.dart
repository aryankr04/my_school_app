import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../common/widgets/elevated_button.dart';
import '../../../../common/widgets/text_form_feild.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/lists.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../common/widgets/date_picker.dart';

class SearchHomework extends StatelessWidget {
  const SearchHomework({super.key});

  @override
  Widget build(BuildContext context) {
         return Scaffold(
      appBar: AppBar(
        title: const Text('Search Homework'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Search Homework",
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              Row(
                children: [
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.classList,
                      labelText: 'Class',
                      isValidate: true,
                      //selectedValue: controller.selectedClassController.value,
                      onSelected: (value) {
                        //controller.selectedClassController.value = value!;
                      },
                    ),
                  ),
                  const SizedBox(width: SchoolSizes.defaultSpace),
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.classList,
                      labelText: 'Section',
                      isValidate: true,
                      //selectedValue: controller.selectedClassController.value,
                      onSelected: (value) {
                        //controller.selectedClassController.value = value!;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.classList,
                labelText: 'Subject',
                isValidate: true,
                //selectedValue: controller.selectedClassController.value,
                onSelected: (value) {
                  //controller.selectedClassController.value = value!;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              DatePickerField(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(Duration(days: 7)),
                  lastDate: DateTime.now(),
                  labelText: 'Select Date'),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolElevatedButton(text: 'Search', onPressed: () {})
            ],
          ),
        ),
      ),
    );
    ;
  }
}
