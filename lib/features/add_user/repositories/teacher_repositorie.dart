// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../data/services/firebase/firbase_services.dart';
// import '../../../utils/models/users/teacher.dart'; // Import your Teacher model
//
// class TeacherRepository {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Add a new teacher to Firestore
//   Future<void> addTeacher(Teacher teacher, File imageFile) async {
//     try {
//       // Show loading overlay
//       print('Sending data to Firebase...');
//
//       // Upload image to Firebase Storage
//       String imageUrl = await _firebaseService.uploadFile(
//         file: imageFile,
//         path: 'teacher_images/${teacher.uid}.jpg',
//       );
//
//       // Set the image URL in the teacher object
//       teacher.imageUrl = imageUrl;
//
//       // Convert the Teacher instance to a JSON map
//       Map<String, dynamic> teacherData = teacher.toJson();
//
//       // Add teacher data to Firestore
//       await _firebaseService.addDocument('teachers', teacher.uid, teacherData);
//
//       print('Teacher added successfully!');
//     } catch (e) {
//       print('Error adding teacher: $e');
//       rethrow;
//     }
//   }
//
//   // Generate a new ID with a specified prefix
//   Future<String?> generateNewTeacherId() async {
//     try {
//       return await _firebaseService.generateNewIdWithPrefix('TEA', 'teachers');
//     } catch (e) {
//       print('Error generating new teacher ID: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve a teacher document by ID
//   Future<Teacher?> getTeacherById(String id) async {
//     try {
//       DocumentSnapshot doc = await _firebaseService.getDocument('teachers', id);
//       if (doc.exists) {
//         return Teacher.fromJson(doc.data() as Map<String, dynamic>);
//       } else {
//         print('Teacher not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving teacher: $e');
//       rethrow;
//     }
//   }
//
//   // Update a teacher document
//   Future<void> updateTeacher(Teacher teacher) async {
//     try {
//       Map<String, dynamic> teacherData = teacher.toJson();
//       await _firebaseService.updateDocument('teachers', teacher.uid, teacherData);
//       print('Teacher updated successfully!');
//     } catch (e) {
//       print('Error updating teacher: $e');
//       rethrow;
//     }
//   }
//
//   // Delete a teacher document
//   Future<void> deleteTeacher(String id) async {
//     try {
//       await _firebaseService.deleteDocument('teachers', id);
//       print('Teacher deleted successfully!');
//     } catch (e) {
//       print('Error deleting teacher: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve all teachers
//   Future<List<Teacher>> getAllTeachers() async {
//     try {
//       QuerySnapshot snapshot = await _firebaseService.getCollection('teachers');
//       return snapshot.docs.map((doc) => Teacher.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print('Error retrieving teachers: $e');
//       rethrow;
//     }
//   }
// }
