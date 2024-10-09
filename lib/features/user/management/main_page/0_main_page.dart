import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chat_main_page.dart';
import 'package:my_school_app/features/user/student/main_page/profile/pro.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/my_profile.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import 'home/home.dart';

import 'explore/explore.dart';
import 'leaderboard/leaderboard.dart';
import 'profile/profile.dart';

class ManagementMainPage extends StatefulWidget {
  const ManagementMainPage({super.key});

  @override
  State<ManagementMainPage> createState() => _ManagementMainPageState();
}

class _ManagementMainPageState extends State<ManagementMainPage> {
  List pages = [
    const ManagementHome(),
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
        body: pages[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTap,
          currentIndex: currentIndex,
          items:  const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home_outlined,),
              activeIcon: Icon(Icons.home),

            ),
            BottomNavigationBarItem(
              label: 'Chat',
              icon: Icon(Icons.chat_outlined),
              activeIcon: Icon(Icons.chat),

            ),
            BottomNavigationBarItem(
              label: 'Explore',
              icon: Icon(Icons.explore_outlined),
              activeIcon: Icon(Icons.explore),

            ),
            BottomNavigationBarItem(
              label: 'Leaderboard',
              icon: Icon(Icons.leaderboard_outlined),
              activeIcon: Icon(Icons.leaderboard_rounded),

            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(Icons.person_outline_rounded),
              activeIcon: Icon(Icons.person),

            ),
          ],
        ));
  }
}
