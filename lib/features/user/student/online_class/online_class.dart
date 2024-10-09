import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/student/online_class/recorded.dart';

import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import 'live.dart';

class OnlineClasses extends StatefulWidget {
  const OnlineClasses({Key? key}) : super(key: key);

  @override
  _OnlineClassesState createState() => _OnlineClassesState();
}

class _OnlineClassesState extends State<OnlineClasses>
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
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text(
          'Online Class',
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 56,right: 56,top: SchoolSizes.lg),
            decoration: BoxDecoration(
              color: SchoolDynamicColors.backgroundColorTintDarkGrey,
              borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusLg),
            ),
            child: TabBar(
              controller: tabController,
              tabs: const [
                Tab(text: 'Live'),
                Tab(text: 'Recorded'),
              ],
            ),
          ),
          const SizedBox(height: SchoolSizes.defaultSpace),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: const [
                LiveClasses(),
                RecordedClasses(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
