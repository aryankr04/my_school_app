import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:my_school_app/features/user/teacher/result/my_result.dart';
import 'package:my_school_app/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/authentication/screens/login.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SchoolApp());
}

class SchoolApp extends StatelessWidget {
  const SchoolApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    FirebaseFirestore.instance.settings = const Settings(persistenceEnabled: true);

    // Determine the current brightness (light or dark mode)
    final Brightness brightness = MediaQuery.of(context).platformBrightness;

    // Choose the theme based on brightness
    final ThemeData theme = brightness == Brightness.light
        ? SchoolAppTheme.lightTheme
        : SchoolAppTheme.darkTheme;

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: theme,
        home: Login());
  }
}
