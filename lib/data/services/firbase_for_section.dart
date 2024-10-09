import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/helpers/firebase_helper_function.dart';

import '../../features/manage_school/models/class_model.dart';
import '../../utils/helpers/helper_functions.dart';

class FirebaseForSection {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  //Fetch Section Id, Name, Class Teacher, Class Teacher Uid, No. of Students
  Future<List<Map<String, dynamic>>> fetchSections(
      String schoolId, String className) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('sections')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .get();

      List<Map<String, dynamic>> sections = querySnapshot.docs.map((doc) {
        return {
          'sectionId': doc.id,
          'sectionName': doc.get('sectionName') as String? ?? '',
          'classTeacherName': doc.get('classTeacherName') as String? ?? '',
          'classTeacherUid': doc.get('classTeacherUid') as String? ?? '',
          'noOfStudents': doc.get('noOfStudents') as int? ?? 0,
        };
      }).toList();

      return sections;
    } catch (e) {
      if (e is FirebaseException) {
        print('Firebase Error fetching sections: $e');
      } else {
        print('Error fetching sections: $e');
      }
      return [];
    }
  }

  //Fetch Section Name
  Future<List<String>> fetchSectionsName(
      String schoolId, String className) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('sections')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .get();

      List<String> sectionNames = querySnapshot.docs
          .map((doc) => (doc.get('sectionName') as String?) ?? '')
          .toList();

      return sectionNames;
    } catch (e) {
      print('Error fetching sections: $e');
      return [];
    }
  }

  Future<List<Map<String, String>>> fetchAllSectionsInfo(
      String schoolId) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('sections')
          .where('schoolId', isEqualTo: schoolId)
          .get();

      List<Map<String, String>> sectionsInfo = querySnapshot.docs
          .map((doc) {
        final sectionId = doc.id;
        final sectionName = doc.get('sectionName') as String? ?? '';
        return {'sectionId': sectionId, 'sectionName': sectionName};
      })
          .toList();

      return sectionsInfo;
    } catch (e) {
      print('Error fetching sections: $e');
      return [];
    }
  }


  //Add Section
  Future<void> addSection(String schoolId, String className, String sectionName, String teacherName,
      String teacherUid) async {
    try {
      SchoolHelperFunctions.showLoadingOverlay();

      // Check if the section name already exists for the given class
      bool sectionExists = await doesSectionExist(schoolId, className, sectionName);

      if (sectionExists) {
        Get.back();
        SchoolHelperFunctions.showErrorSnackBar('Section $sectionName already exists for $className');
        return;
      }

      // Generate a new section id
      String? sectionId = await FirebaseHelperFunction.generateNewIdWithPrefix(
          'SEC', 'sections');

      SchoolSection schoolSection = SchoolSection(
        schoolId: schoolId,
        sectionId: sectionId!,
        className: className,
        sectionName: sectionName,
        noOfStudents: 0,
        classTeacherName: teacherName,
        classTeacherUid: teacherUid,
      );

      // Convert the SchoolClass instance to a JSON map
      Map<String, dynamic> schoolSectionData = schoolSection.toJson();

      // Directly add the section to Firestore without checking uniqueness
      await firestore.collection('sections').doc(sectionId).set(schoolSectionData);

      DocumentReference teacherDocRef = firestore
          .collection('teachers')
          .doc(teacherUid);

      // Update the isClassTeacher field
      await teacherDocRef.update({'isClassTeacher': true});

      Get.back();
      Get.back();
      await fetchSections(schoolId, className);
      SchoolHelperFunctions.showSuccessSnackBar('Successfully added $sectionName');

      print('Section created successfully!');
    } catch (e) {
      print('Error creating section: $e');
      Get.back();

      // Handle the error, show an alert, etc.
    }
  }

// Function to check if the section already exists for the given class
  Future<bool> doesSectionExist(String schoolId, String className, String sectionName) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('sections')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .where('sectionName', isEqualTo: sectionName)
          .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print('Error checking section existence: $e');
      return false;
    }
  }





  Future<String> generateNewSectionName(String schoolId, String classId) async {
    String _incrementSectionName(String sectionName) {
      // Extract the letter from the section name
      String letter = sectionName.replaceAll(RegExp(r'[^A-Za-z]'), '');

      // Check if the section name contains only a single letter
      if (letter.length == 1) {
        // Increment the letter
        String nextLetter = String.fromCharCode(letter.codeUnitAt(0) + 1);

        // Replace the letter in the section name
        String incrementedSection = sectionName.replaceAll(letter, nextLetter);

        return incrementedSection;
      } else {
        // If the section name doesn't follow the expected format, return a default value
        return 'A';
      }
    }

    try {
      // Fetch existing sections from Firebase for a specific school and class
      List<String> existingSections =
          await fetchSectionsName(schoolId, classId);

      if (existingSections.isEmpty) {
        return 'A';
      }

      // Sort existing sections to find the last one
      existingSections.sort();

      // Extract the last section and increment its letter
      String lastSection = existingSections.last;
      String newSection = _incrementSectionName(lastSection);

      return newSection;
    } catch (e) {
      print('Error generating new section name: $e');
      return 'A'; // Default value if there's an error
    }
  }

  //Edit Section
  Future<void> editSection(
      String sectionId, Map<String, dynamic> updatedSectionData) async {
    try {
      // Assuming firestore is your FirebaseFirestore instance
      await firestore
          .collection('sections')
          .doc(sectionId)
          .update(updatedSectionData);
      print('Section updated successfully!');
    } catch (e) {
      print('Error updating section: $e');
    }
  }

  //Delete Section
  Future<void> deleteSection(String sectionId) async {
    try {
      // Assuming firestore is your FirebaseFirestore instance
      DocumentSnapshot sectionSnapshot = await firestore.collection('sections').doc(sectionId).get();

      // Get the classTeacherId from the section document
      Map<String, dynamic>? data = sectionSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        String? classTeacherId = data['classTeacherUid'] as String?;

        if (classTeacherId != null) {
          // Update the corresponding teacher document's isClassTeacher field to false
          await firestore.collection('teachers').doc(classTeacherId).update({'isClassTeacher': false});
        }
      }

      // Delete the section document
      await firestore.collection('sections').doc(sectionId).delete();

      print('Section deleted successfully!');
    } catch (e) {
      print('Error deleting section: $e');
    }
  }

}
