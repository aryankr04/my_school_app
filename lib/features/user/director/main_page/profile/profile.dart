import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/main_page/profile/academics.dart';
import 'package:my_school_app/features/user/student/main_page/profile/others.dart';
import 'package:my_school_app/features/user/student/main_page/profile/personal.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin {
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
    final Brightness brightness = MediaQuery.of(context).platformBrightness;
    final bool isLightMode = brightness == Brightness.light;
    final Color indicatorColor = isLightMode ? SchoolDynamicColors.primaryColor : SchoolDynamicColors.primaryColor;
    final Color selectedLabelColor = isLightMode ? SchoolDynamicColors.primaryColor : SchoolDynamicColors.white;
    final Color unselectedLabelColor = isLightMode
        ? SchoolDynamicColors.darkBackgroundColor.withOpacity(0.5)
        : Colors.white.withOpacity(0.5);

    final Color profileCardColor = isLightMode
        ? SchoolDynamicColors.primaryColor
        : SchoolDynamicColors.primaryColor.withOpacity(0.5);

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_outlined),
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          const SizedBox(height: SchoolSizes.defaultSpace),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
            child: ProfileCard(profileCardColor: profileCardColor),
          ),
          const SizedBox(height: SchoolSizes.spaceBtwSections),
          TabBar(
            controller: tabController,
            labelStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(fontWeight: FontWeight.w600),
            unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge,
            labelColor: selectedLabelColor,
            unselectedLabelColor: unselectedLabelColor,
            indicatorColor: indicatorColor,
            indicatorSize: TabBarIndicatorSize.tab,
            tabs: const [
              Tab(text: 'Personal'),
              Tab(text: 'Academics'),
              Tab(text: 'Others'),
            ],
          ),
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: const [Personal(), Academics(), Others()],
            ),
          )
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({Key? key, required this.profileCardColor}) : super(key: key);

  final Color profileCardColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: profileCardColor,
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.md),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
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
                          .headlineSmall
                          ?.copyWith(color: SchoolDynamicColors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'aryankr_04',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: SchoolDynamicColors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
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
              .titleLarge
              ?.copyWith(color: SchoolDynamicColors.white),
        ),
        Text(
          text2,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: SchoolDynamicColors.white),
        ),
      ],
    );
  }
}
