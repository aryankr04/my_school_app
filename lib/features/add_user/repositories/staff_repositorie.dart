//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../data/services/firebase/firbase_services.dart';
// import '../../../utils/models/users/staff.dart'; // Import your Staff model
//
// class StaffRepository {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Add a new staff member to Firestore
//   Future<void> addStaff(Staff staff, File imageFile) async {
//     try {
//       // Show loading overlay
//       print('Sending data to Firebase...');
//
//       // Upload image to Firebase Storage
//       String imageUrl = await _firebaseService.uploadFile(
//         file: imageFile,
//         path: 'staff_images/${staff.uid}.jpg',
//       );
//
//       // Set the image URL in the staff object
//       staff.imageUrl = imageUrl;
//
//       // Convert the Staff instance to a JSON map
//       Map<String, dynamic> staffData = staff.toJson();
//
//       // Add staff data to Firestore
//       await _firebaseService.addDocument('staff', staff.uid, staffData);
//
//       print('Staff member added successfully!');
//     } catch (e) {
//       print('Error adding staff member: $e');
//       rethrow;
//     }
//   }
//
//   // Generate a new ID with a specified prefix
//   Future<String?> generateNewStaffId() async {
//     try {
//       return await _firebaseService.generateNewIdWithPrefix('STA', 'staff');
//     } catch (e) {
//       print('Error generating new staff member ID: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve a staff member document by ID
//   Future<Staff?> getStaffById(String id) async {
//     try {
//       DocumentSnapshot doc = await _firebaseService.getDocument('staff', id);
//       if (doc.exists) {
//         return Staff.fromJson(doc.data() as Map<String, dynamic>);
//       } else {
//         print('Staff member not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving staff member: $e');
//       rethrow;
//     }
//   }
//
//   // Update a staff member document
//   Future<void> updateStaff(Staff staff) async {
//     try {
//       Map<String, dynamic> staffData = staff.toJson();
//       await _firebaseService.updateDocument('staff', staff.uid, staffData);
//       print('Staff member updated successfully!');
//     } catch (e) {
//       print('Error updating staff member: $e');
//       rethrow;
//     }
//   }
//
//   // Delete a staff member document
//   Future<void> deleteStaff(String id) async {
//     try {
//       await _firebaseService.deleteDocument('staff', id);
//       print('Staff member deleted successfully!');
//     } catch (e) {
//       print('Error deleting staff member: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve all staff members
//   Future<List<Staff>> getAllStaff() async {
//     try {
//       QuerySnapshot snapshot = await _firebaseService.getCollection('staff');
//       return snapshot.docs.map((doc) => Staff.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print('Error retrieving staff members: $e');
//       rethrow;
//     }
//   }
//
// // Additional methods for staff member operations can be added here
// }
