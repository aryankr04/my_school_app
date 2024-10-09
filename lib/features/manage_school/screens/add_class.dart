
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../common/widgets/option_list0.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../controllers/add_class_controller.dart';
import '../widgets/section_card.dart';

class AddClass extends StatefulWidget {
  AddClass({super.key});

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  AddClassController controller = Get.put(AddClassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Class'),
      ),
      body: Obx(() => SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(SchoolSizes.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Select Class',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          controller.addClass();
                        },
                        child: Text(
                          'Add Class +',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(color: SchoolDynamicColors.primaryColor),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: SchoolSizes.spaceBtwItems,
                  ),
                  if (controller.isLoadingClass.value)
                    _buildShimmerClassList()
                  else
                    Obx(
                      () => SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(
                          runSpacing: 8.0,
                          spacing: 12.0,
                          children:
                              controller.classes.asMap().entries.map((entry) {
                            String className = entry.value ??
                                ''; // Replace 'className' with the actual key used in your Map

                            return CardButton(
                              text: className,
                              isSelected: className ==
                                  controller.selectedClassName.value,
                              onPressed: () {
                                controller.selectedClassName.value = className;
                                controller.fetchSections(
                                    'SCH0000000001', className);
                                print(className);
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  const SizedBox(
                    height: SchoolSizes.spaceBtwSections,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusLg),
                      border: Border.all(
                          color: SchoolDynamicColors.borderColor, width: 0.5),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(
                            SchoolSizes.spaceBtwItems,
                            SchoolSizes.sm,
                            SchoolSizes.sm,
                            SchoolSizes.sm,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                                () => Text(
                                  controller.selectedClassName.isNotEmpty
                                      ? controller.selectedClassName.value
                                      : 'Select a Class',
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.edit),
                                    color: SchoolDynamicColors.primaryColor,
                                  ),
                                  const SizedBox(
                                    width: SchoolSizes.sm,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      await controller.deleteClassAndSections(
                                          'SCH0000000001',
                                          controller.selectedClassName.value);
                                      controller.selectedClassName = ''.obs;
                                    },
                                    icon: const Icon(Icons.delete_rounded),
                                    color: SchoolDynamicColors.activeRed,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 1,
                          color: SchoolDynamicColors.borderColor,
                        ),
                        Container(
                          padding:
                              const EdgeInsets.all(SchoolSizes.spaceBtwItems),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Section',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      controller.showAddSectionDialog(null);
                                    },
                                    child: Text(
                                      'Add Section +',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                              color: SchoolDynamicColors.primaryColor),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: SchoolSizes.spaceBtwItems),
                              controller.isLoadingSec.value
                                  ? _buildShimmerSectionList()
                                  : Obx(
                                      () => Wrap(
                                        runSpacing: SchoolSizes.spaceBtwItems,
                                        spacing: SchoolSizes.spaceBtwItems,
                                        children: controller.sections
                                            .map<Widget>(
                                                (Map<String, dynamic> section) {
                                          return SectionCard(
                                            section:
                                                section['sectionName'] ?? '',
                                            classTeacherName:
                                                section['classTeacherName'] ??
                                                    '',
                                            numberOfStudents:
                                                section['noOfStudents'] ?? 0,
                                            onEdit: () async {
                                              controller.showAddSectionDialog(
                                                  section);
                                            },
                                            onDelete: () async {
                                              SchoolHelperFunctions
                                                  .showLoadingOverlay();
                                              controller.deleteSection(
                                                  section['sectionId']);


                                              controller.fetchSections(
                                                  'SCH0000000001',
                                                  controller
                                                      .selectedClassName.value);
                                              Get.back();
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),

                              const SizedBox(
                                  height: SchoolSizes.spaceBtwSections),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Subjects',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  // FilledButton(
                                  //   onPressed: () async {
                                  //     await subjectManager!.showAddSubjectDialog();
                                  //     setState(() {
                                  //       fetchSubjectsFromFirebase(selectedClass);
                                  //     });
                                  //   },
                                  //   child: Text(
                                  //     'Add Subject +',
                                  //     style: Theme.of(context)
                                  //         .textTheme
                                  //         .labelLarge
                                  //         ?.copyWith(color: Colors.white),
                                  //   ),
                                  // ),
                                ],
                              ),
                              const SizedBox(height: SchoolSizes.spaceBtwItems),
                              // Wrap(
                              //   runSpacing: SchoolSizes.spaceBtwItems,
                              //   spacing: SchoolSizes.spaceBtwItems,
                              //   children: subjectCards.map((subject) {
                              //     return SubjectCard(
                              //       subject: subject.subject,
                              //       iconData: subject.iconData,
                              //       onDelete: () async {
                              //         await subjectManager!
                              //             .deleteSubject(subject.subject);
                              //         setState(() {
                              //           fetchSubjectsFromFirebase(selectedClass!);
                              //         });
                              //       },
                              //     );
                              //   }).toList(),
                              // ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  Widget _buildShimmerClassList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Shimmer.fromColors(
        baseColor: SchoolDynamicColors.backgroundColorGreyLightGrey!,
        highlightColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey!,
        child: Row(
          children: List.generate(
            5, // Number of shimmering items
            (index) => Card(
              
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  width: 100,
                  height: 24,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerSectionList() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Shimmer.fromColors(
        baseColor: SchoolDynamicColors.backgroundColorGreyLightGrey!,
        highlightColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey!,
        child: Column(
          children: List.generate(
            4, // Number of shimmering items
                (index) {
              return Column(
                children: [
                  Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0), // Adjust the height as needed
                ],
              );
            },
          ),
        ),
      ),
    );
  }

}
