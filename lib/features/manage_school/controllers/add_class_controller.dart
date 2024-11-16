import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/confirmationDialog.dart';
import 'package:my_school_app/common/widgets/custom_button.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/data/repositories/school_class_repository.dart';
import 'package:my_school_app/data/services/firbase_for_section.dart';
import 'package:my_school_app/data/services/firebase_for_teachers.dart';
import 'package:my_school_app/features/manage_school/models/school_class.dart';
import 'package:my_school_app/utils/helpers/firebase_helper_function.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import '../../../../../data/services/firbase_for_class.dart';
import '../../../../../data/services/firebase_for_school.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../data/services/firebase/firbase_services.dart';
import '../../manage_routine/models/class_routine0.dart';
import '../widgets/subject_card.dart';

class AddClassController extends GetxController {
  // Firebase instances
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final SchoolClassRepository schoolClassRepository = SchoolClassRepository();
  final FirebaseForTeacher firebaseForTeachers = FirebaseForTeacher();

  // Controllers for form fields
  TextEditingController teacherName = TextEditingController();
  TextEditingController teacherId = TextEditingController();
  TextEditingController sectionName = TextEditingController();

  // Lists for storing teachers and school classes
  RxList<Map<String, dynamic>> teacherList = <Map<String, dynamic>>[].obs;
  final RxList<SubjectCard> subjectCards = <SubjectCard>[].obs;
  RxList<SchoolClass> schoolClasses = <SchoolClass>[].obs;
  RxList<String> classNames = <String>[].obs;

