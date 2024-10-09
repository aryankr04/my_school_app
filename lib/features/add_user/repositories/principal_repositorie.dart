// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../data/services/firebase/firbase_services.dart';
// import '../../../utils/models/users/principal.dart'; // Import your Principal model
//
// class PrincipalRepository {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Add a new principal to Firestore
//   Future<void> addPrincipal(Principal principal, File imageFile) async {
//     try {
//       // Show loading overlay
//       print('Sending data to Firebase...');
//
//       // Upload image to Firebase Storage
//       String imageUrl = await _firebaseService.uploadFile(
//         file: imageFile,
//         path: 'principal_images/${principal.uid}.jpg',
//       );
//
//       // Set the image URL in the principal object
//       principal.imageUrl = imageUrl;
//
//       // Convert the Principal instance to a JSON map
//       Map<String, dynamic> principalData = principal.toJson();
//
//       // Add principal data to Firestore
//       await _firebaseService.addDocument('principals', principal.uid, principalData);
//
//       print('Principal added successfully!');
//     } catch (e) {
//       print('Error adding principal: $e');
//       rethrow;
//     }
//   }
//
//   // Generate a new ID with a specified prefix
//   Future<String?> generateNewPrincipalId() async {
//     try {
//       return await _firebaseService.generateNewIdWithPrefix('PRI', 'principals');
//     } catch (e) {
//       print('Error generating new principal ID: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve a principal document by ID
//   Future<Principal?> getPrincipalById(String id) async {
//     try {
//       DocumentSnapshot doc = await _firebaseService.getDocument('principals', id);
//       if (doc.exists) {
//         return Principal.fromJson(doc.data() as Map<String, dynamic>);
//       } else {
//         print('Principal not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving principal: $e');
//       rethrow;
//     }
//   }
//
//   // Update a principal document
//   Future<void> updatePrincipal(Principal principal) async {
//     try {
//       Map<String, dynamic> principalData = principal.toJson();
//       await _firebaseService.updateDocument('principals', principal.uid, principalData);
//       print('Principal updated successfully!');
//     } catch (e) {
//       print('Error updating principal: $e');
//       rethrow;
//     }
//   }
//
//   // Delete a principal document
//   Future<void> deletePrincipal(String id) async {
//     try {
//       await _firebaseService.deleteDocument('principals', id);
//       print('Principal deleted successfully!');
//     } catch (e) {
//       print('Error deleting principal: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve all principals
//   Future<List<Principal>> getAllPrincipals() async {
//     try {
//       QuerySnapshot snapshot = await _firebaseService.getCollection('principals');
//       return snapshot.docs.map((doc) => Principal.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print('Error retrieving principals: $e');
//       rethrow;
//     }
//   }
//
// // Additional methods for principal operations can be added here
// }
