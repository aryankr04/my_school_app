import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/teacher/homework/assign_homework.dart';
import 'package:my_school_app/features/user/teacher/homework/homework_history.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/constants/dynamic_colors.dart';
class THomework extends StatefulWidget {
  const THomework({Key? key}) : super(key: key);

  @override
  _THomeworkState createState() => _THomeworkState();
}

class _THomeworkState extends State<THomework>
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
        leading:IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),

        title: const Text(
          'Homework',
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 56,right: 56,top: SchoolSizes.lg),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(SchoolSizes.md),
              color: SchoolDynamicColors.backgroundColorTintDarkGrey,
            ),
            child: TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: 'Assign'),
                Tab(text: 'History'),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children:  [
               AssignHomework(),
                HomeworkHistory()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
