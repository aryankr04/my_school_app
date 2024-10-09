// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../data/services/firebase/firbase_services.dart';
// import '../models/student.dart';
//
// class StudentRepository {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Add a new student to Firestore
//   Future<void> addStudent(Student student, File imageFile) async {
//     try {
//       // Show loading overlay
//       print('Sending data to Firebase...');
//
//       // Upload image to Firebase Storage
//       String imageUrl = await _firebaseService.uploadFile(
//         file: imageFile,
//         path: 'principal_images/${student.uid}.jpg',
//       );
//
//       // Set the image URL in the student object
//       student.imageUrl = imageUrl;
//
//       // Convert the Student instance to a JSON map
//       Map<String, dynamic> studentData = student.toJson();
//
//       // Add student data to Firestore
//       await _firebaseService.addDocument('students', student.uid, studentData);
//
//       print('Student added successfully!');
//     } catch (e) {
//       print('Error adding student: $e');
//       rethrow;
//     }
//   }
//
//   // Generate a new ID with a specified prefix
//   Future<String?> generateNewStudentId() async {
//     try {
//       return await _firebaseService.generateNewIdWithPrefix('STU', 'students');
//     } catch (e) {
//       print('Error generating new student ID: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve a student document by ID
//   Future<Student?> getStudentById(String id) async {
//     try {
//       DocumentSnapshot doc = await _firebaseService.getDocument('students', id);
//       if (doc.exists) {
//         return Student.fromJson(doc.data() as Map<String, dynamic>);
//       } else {
//         print('Student not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving student: $e');
//       rethrow;
//     }
//   }
//
//   // Update a student document
//   Future<void> updateStudent(Student student) async {
//     try {
//       Map<String, dynamic> studentData = student.toJson();
//       await _firebaseService.updateDocument('students', student.uid, studentData);
//       print('Student updated successfully!');
//     } catch (e) {
//       print('Error updating student: $e');
//       rethrow;
//     }
//   }
//
//   // Delete a student document
//   Future<void> deleteStudent(String id) async {
//     try {
//       await _firebaseService.deleteDocument('students', id);
//       print('Student deleted successfully!');
//     } catch (e) {
//       print('Error deleting student: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve all students
//   Future<List<Student>> getAllStudents() async {
//     try {
//       QuerySnapshot snapshot = await _firebaseService.getCollection('students');
//       return snapshot.docs.map((doc) => Student.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print('Error retrieving students: $e');
//       rethrow;
//     }
//   }
//
// }
