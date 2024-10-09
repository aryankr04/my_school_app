import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

class FirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  // Authentication Functions
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> signUpWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential.user;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }

  Future<User?> getCurrentUser() async {
    try {
      return _auth.currentUser;
    } catch (e) {
      rethrow;
    }
  }

  Stream<User?> authStateChanges() {
    return _auth.authStateChanges();
  }

  Future<void> updateProfile({
    required String displayName,
    required String photoURL,
  }) async {
    try {
      await _auth.currentUser!.updateProfile(displayName: displayName, photoURL: photoURL);
      await _auth.currentUser!.reload();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEmail(String email) async {
    try {
      await _auth.currentUser!.updateEmail(email);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updatePassword(String password) async {
    try {
      await _auth.currentUser!.updatePassword(password);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      rethrow;
    }
  }



  // Firestore Functions
  Future<void> addDocument(String collection, String id, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(id).set(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateDocument(String collection, String id, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(id).update(data);
    } catch (e) {
      rethrow;
    }
  }

  Future<DocumentSnapshot> getDocument(String collection, String id) async {
    try {
      return await _firestore.collection(collection).doc(id).get();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteDocument(String collection, String id) async {
    try {
      await _firestore.collection(collection).doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getCollection(String collection) async {
    try {
      return await _firestore.collection(collection).get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> queryCollection({
    required String collection,
    required String field,
    required dynamic value,
  }) async {
    try {
      return await _firestore.collection(collection).where(field, isEqualTo: value).get();
    } catch (e) {
      rethrow;
    }
  }

  Future<QuerySnapshot> getDocumentsByCondition({
    required String collection,
    required String field,
    required dynamic condition,
  }) async {
    try {
      return await _firestore.collection(collection).where(field, isEqualTo: condition).get();
    } catch (e) {
      rethrow;
    }
  }

   Future<String?> generateNewIdWithPrefix(
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




  // Firebase Storage Functions
  Future<String> uploadFile({
    required File file,
    required String path,
  }) async {
    try {
      Reference ref = _storage.ref().child(path);
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      return await snapshot.ref.getDownloadURL();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteFile(String path) async {
    try {
      Reference ref = _storage.ref().child(path);
      await ref.delete();
    } catch (e) {
      rethrow;
    }
  }




  // Firebase Cloud Messaging Functions
  Future<void> requestNotificationPermissions() async {
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      await _messaging.subscribeToTopic(topic);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _messaging.unsubscribeFromTopic(topic);
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> getToken() async {
    try {
      return await _messaging.getToken();
    } catch (e) {
      rethrow;
    }
  }

  void listenToMessages() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while in the foreground!');
      print('Message data: ${message.data}');
      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message clicked!');
    });
  }

// Additional Firebase Functions (e.g., Cloud Functions) can be added here as needed.
}
