import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/common/widgets/elevated_button.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/date_and_time.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/text_form_feild.dart';
import '../../../../data/services/firbase_for_class.dart';
import '../../../../utils/constants/dynamic_colors.dart';

class AddNoticeNew extends StatefulWidget {
  const AddNoticeNew({super.key});

  @override
  State<AddNoticeNew> createState() => _AddNoticeNewState();
}

class _AddNoticeNewState extends State<AddNoticeNew> {
  TextEditingController titleController = TextEditingController();

  TextEditingController descriptionController = TextEditingController();

  RxBool isLoading = false.obs;
  RxList<String> selectedRoutineFor = <String>[].obs;
  RxList<String> selectedRoutineForClass = <String>[].obs;

  RxList<String> routineFor = <String>[
    'Student',
    'Teacher',
    'Management',
    'Principal',
    'Director',
    'Staff',
    'Driver'
  ].obs;
  RxList<String> routineForClass = <String>[].obs;
  RxBool isAllSelectedRoutineFor = false.obs;
  RxBool wasStudentSelected = false.obs; // Track previous selection state


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchClasses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: SchoolSizes.spaceBtwSections),
              Text(
                "Routine For",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
              ),
              SizedBox(height: SchoolSizes.md),
              MultiSelectionWidget(
                options: routineFor.value,
                onSelectionChanged: (selectedOptions) {
                  final bool isStudentSelected = selectedOptions.contains('Student');

                  if (!isStudentSelected && wasStudentSelected.value) {
                    // "Student" option is deselected, clear selectedRoutineForClass
                    selectedRoutineForClass.clear();
                  }

                  wasStudentSelected.value = isStudentSelected; // Update previous selection state
                  selectedRoutineFor.value = selectedOptions;
                },
              ),
              Obx(() {
                if (selectedRoutineFor.contains('Student')) {
                  return Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SchoolSizes.spaceBtwSections),
                      Text(
                        "Routine For Class",
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 18),
                      ),
                      SizedBox(height: SchoolSizes.md),
                      MultiSelectionWidget(
                        options: routineForClass.value,
                        onSelectionChanged: (selectedOptions) {
                          selectedRoutineForClass.value = selectedOptions;
                        },
                      ),
                    ],
                  );
                } else {
                  return SizedBox();
                }
              }),
              SizedBox(height: SchoolSizes.spaceBtwSections),
              SchoolTextFormField(
                labelText: 'Title',
                controller: titleController,
              ),
              SizedBox(height: SchoolSizes.lg),
              SchoolTextFormField(
                labelText: 'Description',
                controller: descriptionController,
              ),
              SizedBox(height: SchoolSizes.lg),
              SchoolElevatedButton(
                text: 'Post',
                onPressed: () {

                  sendNoticeToFirebase();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  RxList<String> sortClasses(RxList<String> classes) {
    // Define the sorting sequence
    List<String> sortingSequence = ['Pre Nursery', 'Nursery', 'LKG', 'UKG'];
    for (int i = 1; i <= 12; i++) {
      sortingSequence.add(i.toString());
    }

    // Custom comparator to sort the classes based on the sorting sequence
    classes.sort((a, b) {
      int indexA = sortingSequence.indexOf(a);
      int indexB = sortingSequence.indexOf(b);

      // If both elements are found in the sequence, compare their indices
      if (indexA != -1 && indexB != -1) {
        return indexA.compareTo(indexB);
      }

      // If one element is found and the other is not, prioritize the one found
      if (indexA != -1) {
        return -1;
      } else if (indexB != -1) {
        return 1;
      }

      // If neither element is found, maintain their original order
      return classes.indexOf(a).compareTo(classes.indexOf(b));
    });

    return classes;
  }

  RxBool isLoadingClass=false.obs;
  FirebaseForClass firebaseForClass = FirebaseForClass();

  // Fetch Classes
  Future<void> fetchClasses() async {
    isLoadingClass(true);
    routineForClass.assignAll(await firebaseForClass.fetchClasses('SCH0000000001'));
    routineForClass = sortClasses(routineForClass);
    isLoadingClass(false);
  }


  // Function to send a notice to Firebase Firestore
  Future<void> sendNoticeToFirebase() async {
    try {
      // Access Firestore instance
      SchoolHelperFunctions.showLoadingOverlay();
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Create a map containing the notice data
      Map<String, dynamic> noticeData = {
        'date': SchoolDateAndTimeFunction.getCurrentDate(),
        'time': SchoolDateAndTimeFunction.getCurrentTime(),
        'title': titleController.text,
        'description': descriptionController.text,
        'teacherId': "TEA0000000001", // Replace with actual teacher ID
        'forClass': selectedRoutineForClass.value,
        'schoolId': 'SCH0000000001',
        'forUser': selectedRoutineFor.value,
      };

      // Add the notice data to the 'notices' collection without specifying document ID
    await firestore.collection('notices').add(noticeData);

      // Get the generated document ID
      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
          'Notice sent to Firebase successfully');
      print('Notice sent to Firebase successfully');
      titleController.clear();
      descriptionController.clear();
    } catch (error) {
      print('Error sending notice to Firebase: $error');
      // Handle the error appropriately, e.g., show an error message to the user
    }
  }

}

