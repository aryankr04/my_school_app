import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/student/take_leave/apply.dart';
import 'package:my_school_app/features/user/student/take_leave/requested.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';

class TakeLeave extends StatefulWidget {
  const TakeLeave({super.key});

  @override
  State<TakeLeave> createState() => _TakeLeaveState();
}

class _TakeLeaveState extends State<TakeLeave>
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
          'Take Leave',
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: SchoolSizes.defaultSpace),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 54),
            decoration: BoxDecoration(
              color: SchoolDynamicColors.backgroundColorTintDarkGrey,
              borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
            ),
            child: TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: 'Apply'),
                Tab(text: 'Requested'),
              ],
            ),
          ),
          //SizedBox(height: SchoolSizes.defaultSpace,),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: [ApplyForLeave(), RequestedLeave()],
            ),
          ),
        ],
      ),
    );
  }
}
