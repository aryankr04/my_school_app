import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/features/user/student/main_page/profile/academics.dart';
import 'package:my_school_app/features/user/student/main_page/profile/others.dart';
import 'package:my_school_app/features/user/student/main_page/profile/personal.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/academics.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/others.dart';
import 'package:my_school_app/features/user/teacher/main_page/profile/personal.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../../utils/theme/widget_themes/tab_bar_theme.dart';

class TProfile extends StatefulWidget {
  const TProfile({Key? key}) : super(key: key);

  @override
  State<TProfile> createState() => _TProfileState();
}

class _TProfileState extends State<TProfile>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
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
        //leading: const Icon(Icons.arrow_back_outlined),
        title: const Text('Profile'),
      ),
      backgroundColor: SchoolHelperFunctions.isDarkMode(Get.context!)
          ? SchoolDynamicColors.darkerGreyBackgroundColor
          : SchoolDynamicColors.primaryTintColor,
      body: Padding(
        padding: const EdgeInsets.only(
            left: SchoolSizes.lg, right: SchoolSizes.lg, top: SchoolSizes.lg),
        child: Column(
          children: [
            const ProfileCard(),
            const SizedBox(height: SchoolSizes.spaceBtwSections),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(SchoolSizes.md),
                    topLeft: Radius.circular(SchoolSizes.md)),
                color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                //border: Border(bottom: BorderSide(color: SchoolColors.borderColor, width: 1)),
              ),
              child: Theme(
                data: ThemeData(
                    tabBarTheme: SchoolTabBarTheme.defaultTabBarTheme),
                child: TabBar(
                  unselectedLabelColor: SchoolDynamicColors.subtitleTextColor,
                  labelColor: SchoolDynamicColors.primaryColor,
                  indicatorColor: SchoolDynamicColors.primaryColor,
                  controller: tabController,
                  tabs: const [
                    Tab(text: 'Personal'),
                    Tab(text: 'Academics'),
                    Tab(text: 'Others'),
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.white,
                  border:
                      Border.all(color: SchoolDynamicColors.borderColor, width: 0.5),
                ),
                child: TabBarView(
                  controller: tabController,
                  children: const [TPersonal(), TAcademics(), TOthers()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
        //border: Border.all(width: 0.25,color: SchoolColors.grey)
      ),
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.md),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: SchoolDynamicColors.grey,
                    ),
                    const SizedBox(width: SchoolSizes.defaultSpace),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Aryan Kumar',
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'aryankr_04',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(
                                  color: SchoolDynamicColors.subtitleTextColor),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
                InkWell(
                    child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          border: Border.all(width: 0.5,color: SchoolDynamicColors.borderColor),
                          color: SchoolDynamicColors.backgroundColorTintLightGrey,
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: const Row(
                          children: [
                            Text('Edit'),
                            SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.edit,
                              size: 18,
                            ),
                          ],
                        )))
              ],
            ),
            const SizedBox(height: SchoolSizes.spaceBtwItems),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTextColumn(context, '12', 'Class'),
                _buildTextColumn(context, 'C', 'Sec'),
                _buildTextColumn(context, '10', 'Roll No.'),
                _buildTextColumn(context, '122473', 'Adm No.'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextColumn(BuildContext context, String text1, String text2) {
    return Column(
      children: [
        Text(
          text1,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
        ),
        Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
        ),
      ],
    );
  }
}
