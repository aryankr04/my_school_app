import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_school_app/features/authentication/screens/login.dart';

import '../utils/constants/dynamic_colors.dart';
import '../utils/constants/sizes.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Delay for 3 seconds before navigating to the main screen
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                Login()), // Replace with your main screen widget
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white, // Set background color
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff1191FD), Color(0xff5E59F2)],
            ),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage('assets/logos/csd.png'),
                ),
                SizedBox(
                  height: SchoolSizes.md,
                ),
                Align(
                    alignment: Alignment.center,
                    child: Text('Cambridge School Dumraon',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium
                            ?.copyWith(
                                color: SchoolDynamicColors.whiteTextColor,
                                fontSize: 26))),
              ]),
        ));
  }
}
