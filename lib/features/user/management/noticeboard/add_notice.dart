import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/management/noticeboard/add_notice_history.dart';
import 'package:my_school_app/features/user/management/noticeboard/add_notice_new.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import 'news.dart';
import 'notice.dart';

class AddNotice extends StatefulWidget {
  const AddNotice({Key? key}) : super(key: key);

  @override
  _AddNoticeState createState() => _AddNoticeState();
}

class _AddNoticeState extends State<AddNotice>
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
          'Add Notice',
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
                Tab(text: 'New'),
                Tab(text: 'History'),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: const [
                AddNoticeNew(),
                AddNoticeHistory(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
