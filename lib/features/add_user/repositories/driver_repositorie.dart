// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
//
// import '../../../data/services/firebase/firbase_services.dart';
// import '../models/driver.dart'; // Import your Driver model
//
// class DriverRepository {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Add a new driver to Firestore
//   Future<void> addDriver(Driver driver, File imageFile) async {
//     try {
//       // Show loading overlay
//       print('Sending data to Firebase...');
//
//       // Upload image to Firebase Storage
//       String imageUrl = await _firebaseService.uploadFile(
//         file: imageFile,
//         path: 'driver_images/${driver.uid}.jpg',
//       );
//
//       // Set the image URL in the driver object
//       driver.imageUrl = imageUrl;
//
//       // Convert the Driver instance to a JSON map
//       Map<String, dynamic> driverData = driver.toJson();
//
//       // Add driver data to Firestore
//       await _firebaseService.addDocument('drivers', driver.uid, driverData);
//
//       print('Driver added successfully!');
//     } catch (e) {
//       print('Error adding driver: $e');
//       rethrow;
//     }
//   }
//
//   // Generate a new ID with a specified prefix
//   Future<String?> generateNewDriverId() async {
//     try {
//       return await _firebaseService.generateNewIdWithPrefix('DRV', 'drivers');
//     } catch (e) {
//       print('Error generating new driver ID: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve a driver document by ID
//   Future<Driver?> getDriverById(String id) async {
//     try {
//       DocumentSnapshot doc = await _firebaseService.getDocument('drivers', id);
//       if (doc.exists) {
//         return Driver.fromJson(doc.data() as Map<String, dynamic>);
//       } else {
//         print('Driver not found');
//         return null;
//       }
//     } catch (e) {
//       print('Error retrieving driver: $e');
//       rethrow;
//     }
//   }
//
//   // Update a driver document
//   Future<void> updateDriver(Driver driver) async {
//     try {
//       Map<String, dynamic> driverData = driver.toJson();
//       await _firebaseService.updateDocument('drivers', driver.uid, driverData);
//       print('Driver updated successfully!');
//     } catch (e) {
//       print('Error updating driver: $e');
//       rethrow;
//     }
//   }
//
//   // Delete a driver document
//   Future<void> deleteDriver(String id) async {
//     try {
//       await _firebaseService.deleteDocument('drivers', id);
//       print('Driver deleted successfully!');
//     } catch (e) {
//       print('Error deleting driver: $e');
//       rethrow;
//     }
//   }
//
//   // Retrieve all drivers
//   Future<List<Driver>> getAllDrivers() async {
//     try {
//       QuerySnapshot snapshot = await _firebaseService.getCollection('drivers');
//       return snapshot.docs.map((doc) => Driver.fromJson(doc.data() as Map<String, dynamic>)).toList();
//     } catch (e) {
//       print('Error retrieving drivers: $e');
//       rethrow;
//     }
//   }
//
// // Additional methods for driver operations can be added here
// }
