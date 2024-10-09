import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

import '../../../../../utils/helpers/helper_functions.dart';
import '../models/student_attendance.dart';

class SubmitAttendanceController extends GetxController {
  void countPresentStudents() {
    presentStudentsCount.value = studentAttendanceList
        .where((student) => student.isPresent.value)
        .length;
    update();
  }

  void countAbsentStudents() {
    absentStudentsCount.value = studentAttendanceList
        .where((student) => !student.isPresent.value)
        .length;
    update();
  }

  void countTotalStudents() {
    totalStudentsCount.value = studentAttendanceList.length;
    update();
  }

  void sortStudentAttendanceListByRoll() {
    studentAttendanceList.sort((a, b) => a.roll.compareTo(b.roll));
    update();
  }

  bool areAllStudentsPresent() {
    return studentAttendanceList.every((student) => student.isPresent.value);
  }

  bool areAllStudentsAbsent() {
    return studentAttendanceList.every((student) => !student.isPresent.value);
  }

  RxInt presentStudentsCount = 1.obs;
  RxInt absentStudentsCount = 1.obs;
  RxInt totalStudentsCount = 1.obs;

  late RxBool isPresentAll = RxBool(false);

  void toggleAttendanceForStudent(String studentId) {
    var studentIndex = studentAttendanceList
        .indexWhere((student) => student.studentId == studentId);
    if (studentIndex != -1) {
      studentAttendanceList[studentIndex].isPresent.value =
          !studentAttendanceList[studentIndex].isPresent.value;
      update(); // Notify GetX that the state has changed
      // Trigger vibration for 1 second
      Vibration.vibrate(duration: 100);
// HapticFeedback.heavyImpact();
    }
    compareListsAndSetChange();
    //print(isChange.value);


  }

  // New method to toggle attendance for all students
  void toggleAttendanceForAll(bool markPresent) {
    for (var student in studentAttendanceList) {
      student.isPresent.value = markPresent;
    }
    Vibration.vibrate(duration: 100);

    update();
    compareListsAndSetChange();

  }

  RxList<StudentAttendance> studentAttendanceList = <StudentAttendance>[].obs;
  static List<StudentAttendance> studentAttendanceListMain = <StudentAttendance>[];
  RxBool isChange = false.obs;


  void compareListsAndSetChange() {
    // Check if the lengths of both lists are different
    if (studentAttendanceList.length != studentAttendanceListMain.length) {
      // If lengths are different, set isChange to true and return
      isChange.value = true;
      return;
    }

    // Debugging print for the length of the lists
    print(studentAttendanceList[0].isPresent);
    print(studentAttendanceListMain[0].isPresent);

    // Iterate through each element in the lists
    for (int i = 0; i < studentAttendanceList.length; i++) {
      // Compare the 'isPresent' property of each StudentAttendance object
      if (studentAttendanceList[i].isPresent.value !=
          studentAttendanceListMain[i].isPresent.value) {
        // If any 'isPresent' property is different, set isChange to true and return
        // print(studentAttendanceList[i].isPresent.value); // Debugging print
        // print(studentAttendanceListMain[i].isPresent.value); // Debugging print
        isChange.value = true;
        return;
      }
    }

    // If we finish iterating through the lists without finding any differences,
    // set isChange to false
    isChange.value = true;
  }


  Future<bool> getStudentAttendance(
      String classId, String studentId, String formattedDate) async {
    try {
      // Create a reference to the document for the specified date
      var dateReference = FirebaseFirestore.instance
          .collection('attendance')
          .doc(classId)
          .collection('students')
          .doc(studentId)
          .collection('dates')
          .doc(formattedDate);

      // Get the document snapshot
      var dateSnapshot = await dateReference.get();

      if (dateSnapshot.exists) {
        // If the document exists, return the 'present' field
        return dateSnapshot.data()?['present'] ?? false;
      } else {
        // If the document doesn't exist, return false (student was absent)
        return false;
      }
    } catch (e) {
      print(
          'Error getting student attendance for $studentId on $formattedDate: $e');
      return false;
    }
  }

  RxBool isLoadingAttendance = false.obs;

