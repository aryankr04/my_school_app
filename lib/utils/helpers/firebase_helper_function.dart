import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseHelperFunction {
  static Future<String> uploadImage({
    required File imageFile,
    required String imageName,
    String folder = 'images',
  }) async {
    try {
      final firebase_storage.Reference reference =
      firebase_storage.FirebaseStorage.instance.ref('$folder/$imageName');

      await reference.putFile(imageFile);
      final String downloadURL = await reference.getDownloadURL();

      return downloadURL;
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }
  static Future<String?> generateNewIdWithPrefix(
      String prefix, String collection) async {
    try {
      final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collection).get();

      if (querySnapshot.docs.isEmpty) {
        return '$prefix${'0000000001'}';
      }

      String latestId = querySnapshot.docs.last.id;
      int latestNumericPart =
          int.tryParse(latestId.substring(prefix.length)) ?? 0;
      int newNumericPart = latestNumericPart + 1;
      return '$prefix${newNumericPart.toString().padLeft(10, '0')}';
    } catch (e) {
      print('Error generating new ID with prefix: $e');
      return null;
    }
  }
}
