import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chat_main_page.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/my_profile.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import 'home/home.dart';

import 'explore/explore.dart';
import 'leaderboard/leaderboard.dart';

class StudentMainPage extends StatefulWidget {
  const StudentMainPage({super.key});

  @override
  State<StudentMainPage> createState() => _StudentMainPageState();
}

class _StudentMainPageState extends State<StudentMainPage> {
  List pages = [
    const StudentHome(),
    const ChatMainPage(),
    const Explore(),
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
        backgroundColor: Colors.black,
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          elevation: 15,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home_outlined,
              ),
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
