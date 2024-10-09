import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../../utils/constants/dynamic_colors.dart';
import 'manage_routine_student.dart';
import 'manage_routine_teacher.dart';

class ManageRoutine extends StatefulWidget {
  const ManageRoutine({super.key});

  @override
  State<ManageRoutine> createState() => _ManageRoutineState();
}

class _ManageRoutineState extends State<ManageRoutine>  with SingleTickerProviderStateMixin {
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
        title: const Text('Manage Routine'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
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
                Tab(text: 'Student'),
                Tab(text: 'Teacher'),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children:  [
              ManageRoutineStudent(),
                ManageRoutineTeacher()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