  // Reactive variables for selected class and loading states
  RxString selectedClassId = ''.obs;
  RxString selectedClassName = ''.obs;
  RxBool isLoadingClassNames = false.obs;
  RxBool isLoadingClasses = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClassNames();
  }

  Future<void> deleteSubject(String subjectName) async {
    try {
      await CustomConfirmationDialog.show(DialogAction.Delete,
          onConfirm: () async {
        // Reference to the class document in Firestore
        DocumentReference classDocRef = FirebaseFirestore.instance
            .collection('classes') // Classes collection
            .doc(selectedClassId.value); // Class document ID

        // Fetch the current class data
        DocumentSnapshot classDoc = await classDocRef.get();

        if (classDoc.exists) {
          // Check if 'subjects' exists and is a list
          if (classDoc['subjects'] is List) {
            // Get the current subjects list
            List<String> subjects = List<String>.from(classDoc['subjects']);

            // Check if the subject exists in the list
            if (subjects.contains(subjectName)) {
              // Remove the subject from the list
              subjects.remove(subjectName);

              // Update the class document with the new subjects list
              await classDocRef.update({'subjects': subjects});

              print("Subject '$subjectName' has been removed.");
            } else {
              print("Subject '$subjectName' not found in the list.");
            }
          } else {
            print("Subjects field is not a list in the Firestore document.");
          }
        } else {
          print("Class document does not exist.");
        }
      });
    } catch (e) {
      print('Error deleting subject: $e');
    }
  }

  Future<void> fetchTeachersWithoutClass() async {
    try {
      // Use assignAll to assign the list to an RxList
      teacherList.assignAll(
          await firebaseForTeachers.fetchTeachersWithoutClass('SCH0000000001'));
      print(teacherList); // Print fetched teacher list
    } catch (e) {
      print('Error fetching teachers: $e');
    }
  }

  // Sort the list of classes according to a specific order
  RxList<String> sortClasses(RxList<String> classes) {
    List<String> sortingSequence = ['Pre Nursery', 'Nursery', 'LKG', 'UKG'];
    sortingSequence
        .addAll(List.generate(12, (index) => (index + 1).toString()));

    classes.sort((a, b) {
      int indexA = sortingSequence.indexOf(a);
      int indexB = sortingSequence.indexOf(b);

      if (indexA != -1 && indexB != -1) return indexA.compareTo(indexB);
      if (indexA != -1) return -1;
      if (indexB != -1) return 1;
      return classes.indexOf(a).compareTo(classes.indexOf(b));
    });

    return classes;
  }

  // Fetch class names from the school document
  Future<void> fetchClassNames() async {
    isLoadingClassNames(true);
    try {
      classNames.assignAll(await schoolClassRepository
          .fetchClassNamesFromSchoolDoc('SCH0000000001'));
      classNames = sortClasses(classNames);
    } catch (e) {
      print('Error fetching class names: $e');
    }
    isLoadingClassNames(false);
  }

  // Add new class name to school document
  Future<void> addClassName() async {
    if (classNames.length == 16) {
      SchoolHelperFunctions.showErrorSnackBar('Cannot add class above 12');
      return;
    }
    await schoolClassRepository.addClassNameInSchoolDoc('SCH0000000001');
    fetchClassNames();
  }

  // Fetch classes by school ID and class name
  Future<void> fetchClasses(String schoolId, String className) async {
    isLoadingClasses(true);
    try {
      schoolClasses.assignAll(await schoolClassRepository
          .getAllSchoolClassesBySchoolId(schoolId, className));
    } catch (e) {
      print('Error fetching classes: $e');
    }
    isLoadingClasses(false);
  }

  Future<void> deleteClassName(String schoolId, String className) async {
    try {
      // Reference to the 'schools' collection
      CollectionReference schoolsCollection = firestore.collection('schools');

      // Get the document reference for the specified school
      DocumentReference schoolDocRef = schoolsCollection.doc(schoolId);

      // Update the 'classes' field by removing the specified class
      await schoolDocRef.update({
        'classes': FieldValue.arrayRemove([className]),
      });

      print('Class deleted successfully!');
    } catch (e) {
      print('Error deleting class: $e');
    }
  }

  // Delete a specific class
  Future<void> deleteClass(String classId, String teacherId) async {
    await CustomConfirmationDialog.show(DialogAction.Delete,
        onConfirm: () async {
      await schoolClassRepository.deleteSchoolClass(classId, teacherId);
      Get.back();
    });
  }

  // Delete all classes for a specific class name and school
  Future<void> deleteClassesAndClassName(
      String schoolId, String className) async {
    if (selectedClassName.isEmpty) {
      SchoolHelperFunctions.showErrorSnackBar('Please Select a Class');
      return;
    }
    if (schoolClasses.isNotEmpty) {
      await CustomConfirmationDialog.show(DialogAction.Delete,
          onConfirm: () async {
        await schoolClassRepository.deleteAllClasses(schoolClasses);
      });
    } else {
      schoolClassRepository.removeClassNameFromSchoolDoc(schoolId, className);
    }
    await fetchClassNames();
    await fetchClasses(schoolId, className);
  }

  // Show dialog to add or edit a section
  Future<void> showAddSectionDialog(SchoolClass? schoolClass) async {
    if (selectedClassName.isEmpty) {
      SchoolHelperFunctions.showAlertSnackBar('Please select class!');
      return;
    }

    // Fetch teachers only if not already fetched
    await fetchTeachersWithoutClass();


    // Pre-fill form if schoolClass is provided
    sectionName.text = schoolClass?.section ??
        await schoolClassRepository.generateNewSectionName(
            'SCH0000000001', selectedClassName.value);
    teacherName.text = schoolClass?.classTeacherName ?? '';
    teacherId.text = schoolClass?.classTeacherId ?? ''; // Set teacherId if editing

    // Show the dialog
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          title: Text(schoolClass == null ? 'Add Section' : 'Update Section'),
          content: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(SchoolSizes.md - 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Section Name Text Field
                  SchoolTextFormField(
                    labelText: 'New Section',
                    controller: sectionName,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                    ),
                  ),
                  const SizedBox(height: SchoolSizes.lg),

                  // Class Teacher Input
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Class Teacher',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: SchoolSizes.sm),

                  // AutoComplete for Teacher
                  AutoCompleteTextField<Map<String, dynamic>>(
                    key: GlobalKey(),
                    controller: teacherName,
                    clearOnSubmit: false,
                    suggestions: teacherList,
                    itemFilter: (item, query) {
                      return item["teacherName"]
                          .toLowerCase()
                          .contains(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a["teacherName"].compareTo(b["teacherName"]);
                    },
                    itemSubmitted: (item) {
                      teacherName.text = item['teacherName'];
                      teacherId.text = item['uid'];
                    },
                    itemBuilder: (context, item) {
                      return Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(SchoolSizes.sm),
                        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                        child: Row(
                          children: [
                            const SizedBox(width: SchoolSizes.md),
                            Icon(Icons.school,
                                color: SchoolDynamicColors.iconColor),
                            const SizedBox(width: SchoolSizes.md + 8),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item['teacherName'] ?? '',
                                    style: Theme.of(context).textTheme.bodyLarge),
                                Text(item['uid'] ?? '',
                                    style: Theme.of(context).textTheme.bodySmall),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    decoration: InputDecoration(
                      hintText: 'Class Teacher',
                      prefixIcon: Icon(Icons.search,
                          color: SchoolDynamicColors.iconColor),
                      filled: true,
                      fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          teacherName.clear();
                          teacherId.clear();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: SchoolSizes.defaultSpace),

                  // Save Button
                  ElevatedButton(
                    onPressed: () async {
                      if (teacherName.text.isEmpty) {
                        SchoolHelperFunctions.showErrorSnackBar(
                            'Please select class teacher.');
                        return;
                      }

                      // Generate new ID for new class or use existing school class ID
                      String id = schoolClass?.id ??
                          await schoolClassRepository.generateNewSchoolClassId() ?? '';

                      if (schoolClass == null) {
                        // Add new section
                        await schoolClassRepository.addSchoolClass(SchoolClass(
                          id: id,
                          schoolId: 'SCH0000000001',
                          className: selectedClassName.value,
                          section: sectionName.text,
                          roomNumber: '',
                          classTeacherId: teacherId.text,
                          classTeacherName: teacherName.text,
                          teachers: [],
                          subjects: [],
                          students: [],
                          routine: Routine(
                            id: '', // Empty ID initially
                            classId: '', // Default class ID
                            className: '', // Default class name
                            section: '', // Default section
                            days: {}, // Empty map for days
                          ),
                          attendanceByDate: {}
                        )
                        );
                      } else {
                        // Update section details
                        schoolClass!.section = sectionName.text;
                        schoolClass.classTeacherName = teacherName.text;
                        schoolClass.classTeacherId = teacherId.text;

                        // Update the document in the repository
                        await schoolClassRepository.updateSchoolClass(schoolClass);
                      }

                      await fetchClasses(schoolClass?.schoolId ?? 'SCH0000000001', selectedClassName.value);
                      Get.back(); // Close the dialog after saving
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: SchoolDynamicColors.primaryColor),
                    child: Text(
                        schoolClass == null ? 'Add Section' : 'Update Section'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
