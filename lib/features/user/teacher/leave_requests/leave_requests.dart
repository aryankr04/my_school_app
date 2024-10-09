import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/student/take_leave/apply.dart';
import 'package:my_school_app/features/user/student/take_leave/requested.dart';
import 'package:my_school_app/features/user/teacher/leave_requests/leave_requests_completed.dart';
import 'package:my_school_app/features/user/teacher/leave_requests/leave_requests_waiting.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';

class LeaveRequests extends StatefulWidget {
  const LeaveRequests({super.key});

  @override
  State<LeaveRequests> createState() => _LeaveRequestsState();
}

class _LeaveRequestsState extends State<LeaveRequests>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: const Text(
          'Leave Requests',
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: SchoolSizes.defaultSpace),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 54),
            decoration: BoxDecoration(
              color: SchoolDynamicColors.backgroundColorTintDarkGrey,
              borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusLg),
            ),
            child: TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: 'Waiting'),
                Tab(text: 'Completed'),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: [LeaveRequestsWaiting(), LeaveRequestsCompleted()],
            ),
          ),
        ],
      ),
    );
  }
}
