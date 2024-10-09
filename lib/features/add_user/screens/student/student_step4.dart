import 'package:flutter/material.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../../controllers/student/add_student_step4_controller.dart';

class Step4Form extends StatelessWidget {
  final Step4FormController controller ;

  const Step4Form({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.defaultSpace),
        child: Form(
          key: controller.step4FormKey,
          child: Column(
            children: <Widget>[
              SchoolDropdownFormField(
                labelText: 'Transportation',
                items: SchoolLists.transportationList,
                selectedValue: controller.transportation.value,
                onSelected: (value) {
                  controller.transportation.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: 'Vehicle No',
                selectedValue: controller.vehicleNo.value,
                onSelected: (value) {
                  controller.vehicleNo.value = value!;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Your Favorites',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w700, fontSize: 18),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: 'Subject',
                selectedValue: controller.subject.value,
                onSelected: (value) {
                  controller.subject.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: 'Teacher',
                selectedValue: controller.teacher.value,
                onSelected: (value) {
                  controller.teacher.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: 'Sports',
                selectedValue: controller.sports.value,
                onSelected: (value) {
                  controller.sports.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.defaultSpace,
              ),
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: 'Other Activities',
                selectedValue: controller.activities.value,
                onSelected: (value) {
                  controller.activities.value = value!;
                },
              ),
              const SizedBox(
                height: SchoolSizes.spaceBtwSections,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
