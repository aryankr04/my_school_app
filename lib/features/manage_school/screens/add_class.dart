import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/single_selection_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../common/widgets/confirmationDialog.dart';
import '../controllers/add_class_controller.dart';
import '../models/school_class.dart';
import '../widgets/section_card.dart';

class AddClass extends StatefulWidget {
  AddClass({Key? key}) : super(key: key);

  @override
  State<AddClass> createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  final AddClassController controller = Get.put(AddClassController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Class')),
      body: Obx(() => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildClassSelectionRow(context),

              const SizedBox(height: SchoolSizes.spaceBtwSections),
              _buildClassDetailsCard(context),
            ],
          ),
        ),
      )),
    );
  }

  // Widget to build the "Select Class" row with "Add Class +" button
  Widget _buildClassSelectionRow(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Select Class', style: Theme.of(context).textTheme.headlineSmall),
            TextButton(
              onPressed: () => controller.addClassName(),
              child: Text(
                'Add Class +',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: SchoolDynamicColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: SchoolSizes.spaceBtwItems),
        controller.isLoadingClassNames.value
            ? _buildShimmerClassList()
            : SingleSelectionWidget(
            options: controller.classNames,
            onSelectionChanged: (className) {
              controller.selectedClassName.value = className;
              controller.fetchClasses('SCH0000000001', className);
            }),
      ],
    );
  }

  // Widget for the card that displays class details, including sections and subjects
  Widget _buildClassDetailsCard(BuildContext context) {
    return Container(
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
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusLg),
        border: Border.all(color: SchoolDynamicColors.borderColor, width: 0.5),
      ),
      child: Column(
        children: [
          _buildSelectedClassHeader(context),
          Container(height:1,color: SchoolDynamicColors.borderColor),
          _buildSectionList(context),
          _buildSubjectList(context),
        ],
      ),
    );
  }

  // Header showing selected class with delete icon
  Widget _buildSelectedClassHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:SchoolSizes.md),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Obx(() => Text(
            controller.selectedClassName.isNotEmpty
                ? "Class - ${controller.selectedClassName.value}"
                : 'Select a Class',
            style: Theme.of(context).textTheme.headlineSmall,
          )),
          IconButton(
            onPressed: () async {
              await controller.deleteClassesAndClassName(
                  'SCH0000000001', controller.selectedClassName.value);
              controller.selectedClassName.value = '';
            },
            icon: Icon(Icons.delete_rounded, color: SchoolDynamicColors.activeRed),
          ),
        ],
      ),
    );
  }

  // Section list with shimmer effect and add button
  Widget _buildSectionList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SchoolSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(context),
          controller.isLoadingClasses.value
              ? _buildShimmerSectionList()
              : Obx(() => Wrap(
            runSpacing: SchoolSizes.spaceBtwItems,
            spacing: SchoolSizes.spaceBtwItems,
            children: controller.schoolClasses.map((schoolClass) {
              return SectionCard(
                section: schoolClass.section ?? '',
                classTeacherName: schoolClass.classTeacherName ?? '',
                numberOfStudents: schoolClass.students.length,
                onEdit: () => controller.showAddSectionDialog(schoolClass),
                onDelete: () => _confirmDeleteSection(schoolClass),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  // Build header row for sections with "Add Section +" button
  Widget _buildSectionHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        TextButton(
          onPressed: () => controller.showAddSectionDialog(null),
          child: Text(
            'Add Section +',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: SchoolDynamicColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  // Subject list with shimmer effect and add button
  Widget _buildSubjectList(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SchoolSizes.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSubjectHeader(context),
          controller.isLoadingClasses.value
              ? _buildShimmerSectionList()
              : Obx(() => Wrap(
            runSpacing: SchoolSizes.spaceBtwItems,
            spacing: SchoolSizes.spaceBtwItems,
            children: controller.schoolClasses
                .expand((schoolClass) => schoolClass.subjects)
                .map((subject) {
              return SubjectCard(
                subjectName: subject,
                subjectCode: '01', // Replace with actual code if available
                onDelete: () => controller.deleteSubject(subject),
              );
            }).toList(),
          )),
        ],
      ),
    );
  }

  // Build header row for subjects with "Add Subject +" button
  Widget _buildSubjectHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Subjects', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
        TextButton(
          onPressed: () {}, // Add logic to add subject
          child: Text(
            'Add Subject +',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: SchoolDynamicColors.primaryColor,
            ),
          ),
        ),
      ],
    );
  }

  // Confirmation dialog for deleting a section
  Future<void> _confirmDeleteSection(SchoolClass schoolClass) async {
    await controller.deleteClass(schoolClass.id, schoolClass.classTeacherId);
    await controller.fetchClasses('SCH0000000001', controller.selectedClassName.value);
  }

  // Build shimmer effect for loading class list
  Widget _buildShimmerClassList() {
    return Shimmer.fromColors(
      baseColor: SchoolDynamicColors.backgroundColorGreyLightGrey!,
      highlightColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey!,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            5,
                (index) => Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(width: 80, height: 24, color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Build shimmer effect for loading section list
  Widget _buildShimmerSectionList() {
    return Shimmer.fromColors(
      baseColor: SchoolDynamicColors.backgroundColorGreyLightGrey!,
      highlightColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey!,
      child: Column(
        children: List.generate(
          4,
              (index) => Column(
            children: [
              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(width: double.infinity, height: 50, color: Colors.white),
                ),
              ),
              const SizedBox(height: 8.0),
            ],
          ),
        ),
      ),
    );
  }
}

// Subject card widget for each subject in the subject list
class SubjectCard extends StatelessWidget {
  final String subjectName;
  final String subjectCode;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;

  SubjectCard({
    Key? key,
    required this.subjectName,
    required this.subjectCode,
    this.onDelete,
    this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.spaceBtwItems),
        child: Row(
          children: [
            Text(
              '$subjectName - $subjectCode',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.blue),
                onPressed: onEdit,
              ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
          ],
        ),
      ),
    );
  }
}
