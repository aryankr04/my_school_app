import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/director/main_page/profile/profile.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chat_main_page.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/my_profile.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import 'home/home.dart';

import 'explore/explore.dart';
import 'leaderboard/leaderboard.dart';
import 'profile/profile.dart';

class TeacherMainPage extends StatefulWidget {
  const TeacherMainPage({super.key});

  @override
  State<TeacherMainPage> createState() => _TeacherMainPageState();
}

class _TeacherMainPageState extends State<TeacherMainPage> {
  List pages = [
    const Home(),
    const ChatMainPage(),
     Explore(),
    Leaderboard(),
    const MyProfile(),
  ];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          items:  [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home),
              backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,

            ),
            BottomNavigationBarItem(
              label: 'Chat',
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),
              backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,

            ),
            BottomNavigationBarItem(
              label: 'Explore',
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),
              backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,

            ),
            BottomNavigationBarItem(
              label: 'Leaderboard',
              icon: Icon(Icons.leaderboard_outlined),
              activeIcon: Icon(Icons.leaderboard_rounded),
              backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,

            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person),
              backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,

            ),
          ],
        ));
  }
}
