// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../data/services/firebase/firbase_services.dart';
// import '../models/director.dart'; // Import your Director model
//
// class DirectorRepository {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Add a new director to Firestore
//   Future<void> addDirector(Director director, File imageFile) async {
//     try {
//       // Show loading overlay
//       print('Sending data to Firebase...');
//
//       // Upload image to Firebase Storage
//       String imageUrl = await _firebaseService.uploadFile(
//         file: imageFile,
//         path: 'director_images/${director.uid}.jpg',
//       );
//
//       // Set the image URL in the director object
//       director.imageUrl = imageUrl;
//
//       // Convert the Director instance to a JSON map
//       Map<String, dynamic> directorData = director.toJson();
//
//       // Add director data to Firestore
//       await _firebaseService.addDocument('directors', director.uid, directorData);
//
//       print('Director added successfully!');
//     } catch (e) {
//       print('Error adding director: $e');
//       rethrow;
//     }
//   }
//
//   // Generate a new ID with a specified prefix
//   Future<String?> generateNewDirectorId() async {
//     try {
//       return await _firebaseService.generateNewIdWithPrefix('DIR', 'directors');
//     } catch (e) {
//       print('Error generating new director ID: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve a director document by ID
//   Future<Director?> getDirectorById(String id) async {
//     try {
//       DocumentSnapshot doc = await _firebaseService.getDocument('directors', id);
//       if (doc.exists) {
//         return Director.fromJson(doc.data() as Map<String, dynamic>);
//       } else {
//         print('Director not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving director: $e');
//       rethrow;
//     }
//   }
//
//   // Update a director document
//   Future<void> updateDirector(Director director) async {
//     try {
//       Map<String, dynamic> directorData = director.toJson();
//       await _firebaseService.updateDocument('directors', director.uid, directorData);
//       print('Director updated successfully!');
//     } catch (e) {
//       print('Error updating director: $e');
//       rethrow;
//     }
//   }
//
//   // Delete a director document
//   Future<void> deleteDirector(String id) async {
//     try {
//       await _firebaseService.deleteDocument('directors', id);
//       print('Director deleted successfully!');
//     } catch (e) {
//       print('Error deleting director: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve all directors
//   Future<List<Director>> getAllDirectors() async {
//     try {
//       QuerySnapshot snapshot = await _firebaseService.getCollection('directors');
//       return snapshot.docs.map((doc) => Director.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print('Error retrieving directors: $e');
//       rethrow;
//     }
//   }
//
// // Additional methods for director operations can be added here
// }
