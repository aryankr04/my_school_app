import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/student_routine_info.dart';
import '../../screens/management/add_student_routine.dart';

class ManageRoutineStudentController extends GetxController {
  final RxList<StudentRoutineInfo> sectionsData = <StudentRoutineInfo>[].obs;
  final RxBool isLoadingRoutine = false.obs;

  void fetchSectionsInfo(String schoolId) async {
    try {
      isLoadingRoutine(true);

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .where('schoolId', isEqualTo: schoolId)
          .get();

      List<StudentRoutineInfo> studentRoutineInfo = [];

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        final sectionId = doc.id;
        final sectionName = doc.get('sectionName') as String? ?? '';
        final className = doc.get('className') as String? ?? '';
        final classTeacherName = doc.get('classTeacherName') as String? ?? '';

        studentRoutineInfo.add(StudentRoutineInfo(
          sectionId: sectionId,
          sectionName: sectionName,
          className: className,
          classTeacherName: classTeacherName,
        ));
      }

      sectionsData.assignAll(studentRoutineInfo);
      final Map<String, int> classNameOrder = {
        'Pre Nursery': 0,
        'Nursery': 1,
        'LKG': 2,
        'UKG': 3,
        '1': 4,
        '2': 5,
        '3': 6,
        '4': 7,
        '5': 8,
        '6': 9,
        '7': 10,
        '8': 11,
        '9': 12,
        '10': 13,
        '11': 14,
        '12': 15,
      };

      // Sort the sectionsData list based on the custom order of class names
      sectionsData.sort((a, b) {
        int classOrderA = classNameOrder[a.className] ?? -1;
        int classOrderB = classNameOrder[b.className] ?? -1;

        // Compare by the custom order of class names
        if (classOrderA != classOrderB) {
          return classOrderA.compareTo(classOrderB);
        } else {
          // If class names are the same, compare by sectionName
          return a.sectionName.compareTo(b.sectionName);
        }
      });

      isLoadingRoutine(false);
    } catch (e) {
      print('Error fetching sections: $e');
      sectionsData.clear();
      isLoadingRoutine(false);
    }
  }

  void onSubmitPressed(String sectionId, String name, String className) {
    Get.to(
      AddStudentRoutine(
        sectionId: sectionId,
        name: name,
        className: className,
      ),
    );
  }
}