  Future<void> fetchClassAttendance(
      String sectionId, String formattedDate,String sectionName,String schoolId,String className,) async {
    try {
      isLoadingAttendance(true);
      // Query to get all students under the specified class
      var studentsQuery = await FirebaseFirestore.instance
          .collection('students')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className).where('sectionName',isEqualTo: sectionName)
          .get();

      // if (studentsQuery.docs.isEmpty) {
      //   print('No students found for class $sectionId');
      //   fetchAllStudents(sectionId);
      //   isLoadingAttendance(false);
      //   return;
      // }

      List<StudentAttendance> allStudentsList = [];

      // Iterate through each student
      for (var studentDoc in studentsQuery.docs) {
        String studentId = studentDoc.id;

        // Fetch attendance for the student on the specified date
        bool isPresent =
            await getStudentAttendance(sectionId, studentId, formattedDate);

        // Fetch student details
        var studentDetailsSnapshot = await FirebaseFirestore.instance
            .collection('students')
            .doc(studentId)
            .get();

        String studentName =
            studentDetailsSnapshot.data()?['studentName'] ?? 'Student Name';
        String studentRoll = studentDetailsSnapshot.data()?['rollNo'] ?? 'Roll';

        // Create a new StudentAttendance object and add it to the list
        allStudentsList.add(StudentAttendance(
          studentId: studentId,
          name: studentName,
          roll: studentRoll,
          initialIsPresent: isPresent,
        ));
      }

      // Clear the existing data and assign the updated list
      studentAttendanceList.clear();
      studentAttendanceList.assignAll(allStudentsList);
      countTotalStudents();
      countAbsentStudents();
      countPresentStudents();
      sortStudentAttendanceListByRoll();
      studentAttendanceListMain.assignAll(allStudentsList);


      // Notify GetX that the state has changed
      update();

      isLoadingAttendance(false);
    } catch (e) {
      print(
          'Error fetching attendance for all students in class $sectionId on $formattedDate: $e');
    }
  }

  Future<void> fetchAllStudents(String classId) async {
    try {
      var snapshot = await FirebaseFirestore.instance
          .collection(
              'students') // Replace with your "students" collection name
          .get();

      List<StudentAttendance> allStudentsList = [];

      if (snapshot.docs.isNotEmpty) {
        for (var studentDoc in snapshot.docs) {
          Map<String, dynamic>? studentData =
              studentDoc.data() as Map<String, dynamic>?;

          if (studentData != null) {
            String studentId = studentDoc.id;

            // Replace 'username' and 'rollNo' with the actual field names in your document
            String name = studentData['studentName'] ?? 'Student Name';
            String roll = studentData['rollNo'] ?? 'Roll';

            // Create a new StudentAttendance object and add it to the list
            allStudentsList.add(StudentAttendance(
              studentId: studentId,
              name: name,
              roll: roll,
              initialIsPresent: false, // Default value for 'present' field
            ));
            print(allStudentsList[0].studentId);
          }
        }
      }

      // Clear the existing data and assign the updated list
      studentAttendanceList.clear();
      studentAttendanceList.assignAll(allStudentsList);
      sortStudentAttendanceListByRoll();

      update(); // Notify GetX that the state has changed
    } catch (e) {
      print('Error fetching all students for $classId: $e');
    }
  }

  Future<void> updateStudentAttendance(String sectionId, String studentId,
      String currentDate, bool isPresent) async {
    try {
      // Create a reference to the document for the specified date
      var dateReference = FirebaseFirestore.instance
          .collection('attendance')
          .doc(sectionId)
          .collection('students')
          .doc(studentId)
          .collection('dates')
          .doc(currentDate);

      // Check if the document already exists
      var dateSnapshot = await dateReference.get();

      if (dateSnapshot.exists) {
        // If the document exists, update the 'present' field
        await dateReference.update({'present': isPresent,'date':currentDate});
      } else {
        // If the document doesn't exist, create a new document with the 'present' field
        await dateReference.set({'present': isPresent,'date':currentDate});
      }

      print(
          'Attendance for student $studentId on $currentDate updated successfully!');
    } catch (e) {
      print(
          'Error updating student attendance for $studentId on $currentDate: $e');
    }
  }

  Future<void> updateAllStudentAttendance(String sectionId) async {
    if(studentAttendanceList.isEmpty){
      SchoolHelperFunctions.showErrorSnackBar('There is no student in this section !');
      return;
    }

    String currentDate = SchoolHelperFunctions.getTodayDate();



    try {
      await Future.forEach(studentAttendanceList, (student) async {
        await updateStudentAttendance(sectionId, student.studentId,
            currentDate, student.isPresent.value);
      });

      String teacherName = '';
      String teacherId = 'TEA0000000001';

      CollectionReference teachersCollection =
          await FirebaseFirestore.instance.collection('teachers');
      DocumentSnapshot schoolDoc =
          await teachersCollection.doc(teacherId).get();
      if (schoolDoc.exists) {
        teacherName = schoolDoc['teacherName'];
        teacherId = schoolDoc['uid'];
      }
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc(sectionId) // Replace with your class ID
          .collection('dates')
          .doc(currentDate)
          .set({
        'isClassAttendanceSubmitted': true,
        'totalPresentStudents': presentStudentsCount.value,
        'totalAbsentStudents': absentStudentsCount.value,
        'teacherName': teacherName,
        'teacherId': teacherId
      });

      SchoolHelperFunctions.showSuccessSnackBar(
          'Attendance for all students updated successfully!');
      print('Attendance for all students updated successfully!');
      //fetchClassAttendance(sectionId, formattedDate, sectionName, schoolId, className)
    } catch (e) {
      SchoolHelperFunctions.showSuccessSnackBar(
          'Error updating attendance: $e');
      print('Error updating attendance: $e');
    }
  }
}
