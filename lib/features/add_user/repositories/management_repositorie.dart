// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../data/services/firebase/firbase_services.dart';
//
//
// class ManagementRepository {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Add a new manager to Firestore
//   Future<void> addManager(Manager manager, File imageFile) async {
//     try {
//       // Show loading overlay
//       print('Sending data to Firebase...');
//
//       // Upload image to Firebase Storage
//       String imageUrl = await _firebaseService.uploadFile(
//         file: imageFile,
//         path: 'manager_images/${manager.uid}.jpg',
//       );
//
//       // Set the image URL in the manager object
//       manager.imageUrl = imageUrl;
//
//       // Convert the Manager instance to a JSON map
//       Map<String, dynamic> managerData = manager.toJson();
//
//       // Add manager data to Firestore
//       await _firebaseService.addDocument('managers', manager.uid, managerData);
//
//       print('Manager added successfully!');
//     } catch (e) {
//       print('Error adding manager: $e');
//       rethrow;
//     }
//   }
//
//   // Generate a new ID with a specified prefix
//   Future<String?> generateNewManagerId() async {
//     try {
//       return await _firebaseService.generateNewIdWithPrefix('MAN', 'managers');
//     } catch (e) {
//       print('Error generating new manager ID: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve a manager document by ID
//   Future<Manager?> getManagerById(String id) async {
//     try {
//       DocumentSnapshot doc = await _firebaseService.getDocument('managers', id);
//       if (doc.exists) {
//         return Manager.fromJson(doc.data() as Map<String, dynamic>);
//       } else {
//         print('Manager not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving manager: $e');
//       rethrow;
//     }
//   }
//
//   // Update a manager document
//   Future<void> updateManager(Manager manager) async {
//     try {
//       Map<String, dynamic> managerData = manager.toJson();
//       await _firebaseService.updateDocument('managers', manager.uid, managerData);
//       print('Manager updated successfully!');
//     } catch (e) {
//       print('Error updating manager: $e');
//       rethrow;
//     }
//   }
//
//   // Delete a manager document
//   Future<void> deleteManager(String id) async {
//     try {
//       await _firebaseService.deleteDocument('managers', id);
//       print('Manager deleted successfully!');
//     } catch (e) {
//       print('Error deleting manager: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve all managers
//   Future<List<Manager>> getAllManagers() async {
//     try {
//       QuerySnapshot snapshot = await _firebaseService.getCollection('managers');
//       return snapshot.docs.map((doc) => Manager.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print('Error retrieving managers: $e');
//       rethrow;
//     }
//   }
//
// // Additional methods for management operations can be added here
// }
