import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/theme/widget_themes/tab_bar_theme.dart';

import '../../../../../utils/constants/dynamic_colors.dart';

class Student {
  final String name;
  final String username;
  final int points;

  Student({required this.name, required this.username, required this.points});
}
class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Theme child;

  _SliverAppBarDelegate({required this.child});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }

  @override
  double get maxExtent => kToolbarHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}


class Leaderboard extends StatelessWidget {
  final List<Student> students = [
    Student(name: 'Alice', username: 'alice123', points: 500),
    Student(name: 'Bob', username: 'bob456', points: 600),
    Student(name: 'Charlie', username: 'charlie789', points: 400),
    Student(name: 'David', username: 'david101', points: 700),
    Student(name: 'Emma', username: 'emma202', points: 800),
    Student(name: 'Frank', username: 'frank303', points: 550),
    Student(name: 'Grace', username: 'grace404', points: 450),
    Student(name: 'Henry', username: 'henry505', points: 750),
    Student(name: 'Isabella', username: 'isabella606', points: 650),
    Student(name: 'Jack', username: 'jack707', points: 720),
  ];

  Leaderboard({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Leaderboard',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(color: Colors.white),
          ),
          backgroundColor: SchoolDynamicColors.activeBlue,
          leadingWidth: 70,
          leading: IconButton(icon: Icon(Icons.menu_rounded,color: SchoolDynamicColors.white,),onPressed: (){},),
          elevation: 0,
        ),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.bottomLeft,
                  padding: const EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
                  height: 300,
                  color: SchoolDynamicColors.activeBlue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      _buildProfileItem(
                        'Aryan Kumar',
                        '1223',
                        '2nd',
                      ),
                      _buildProfileItem('Aryan Kumar', '12231', '1st',
                          height: 130),
                      _buildProfileItem(
                        'Aryan Kumar',
                        '1223',
                        '3rd',
                      ),
                    ],
                  ),
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  child: Theme(
                    data: ThemeData(
                      tabBarTheme: SchoolTabBarTheme.defaultTabBarTheme.copyWith(
                        indicatorColor: SchoolDynamicColors.activeBlue,
                        unselectedLabelColor: Colors.grey,
                        labelColor: SchoolDynamicColors.activeBlue,
                        dividerColor: SchoolDynamicColors.borderColor,
                        dividerHeight: 0.5,
                        splashFactory: NoSplash.splashFactory,
                        indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                    child: const TabBar(tabs: [
                      Tab(
                        text: 'Class',
                      ),
                      Tab(
                        text: 'School',
                      ),
                      Tab(
                        text: 'All India',
                      )
                    ]),
                  ),
                ),
                pinned: true,
                floating: true,
              ),
            ];
          },
          body: TabBarView(
            children: [
              Container(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    if (index < students.length) {
                      final student = students[index];
                      return LeaderboardProfileItem(
                        rank: (index + 1).toString(),
                        name: student.name,
                        username: student.username,
                        score: student.points,
                      );
                    } else {
                      return Container();
                    }
                  },
                  itemCount: 20,
                ),
              ),
              Container(),
              Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileItem(
    String name,
    String points,
    String rank, {
    double height = 80, // Default height is 80
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildAvatar(),
        Text(
          name,
          style: Theme.of(Get.context!)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: SchoolSizes.xs),
        _buildPointsContainer(points),
        const SizedBox(height: SchoolSizes.sm),
        _buildRankContainer(rank, height: height),
      ],
    );
  }

  Widget _buildAvatar() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: SchoolDynamicColors.activeOrange,
          width: 4,
        ),
        boxShadow: [
          BoxShadow(
            color: SchoolDynamicColors.activeOrange.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const CircleAvatar(
        radius: 36,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildPointsContainer(String points) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXlg),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        '$points Pts',
        style: Theme.of(Get.context!)
            .textTheme
            .labelLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }

  Widget _buildRankContainer(String rank, {double height = 80}) {
    return Container(
      alignment: Alignment.center,
      height: height,
      width: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: SchoolDynamicColors.white.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
          ),
        ],
        color: Colors.white.withOpacity(0.5),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(SchoolSizes.cardRadiusLg),
          topLeft: Radius.circular(SchoolSizes.cardRadiusLg),
        ),
      ),
      child: Text(
        rank,
        style: Theme.of(Get.context!)
            .textTheme
            .headlineLarge
            ?.copyWith(color: Colors.white),
      ),
    );
  }
}

class LeaderboardProfileItem extends StatelessWidget {
  final String rank;
  final String name;
  final String username;
  final int score;
  final String? avatarUrl;

  const LeaderboardProfileItem({
    Key? key,
    required this.rank,
    required this.name,
    required this.username,
    required this.score,
    this.avatarUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: SchoolSizes.sm + 4, horizontal: SchoolSizes.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Text(
                  rank,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(width: SchoolSizes.md),
                CircleAvatar(
                  backgroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
                  radius: 24,
                ),
                const SizedBox(width: SchoolSizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.titleLarge,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              const SizedBox(width: SchoolSizes.lg),
              Text(
                '$score   ',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(color: SchoolDynamicColors.activeBlue, fontSize: 15),
              ),
              Icon(
                Icons.token_rounded,
                size: 20,
                color: SchoolDynamicColors.activeOrange,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
