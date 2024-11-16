import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../features/manage_school/models/school_class.dart';
import '../../utils/helpers/helper_functions.dart';
import '../services/firebase/firbase_services.dart';

class SchoolClassRepository {
  final FirebaseService _firebaseService = FirebaseService();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Add a new School Class
  Future<void> addSchoolClass(SchoolClass schoolClass) async {
    try {
      await _firebaseService.addDocument(
          'schoolClasses', schoolClass.id, schoolClass.toJson());
      await _firebaseService.updateDocument(
          'teachers', schoolClass.classTeacherId, {'isClassTeacher': true});
    } catch (e) {
      print("Error adding school class: $e");
      rethrow;
    }
  }

  // Update an existing School Class
  Future<void> updateSchoolClass(SchoolClass schoolClass) async {
    try {
      await _firebaseService.updateDocument(
          'schoolClasses', schoolClass.id, schoolClass.toJson());
    } catch (e) {
      print("Error updating school class: $e");
      rethrow;
    }
  }

  // Get a specific School Class by ID
  Future<SchoolClass?> getSchoolClass(String id) async {
    try {
      DocumentSnapshot snapshot =
          await _firebaseService.getDocument('schoolClasses', id);
      if (snapshot.exists) {
        return SchoolClass.fromJson(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print("Error getting school class: $e");
      rethrow;
    }
  }

  // Get all School Classes by schoolId
  Future<List<SchoolClass>> getAllSchoolClassesBySchoolId(
      String schoolId, String className) async {
    try {
      // Query Firestore for schoolClasses that match the given schoolId
      QuerySnapshot snapshot = await _firebaseService
          .getDocumentsByConditions(collection: 'schoolClasses', conditions: [
        {'field': 'schoolId', 'value': schoolId},
        {'field': 'className', 'value': className}
      ]);

      return snapshot.docs
          .map(
              (doc) => SchoolClass.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print("Error getting all school classes by schoolId: $e");
      rethrow;
    }
  }

  // Delete a School Class by ID
  Future<void> deleteSchoolClass(String id, String teacherId) async {
    try {
      await _firebaseService.deleteDocument('schoolClasses', id);

      await _firebaseService
          .updateDocument('teachers', teacherId, {'isClassTeacher': false});
    } catch (e) {
      print("Error deleting school class: $e");
      rethrow;
    }
  }

  Future<void> deleteAllClasses(RxList<SchoolClass> schoolClasses) async {
    try {
      // Iterate over each school class and delete it

      for (var schoolClass in schoolClasses) {
        // Call the deleteSchoolClass function with the school class ID and teacher ID
        await deleteSchoolClass(schoolClass.id, schoolClass.classTeacherId);
      }
      await removeClassNameFromSchoolDoc(
          schoolClasses[0].schoolId, schoolClasses[0].className);
      // Optionally, you can clear the RxList after deletion

      print("All classes deleted successfully.");
    } catch (e) {
      print("Error deleting all classes: $e");
      rethrow;
    }
  }

  // Generate a new School Class ID with a prefix
  Future<String?> generateNewSchoolClassId() async {
    try {
      return await _firebaseService.generateNewIdWithPrefix(
          'CLA', 'schoolClasses');
    } catch (e) {
      print("Error generating new school class ID: $e");
      return null;
    }
  }

  Future<List<String>> fetchClassNamesFromSchoolDoc(String schoolId) async {
    try {
      // Get the document for the specific school
      DocumentSnapshot schoolDoc =
          await firestore.collection('schools').doc(schoolId).get();

      if (schoolDoc.exists) {
        // Extract class names as a list of strings, providing a default empty list if no classes exist
        return List<String>.from(schoolDoc.get('classes') ?? []);
      }
    } catch (e) {
      print("Error fetching classes from school document: $e");
    }

    return [];
  }

  Future<void> addClassNameInSchoolDoc(String schoolId) async {
    String getNextClass(List<String> classes) {
      // Define class sequence
      List<String> classSequence = ['Pre Nursery', 'Nursery', 'LKG', 'UKG'];

      // Add numeric class names from 1 to 12
      classSequence
          .addAll(List.generate(12, (index) => (index + 1).toString()));

      // Find the next class name that isn't in the existing classes
      return classSequence.firstWhere(
        (className) => !classes.contains(className),
        orElse: () => '', // Return empty string if no class is found
      );
    }

    try {
      SchoolHelperFunctions.showLoadingOverlay(); // Show loading overlay

      // Retrieve the document
      DocumentSnapshot schoolDoc =
          await firestore.collection('schools').doc(schoolId).get();

      if (schoolDoc.exists) {
        // Get the existing list of classes
        List<String> classList = List<String>.from(schoolDoc['classes'] ?? []);

        // Determine the next class name
        String nextClassName = getNextClass(classList);

        if (nextClassName.isNotEmpty) {
          // Update the document with the new class name
          await schoolDoc.reference.update({
            'classes': FieldValue.arrayUnion([nextClassName]),
          });

          // Show success message
          SchoolHelperFunctions.showSuccessSnackBar(
              'Class added successfully: $nextClassName');
          print('Class added successfully: $nextClassName');
        } else {
          // Handle the case when no next class could be determined
          print("No next class found.");
        }
      }

      Get.back(); // Close the loading overlay
    } catch (e) {
      print('Error adding class: $e');
      SchoolHelperFunctions.showErrorSnackBar(
          'Error adding class. Please try again.');
    }
  }

  Future<void> removeClassNameFromSchoolDoc(
      String schoolId, String className) async {
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

  Future<String> generateNewSectionName(
      String schoolId, String className) async {
    // Step 1: Fetch existing sections for the given schoolId and className
    final querySnapshot = await FirebaseFirestore.instance
        .collection('schoolClasses')
        .where('schoolId', isEqualTo: schoolId)
        .where('className', isEqualTo: className)
        .get();

    // Step 2: Extract current section names and sort them alphabetically
    List<String> sections = querySnapshot.docs
        .map((doc) => doc['section'] as String)
        .toList()
      ..sort();

    // Step 3: Find the next available section name
    for (int i = 0; i < sections.length; i++) {
      String expectedSection = String.fromCharCode(65 + i); // A, B, C, etc.
      if (sections[i] != expectedSection) {
        return expectedSection;
      }
    }

    // If all sequential sections exist (A, B, C...), return the next in sequence
    return String.fromCharCode(65 + sections.length); // Next available section
  }

  Future<List<String>> fetchSectionsName(
      String schoolId, String className) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('schoolClasses')
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
}
