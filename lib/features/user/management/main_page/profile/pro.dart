import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/teacher/homework/assign_homework.dart';
import 'package:my_school_app/features/user/teacher/leave_requests/leave_requests_completed.dart';
import 'package:my_school_app/features/user/teacher/leave_requests/leave_requests_waiting.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/my_profile.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/theme/widget_themes/tab_bar_theme.dart';

class Prof extends StatelessWidget {
  const Prof({Key? key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
        ),
        body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, isScrolled) {
            return [
              const SliverAppBar(
                collapsedHeight: 100, // Adjust this height as needed
                expandedHeight: 200, // Adjust this height as needed
                flexibleSpace: MyProfile(),
              ),
              SliverPersistentHeader(
                delegate: MyDelegate(
                  const TabBar(
                    tabs: [
                      Tab(icon: Icon(Icons.grid_3x3_outlined)),
                      Tab(icon: Icon(Icons.person)),
                      Tab(icon: Icon(Icons.videocam_outlined)),
                    ],
                  ) ,
                ),
                floating: true,
                pinned: true,
              )
            ];
          },
          body: TabBarView(
            children: [
              const LeaveRequestsCompleted(),
              const LeaveRequestsWaiting(),
              AssignHomework(),
            ],
          ),
        ),
      ),
    );
  }
}

class MyDelegate extends SliverPersistentHeaderDelegate {
  MyDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
        color: Colors.white,
        child: tabBar);
  }

  @override
  double get maxExtent => 200; // Set the maximum height here

  @override
  double get minExtent => 100; // Set the minimum height here

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
