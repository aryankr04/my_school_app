import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/data/services/firbase_for_section.dart';
import 'package:my_school_app/data/services/firebase_for_teachers.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../../data/services/firbase_for_class.dart';
import '../../../../../data/services/firebase_for_school.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../widgets/subject_card.dart';

class AddClassController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseForSchool firebaseFunction = FirebaseForSchool();
  FirebaseForClass firebaseForClass = FirebaseForClass();
  FirebaseForTeacher firebaseForTeachers = FirebaseForTeacher();
  FirebaseForSection firebaseForSection = FirebaseForSection();

  TextEditingController teacherName = TextEditingController();
  TextEditingController teacherUid = TextEditingController();
  TextEditingController sectionName = TextEditingController();
  List<Map<String, dynamic>> teacherList = <Map<String, dynamic>>[].obs;

  RxList<Map<String, dynamic>> sections = <Map<String, dynamic>>[].obs;
  final RxList<SubjectCard> subjectCards = <SubjectCard>[].obs;

  RxList<String> classes = <String>[].obs;
  RxString selectedClassId = ''.obs;
  RxString selectedClassName = ''.obs;

  RxBool isLoadingClass = false.obs;
  RxBool isLoadingSec = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchClasses();
  }

  Future<void> fetchData() async {
    try {
      teacherList =
          await firebaseForTeachers.fetchTeachersWithoutClass('SCH0000000001');
      // Now you can use teacherList here
      print(teacherList);
    } catch (e) {
      print('Error fetching data: $e');
    }
  }

  // Sort Class List
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

  // Fetch Classes
  Future<void> fetchClasses() async {
    isLoadingClass(true);
    classes.assignAll(await firebaseForClass.fetchClasses('SCH0000000001'));
    classes = sortClasses(classes);
    isLoadingClass(false);
  }

  //Add Class
  Future<void> addClass() async {
    await firebaseForClass.addClass('SCH0000000001');
    fetchClasses();
  }

  // Fetch Sections
  Future<void> fetchSections(String schoolId, String className) async {
    isLoadingSec(true);
    try {
      List<Map<String, dynamic>> sectionData =
          await firebaseForSection.fetchSections(schoolId, className);

      sections.assignAll(sectionData);
    } catch (e) {
      print('Error fetching sections: $e');
    }
    isLoadingSec(false);
  }

  // Fetch Teacher without Class
  Future<void> fetchTeachersWithoutClass() async {
    try {
      final teachers =
          await firebaseForTeachers.fetchTeachersWithoutClass('SCH0000000001');
      teacherList.assignAll(teachers);
      print(teacherList);
    } catch (e) {
      print('Error fetching teachers: $e');
    }
  }

  // Delete Section
  Future<void> deleteSection(String sectionId) async {
    firebaseForSection.deleteSection(sectionId);
    update();
  }

  // Delete Class with Sections at a time
  Future<void> deleteClassAndSections(String schoolId, String className) async {
    if (selectedClassName == ''.obs) {
      SchoolHelperFunctions.showErrorSnackBar('Please Select a Class');
      return;
    }
    await firebaseForClass.deleteClassAndSections(schoolId, className);

    await fetchClasses();
    await fetchSections(schoolId, className);
  }

  Future<void> showAddSectionDialog(Map<String, dynamic>? section) async {
    if (selectedClassName == '') {
      SchoolHelperFunctions.showAlertSnackBar('Please select class!');
      return;
    }
    await fetchData();

    sectionName.text = section != null
        ? section['sectionName']
        : await firebaseForSection.generateNewSectionName(
            'SCH0000000001', selectedClassName.toString());
    teacherName.text = section != null ? section['classTeacherName'] : '';

    Get.defaultDialog(
      titlePadding: const EdgeInsets.only(top: SchoolSizes.lg),
      title: section != null ? 'Edit Section' : 'Add New Section',
      content: Container(
        padding: const EdgeInsets.all(SchoolSizes.md),
        width: 500,
        child: Column(
          children: [
            SchoolTextFormField(
              labelText: 'New Section',
              controller: sectionName,
              decoration: InputDecoration(
                  filled: true, fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey),
            ),
            const SizedBox(
              height: SchoolSizes.lg,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Class Teacher',
                style: Theme.of(Get.context!)
                    .textTheme
                    .labelLarge
                    ?.copyWith(fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(
              height: SchoolSizes.sm,
            ),
            AutoCompleteTextField<Map<String, dynamic>>(
              key: GlobalKey(),
              controller: teacherName,
              clearOnSubmit: false,
              suggestions: teacherList,
              itemFilter: (item, query) {
                return item["teacherName"]
                    .toLowerCase()
                    .contains(query.toLowerCase() ?? '');
              },
              itemSorter: (a, b) {
                return a["teacherName"].compareTo(b["teacherName"]);
              },
              itemSubmitted: (item) {
                teacherName.text = item['teacherName'];
                teacherUid.text = item['uid'];
              },
              itemBuilder: (context, item) {
                return Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.all(SchoolSizes.sm),
                  color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                  child: Row(
                    children: [
                      const SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Icon(
                        Icons.school,
                        color: SchoolDynamicColors.iconColor,
                      ),
                      const SizedBox(
                        width: SchoolSizes.md + 8,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['teacherName'] ?? '',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Text(
                            item['uid'] ?? '',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              decoration: InputDecoration(
                hintStyle: Theme.of(Get.context!).textTheme.bodyLarge,
                hintText: 'Class Teacher',
                prefixIcon: Icon(
                  Icons.search,
                  color: SchoolDynamicColors.iconColor,
                ),
                filled: true,
                fillColor: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                suffixIcon: IconButton(
                  color: SchoolDynamicColors.iconColor,
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    teacherName.clear();
                  },
                ),
              ),
              textChanged: (query) {
                print(teacherList);
                // if (query.isNotEmpty) {
                //   fetchTeachersWithoutClass(query);
                //   teacherList.assignAll(teacherList.where((teacher) =>
                //   teacher['uid'] != null &&
                //       teacher['teacherName']
                //           .toLowerCase()
                //           .contains(query.toLowerCase())));
                //   print(teacherList);
                // } else {
                //   fetchTeachersWithoutClass(query);
                // }
              },
            ),
            const SizedBox(height: SchoolSizes.defaultSpace),
            ElevatedButton(
              onPressed: () async {
                if (teacherName.text == '') {
                  SchoolHelperFunctions.showErrorSnackBar(
                      'Please Select Class Teacher');
                  return;
                }
                if (section != null) {
                  await firebaseForSection.editSection(section['sectionId'], {
                    'sectionName': sectionName.text,
                    'classTeacherName': teacherName.text,
                    'classTeacherUid': teacherUid
                  });
                } else {
                  await firebaseForSection.addSection(
                      'SCH0000000001',
                      selectedClassName.value,
                      sectionName.text,
                      teacherName.text,
                      teacherUid.text);
                  teacherList.clear();
                }

                await fetchSections('SCH0000000001', selectedClassName.value);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
