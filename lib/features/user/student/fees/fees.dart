import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/student/fees/fee_details.dart';
import 'package:my_school_app/features/user/student/fees/fee_payments.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/constants/dynamic_colors.dart';

class Fees extends StatefulWidget {
  const Fees({Key? key}) : super(key: key);

  @override
  _FeesState createState() => _FeesState();
}

class _FeesState extends State<Fees>
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
        title: const Text('Fee'),
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
                Tab(text: 'Fees'),
                Tab(text: 'Payments'),
              ],
            ),
          ),
          Flexible(
            child: TabBarView(
              controller: tabController,
              children: const [
               FeeDetails(),
                FeePayments()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