class MultiSelectionWidget extends StatefulWidget {
  final List<String> options;
  final Function(List<String>) onSelectionChanged;

  MultiSelectionWidget({
    required this.options,
    required this.onSelectionChanged,
  });

  @override
  _MultiSelectionWidgetState createState() => _MultiSelectionWidgetState();
}

class _MultiSelectionWidgetState extends State<MultiSelectionWidget> {
  List<bool> _isSelected = [];
  late RxBool isSelectedAll;

  @override
  void initState() {
    super.initState();
    _isSelected = List<bool>.filled(widget.options.length, false);
    isSelectedAll = false.obs; // Initialize isSelectedAll as RxBool
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12, // Adjust spacing as needed
      runSpacing: 12, // Adjust run spacing as needed
      children: [
        // Option to select all
        InkWell(
          onTap: () {
            setState(() {
              // Toggle selection state for all options
              for (int i = 0; i < _isSelected.length; i++) {
                _isSelected[i] = !isSelectedAll.value;
              }
              widget.onSelectionChanged(_getSelectedOptions());
              isSelectedAll
                  .toggle(); // Toggle isSelectedAll using GetX toggle method
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: SchoolSizes.xs,
              horizontal: SchoolSizes.sm + 4,
            ),
            decoration: BoxDecoration(
              color: isSelectedAll.value
                  ? SchoolDynamicColors.primaryColor
                  : SchoolDynamicColors.backgroundColorGreyLightGrey,
              borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
            ),
            child: Text(
              'All',
              style: TextStyle(
                fontSize: 14,
                color: isSelectedAll.value
                    ? SchoolDynamicColors.white
                    : SchoolDynamicColors.subtitleTextColor,
                fontWeight:
                    isSelectedAll.value ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ),
        ),
        // Options list
        ...List.generate(
          widget.options.length,
          (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  _isSelected[index] = !_isSelected[index];
                  widget.onSelectionChanged(_getSelectedOptions());
                  // Check if all options are selected
                  isSelectedAll.value =
                      _isSelected.every((isSelected) => isSelected);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: SchoolSizes.xs,
                  horizontal: SchoolSizes.sm + 4,
                ),
                decoration: BoxDecoration(
                  color: _isSelected[index]
                      ? SchoolDynamicColors.primaryColor
                      : SchoolDynamicColors.backgroundColorGreyLightGrey,
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
                  border: Border.all(
                    color: _isSelected[index]
                        ? SchoolDynamicColors.primaryColor
                        : Colors.transparent,
                    width: _isSelected[index] ? 0 : 0.0,
                  ),
                ),
                child: Text(
                  widget.options[index],
                  style: TextStyle(
                    fontSize: 14,
                    color: _isSelected[index]
                        ? SchoolDynamicColors.white
                        : SchoolDynamicColors.subtitleTextColor,
                    fontWeight:
                        _isSelected[index] ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Get the list of selected options
  List<String> _getSelectedOptions() {
    List<String> selectedOptions = [];
    for (int i = 0; i < _isSelected.length; i++) {
      if (_isSelected[i]) {
        selectedOptions.add(widget.options[i]);
      }
    }
    return selectedOptions;
  }
}

class NoticeData {
  final String id; // Add id field
  final String date;
  final String time;
  final String title;
  final String description;
  final String teacherId;
  final List<String> forClass;
  final String schoolId;
  final List<String> forUser;

  NoticeData({
    required this.id, // Initialize id field
    required this.date,
    required this.time,
    required this.title,
    required this.description,
    required this.teacherId,
    required this.forClass,
    required this.schoolId,
    required this.forUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id, // Add id to the map
      'date': date,
      'time': time,
      'title': title,
      'description': description,
      'teacherId': teacherId,
      'forClass': forClass,
      'schoolId': schoolId,
      'forUser': forUser,
    };
  }

  static String formatDate(DateTime dateTime) {
    return DateFormat("dd MMM yyyy").format(dateTime);
  }
}
