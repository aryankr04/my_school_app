import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/chat/chat_main_page.dart';
import 'package:my_school_app/features/user/student/main_page/profile/profile.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/my_profile.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import 'home/home.dart';

import 'explore/explore.dart';

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
    MyProfile(),
    const Profile(),
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
      // bottomNavigationBar: GNav(
      //     tabMargin: EdgeInsets.symmetric(
      //         horizontal: SchoolSizes.sm, vertical: SchoolSizes.sm-4),
      //
      //     hoverColor: SchoolColors.grey, // tab button hover color
      //     tabBorderRadius: 15,
      //     style: GnavStyle.oldSchool,
      //     // tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
      //     // tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
      //     // tabShadow: [BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
      //     curve: Curves.easeIn, // tab animation curves
      //     duration: Duration(milliseconds: 100), // tab animation duration
      //     gap: 5, // the tab button gap between icon and text
      //     color: SchoolDynamicColors.iconColor, // unselected icon color
      //     activeColor: SchoolColors.activeBlue, // selected icon and text color
      //     iconSize: 20, // tab button icon size
      //     textSize: 12,
      //     tabBackgroundColor: SchoolColors.activeBlue
      //         .withOpacity(0.1), // selected tab background color
      //     padding: EdgeInsets.symmetric(
      //         horizontal: 10, vertical: 8), // navigation bar padding
      //     tabs: [
      //       GButton(
      //         icon: Icons.home_rounded,
      //         text: 'Home',
      //       ),
      //       GButton(
      //         icon: Icons.chat,
      //         text: 'Chat',
      //       ),
      //       GButton(
      //         icon: Icons.explore_outlined,
      //         text: 'Explore',
      //       ),
      //       GButton(
      //         icon: Icons.leaderboard_rounded,
      //         text: 'Leaderboard',
      //       ),
      //       GButton(
      //         icon: Icons.person_rounded,
      //         text: 'Profile',
      //       )
      //     ]),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTap,
        currentIndex: currentIndex,
        elevation: 10,
        items: [
          BottomNavigationBarItem(
            label: 'Home',
            icon: Icon(
              Icons.home_outlined,
            ),
            activeIcon: Icon(Icons.home_rounded),
            backgroundColor: SchoolDynamicColors.white,
          ),
          BottomNavigationBarItem(
            label: 'Chat',
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat_rounded),
            backgroundColor: SchoolDynamicColors.white,
          ),
          BottomNavigationBarItem(
            label: 'Explore',
            icon: Icon(Icons.explore_outlined),
            activeIcon: Icon(Icons.explore),
            backgroundColor: SchoolDynamicColors.white,
          ),
          BottomNavigationBarItem(
            label: 'Leaderboard',
            icon: Icon(Icons.leaderboard_outlined),
            activeIcon: Icon(Icons.leaderboard_rounded),
            backgroundColor: SchoolDynamicColors.white,
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(Icons.person_outline_rounded),
            activeIcon: Icon(Icons.person),
            backgroundColor: SchoolDynamicColors.white,
          ),
        ],
             ),
      // bottomNavigationBar: BottomNavigationBar(
      //       onTap: onTap,
      //       currentIndex: currentIndex,
      //       elevation: 15,
      //       unselectedItemColor: SchoolDynamicColors.white.withOpacity(0.5),
      //       selectedItemColor: SchoolDynamicColors.white,
      //       items: [
      //         BottomNavigationBarItem(
      //
      //           label: 'Home',
      //           icon: Icon(
      //             Icons.home_outlined,
      //           ),
      //           activeIcon: Icon(Icons.home),
      //           backgroundColor: SchoolDynamicColors.activeBlue,
      //         ),
      //         BottomNavigationBarItem(
      //           label: 'Chat',
      //           icon: Icon(Icons.chat_outlined),
      //           activeIcon: Icon(Icons.chat),
      //           backgroundColor: SchoolDynamicColors.activeBlue,
      //         ),
      //         BottomNavigationBarItem(
      //           label: 'Explore',
      //           icon: Icon(Icons.explore_outlined),
      //           activeIcon: Icon(Icons.explore),
      //           backgroundColor: SchoolDynamicColors.activeBlue,
      //         ),
      //         BottomNavigationBarItem(
      //           label: 'Leaderboard',
      //           icon: Icon(Icons.leaderboard_outlined),
      //           activeIcon: Icon(Icons.leaderboard_rounded),
      //           backgroundColor: SchoolDynamicColors.activeBlue,
      //         ),
      //         BottomNavigationBarItem(
      //           label: 'Profile',
      //           icon: Icon(Icons.person_outline_rounded),
      //           activeIcon: Icon(Icons.person),
      //           backgroundColor: SchoolDynamicColors.activeBlue,
      //         ),
      //       ],
      //     )
    );
  }
}
