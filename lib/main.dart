import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_school_app/features/manage_routine/screens/student/routine.dart';
import 'package:my_school_app/features/manage_routine/screens/student/routine0.dart';
import 'package:my_school_app/features/manage_school/screens/add_class.dart';
import 'package:my_school_app/features/on_boarding/on_boarding_screen.dart';
import 'package:my_school_app/features/splash_screen.dart';
import 'package:my_school_app/features/user/student/attendence/attendence.dart';
import 'package:my_school_app/features/user/teacher/attendence/screens/my_submit_attendance.dart';
import 'package:my_school_app/features/user/teacher/result/my_result.dart';
import 'package:my_school_app/routine.dart';
import 'package:my_school_app/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'data/repositories/school_class_repository.dart';
import 'data/services/firebase/firbase_services.dart';
import 'features/authentication/screens/login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
  );
  runApp(const SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.settings =
        const Settings(persistenceEnabled: true);

    // Determine the current brightness (light or dark mode)
    final Brightness brightness = MediaQuery.of(context).platformBrightness;

    // Choose the theme based on brightness
    final ThemeData theme = brightness == Brightness.light
        ? SchoolAppTheme.lightTheme
        : SchoolAppTheme.darkTheme;

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: Attendance());
  }
}
