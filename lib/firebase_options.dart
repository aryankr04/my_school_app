// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCNvDYjNUJ7wj2BCvnDRlL9jPRjGiFpOsI',
    appId: '1:340842430488:web:bd2341c8f69d560c75436d',
    messagingSenderId: '340842430488',
    projectId: 'my-school-app-80805',
    authDomain: 'my-school-app-80805.firebaseapp.com',
    storageBucket: 'my-school-app-80805.appspot.com',
    measurementId: 'G-YPZCYLSGPV',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDn5YuhoQUC3rYqhwqE16idfuo1G_29uiQ',
    appId: '1:340842430488:android:43259c81e94f168175436d',
    messagingSenderId: '340842430488',
    projectId: 'my-school-app-80805',
    storageBucket: 'my-school-app-80805.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCftPegG8bkXHF1GZtbxIQ60dMmDRoXs6c',
    appId: '1:340842430488:ios:f1f90da1be59a1e275436d',
    messagingSenderId: '340842430488',
    projectId: 'my-school-app-80805',
    storageBucket: 'my-school-app-80805.appspot.com',
    iosBundleId: 'com.example.mySchoolApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCftPegG8bkXHF1GZtbxIQ60dMmDRoXs6c',
    appId: '1:340842430488:ios:c6f9bca5326a1ba775436d',
    messagingSenderId: '340842430488',
    projectId: 'my-school-app-80805',
    storageBucket: 'my-school-app-80805.appspot.com',
    iosBundleId: 'com.example.mySchoolApp.RunnerTests',
  );
}
