import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../utils/helpers/helper_functions.dart';

class FirebaseForClass {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<List<String>> fetchClasses(String schoolId) async {
    CollectionReference schoolsCollection = firestore.collection('schools');
    DocumentSnapshot schoolDoc = await schoolsCollection.doc(schoolId).get();
    DocumentReference schoolDocRef = schoolsCollection.doc(schoolId);
    if (schoolDoc.exists) {
      List<String> classList = List<String>.from(schoolDoc['classes'] ?? []);
      return classList;
    }
    return [];
  }

  Future<void> addClass(String schoolId) async {
    String getNextClass(List<String> classes) {
      List<String> classSequence = ['Pre Nursery', 'Nursery', 'LKG', 'UKG'];

      for (int i = 1; i <= 12; i++) {
        classSequence.add(i.toString());
      }
      String nextClass = classSequence.firstWhere(
          (className) => !classes.contains(className),
          orElse: () => '');
      return nextClass;
    }

    try {
      // Check the existing classes in the school
      SchoolHelperFunctions.showLoadingOverlay();

      CollectionReference schoolsCollection = firestore.collection('schools');
      DocumentSnapshot schoolDoc = await schoolsCollection.doc(schoolId).get();
      DocumentReference schoolDocRef = schoolsCollection.doc(schoolId);
      if (schoolDoc.exists) {
        List<String> classList = List<String>.from(schoolDoc['classes'] ?? []);

        String nextClassName = getNextClass(classList);
        await schoolDocRef.update({
          'classes': FieldValue.arrayUnion([nextClassName]),
        });
      }

      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar('Class added successfully: ');
      print('Class added successfully: ');
    } catch (e) {
      print('Error adding class: $e');
      // Handle the error, show a message to the user, etc.
    }
  }

  //Delete Class along with all Sections
  Future<void> deleteClassAndSections(String schoolId, String className) async {
    try {
      SchoolHelperFunctions.showLoadingOverlay();

      // Step 1: Delete Sections
      await deleteSections(schoolId, className);

      // Step 2: Delete Class
      await deleteClass(schoolId, className);

      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
          'Class and sections deleted successfully!');
      print('Class and sections deleted successfully!');
    } catch (e) {
      print('Error deleting class and sections: $e');
    }
  }

  //Delete Each Sections
  //Delete Each Sections
//Delete Each Sections
//Delete Each Sections
  Future<void> deleteSections(String schoolId, String className) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('sections')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .get();

      List<String> teacherIds = [];
      querySnapshot.docs.forEach((doc) {
        // Casting doc.data() to Map<String, dynamic> to access fields using the [] operator
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        var classTeacherId = data['classTeacherUid'] as String?;
        if (classTeacherId != null) {
          teacherIds.add(classTeacherId);
        }
      });

      teacherIds.forEach((teacherId) async {
        if (teacherId != null) {
          await FirebaseFirestore.instance
              .collection('teachers')
              .doc(teacherId)
              .update({'isClassTeacher': false});
        }
      });

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await FirebaseFirestore.instance
            .collection('sections')
            .doc(doc.id)
            .delete();
      }

      print('Sections deleted successfully!');
    } catch (e) {
      print('Error deleting sections: $e');
    }
  }

  //Delete Class
  Future<void> deleteClass(String schoolId, String className) async {
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
}
