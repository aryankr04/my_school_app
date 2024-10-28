import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_school_app/common/widgets/color_chips.dart';
import 'package:my_school_app/features/user/student/attendence/attendence.dart';
import 'package:my_school_app/features/user/student/fees/fees.dart';
import 'package:my_school_app/features/user/student/homework/homework.dart';
import 'package:my_school_app/features/user/student/noticeboard/noticeboard.dart';
import 'package:my_school_app/features/user/student/online_class/online_class.dart';
import 'package:my_school_app/features/user/student/result/result.dart';
import 'package:my_school_app/features/user/student/syllabus_and_routine/syllabus.dart';
import 'package:my_school_app/features/user/student/take_leave/take_leave.dart';
import 'package:my_school_app/features/user/student/track_bus/track_bus.dart';
import 'package:my_school_app/utils/constants/colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../../common/widgets/carousel _slider_with_indicator.dart';
import '../../../../../common/widgets/square_icon_button.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../manage_routine/screens/student/routine.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({Key? key}) : super(key: key);

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

List<dynamic> imageUrls = const [
  // 'https://source.unsplash.com/random/800x600',
  // 'https://loremflickr.com/320/240',
  // 'https://picsum.photos/400/300',
  // 'https://picsum.photos/300/400',
  // 'https://picsum.photos/250/350',
  // 'https://picsum.photos/350/250',
  // 'https://picsum.photos/400/400',
  // 'https://picsum.photos/500/300',
  AssetImage('assets/images/banners/back_to_school.jpg'),
  AssetImage('assets/images/banners/group_study_3.jpg'),
  AssetImage('assets/images/banners/international_day_education.jpg'),
  AssetImage('assets/images/banners/Its_time_to_school.jpg'),
  AssetImage('assets/images/banners/school2.jpg'),
  AssetImage('assets/images/banners/school_3.jpg'),
  AssetImage('assets/images/banners/studying.jpg'),
  AssetImage('assets/images/banners/welcome_back_to_school.jpg'),
  AssetImage('assets/images/banners/winter_landscape.jpg'),
];

class _StudentHomeState extends State<StudentHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Color(0xff1191FD), Color(0xff5E59F2)],
              end: Alignment.centerRight,
              begin: Alignment.topLeft),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff1191FD), Color(0xff5E59F2)],
                        end: Alignment.bottomRight,
                        begin: Alignment.topLeft),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: SchoolSizes.lg,
                        right: SchoolSizes.lg,
                        top: SchoolSizes.lg,
                        bottom: SchoolSizes.md),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DashboardHeader(),
                        const SizedBox(height: SchoolSizes.lg),
                        Text(
                          'Hey Aryan Student,',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  fontSize: 22,
                                  color: SchoolDynamicColors.white,
                                  height: 0),
                        ),
                        Text(
                          'Unlock Success with our innovative school app',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: SchoolDynamicColors.white
                                      ?.withOpacity(0.5),
                                  fontSize: 15),
                        ),
                        const SizedBox(height: SchoolSizes.sm),
                        SchoolCarouselSliderWithIndicator(images: imageUrls),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(SchoolSizes.lg),
                  decoration: BoxDecoration(
                    color: SchoolDynamicColors.lightGrey,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(SchoolSizes.lg),
                        topRight: Radius.circular(SchoolSizes.lg)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance',
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: SchoolSizes.md),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          attendanceCardWithIndicator(
                            name: 'Total Presents',
                            value: 22,
                            percentage: 73.6,
                            color: SchoolDynamicColors.activeGreen,
                          ),
                          attendanceCardWithIndicator(
                            name: 'Total Absents',
                            value: 4,
                            percentage: 15.4,
                            color: SchoolDynamicColors.activeRed,
                          ),
                          attendanceCardWithIndicator(
                            name: 'Total Working',
                            value: 26,
                            percentage: 100,
                            color: SchoolDynamicColors.activeBlue,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: SchoolSizes.spaceBtwSections,
                      ),
                      School(),
                      const SizedBox(
                        height: SchoolSizes.spaceBtwSections,
                      ),
                      RankOverview(),

                      const SizedBox(
                        height: SchoolSizes.spaceBtwSections,
                      ),
                      //AttendanceOverview(),
                      Study(),
                      const SizedBox(
                        height: SchoolSizes.spaceBtwSections,
                      ),
                      Others(),
                      const SizedBox(
                        height: SchoolSizes.spaceBtwSections,
                      ),
                      FeeDetails()
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget attendanceCardWithIndicator({
    required String name,
    required int value,
    required double percentage,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: SchoolSizes.md, horizontal: SchoolSizes.md - 5),
      decoration: BoxDecoration(
        color: color.withOpacity(
            0.1), // Use color with some transparency for background
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
      ),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 30,
            animateFromLastPercent: true,
            progressColor: color,
            backgroundColor: color.withOpacity(0.1),
            animation: true,
            animationDuration: 1000,
            circularStrokeCap: CircularStrokeCap.round,
            lineWidth: 4,
            percent: percentage / 100,
            center: CircleAvatar(
              radius: 25,
              backgroundColor: Colors.white,
              child: Text(
                '${percentage.toStringAsFixed(1)}%',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black, // Use a contrasting color
                ),
              ),
            ),
          ),
          SizedBox(
            height: SchoolSizes.sm,
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: SchoolColors.subtitleTextColor,
            ),
          ),
          Text(
            '$value Days',
            style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: SchoolColors
                    .headlineTextColor, // Text color for the main value
                height: 0),
          ),
        ],
      ),
    );
  }

  Future<dynamic> getGreeting() async {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  Widget FeeDetails() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(SchoolSizes.md),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
            borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
            border: Border.all(
                width: 0.25,
                color: SchoolDynamicColors.borderColor.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Fee Details',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ColorChips(
                    text: 'View Details',
                    color: SchoolColors.activeBlue,
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.md),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(SchoolSizes.sm),
                    decoration: BoxDecoration(
                      color: SchoolDynamicColors.activeBlue.withOpacity(0.1),
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusXs),
                    ),
                    child: Icon(
                      Icons.currency_rupee,
                      color: SchoolDynamicColors.activeBlue,
                    ),
                  ),
                  const SizedBox(
                    width: SchoolSizes.md,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Fee Due',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        '₹ 18500',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: SchoolDynamicColors.activeBlue),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  var present = 73.63;
  var absent = 26.45;
  Widget AttendanceOverview() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(SchoolSizes.md),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
            borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
            border: Border.all(
                width: 0.25,
                color: SchoolDynamicColors.borderColor.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Attendance',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'View',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SchoolDynamicColors.activeBlue, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 32,
                        animateFromLastPercent: true,
                        progressColor: SchoolDynamicColors.activeGreen,
                        backgroundColor:
                            SchoolDynamicColors.activeGreen.withOpacity(0.1),
                        animation: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        lineWidth: 6,
                        percent: present / 100,
                        center: Text(
                          '${(present).toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: SchoolDynamicColors
                                .headlineTextColor, // Adjust the color as needed
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Presents',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '23 Days',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: SchoolDynamicColors.activeGreen),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CircularPercentIndicator(
                        radius: 32,
                        animateFromLastPercent: true,
                        progressColor: SchoolDynamicColors.activeRed,
                        backgroundColor:
                            SchoolDynamicColors.activeRed.withOpacity(0.1),
                        animation: true,
                        circularStrokeCap: CircularStrokeCap.round,
                        lineWidth: 6,
                        percent: absent / 100,
                        center: Text(
                          '${(absent).toStringAsFixed(1)}%',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: SchoolDynamicColors
                                .headlineTextColor, // Adjust the color as needed
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Absents',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '3 Days',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: SchoolDynamicColors.activeRed),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: SchoolSizes.lg),
      ],
    );
  }

  Widget RankOverview() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(SchoolSizes.md),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 3),
              ),
            ],
            color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
            borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
            border: Border.all(
                width: 0.25,
                color: SchoolDynamicColors.borderColor.withOpacity(0.5)),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      'Leaderboard',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  ColorChips(
                    text: 'View all',
                    color: SchoolColors.activeBlue,
                  )
                ],
              ),
              const SizedBox(
                height: SchoolSizes.md,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRankRow(
                      icon: Icons.public,
                      iconColor: SchoolColors.activeBlue,
                      label: 'All India Rank',
                      value: '323765'),
                  _buildRankRow(
                      icon: Icons.home_work_outlined,
                      iconColor: SchoolColors.activeOrange,
                      label: 'School Rank',
                      value: '426'),
                ],
              ),
              const SizedBox(
                height: SchoolSizes.md + 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildRankRow(
                      icon: Icons.class_,
                      iconColor: SchoolColors.activeRed,
                      label: 'Class Rank',
                      value: '23'),
                  _buildRankRow(
                      icon: Icons.offline_bolt,
                      iconColor: SchoolColors.activeGreen,
                      label: 'Total Points',
                      value: '56562'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRankRow({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(SchoolSizes.sm),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: SchoolSizes.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: SchoolColors.subtitleTextColor),
                ),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: SchoolColors.headlineTextColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget DashboardHeader() {
    return Builder(
      builder: (BuildContext context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer(); // Open the drawer
              },
              child: CircleAvatar(
                backgroundColor: SchoolDynamicColors.white.withOpacity(0.1),
                child: const Icon(Icons.menu_rounded,
                    size: SchoolSizes.iconMd, color: SchoolDynamicColors.white),
              ),
            ),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: SchoolDynamicColors.white.withOpacity(0.1),
                  child: Icon(
                    Icons.search_rounded,
                    size: SchoolSizes.iconMd,
                    color: SchoolDynamicColors.white,
                  ),
                ),
                SizedBox(
                  width: SchoolSizes.lg,
                ),
                CircleAvatar(
                  backgroundColor: SchoolDynamicColors.white.withOpacity(0.1),
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: SchoolSizes.iconMd,
                    color: SchoolDynamicColors.white,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget School() {
    return Container(
      padding: const EdgeInsets.all(SchoolSizes.md),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
        border: Border.all(
            width: 0.25,
            color: SchoolDynamicColors.borderColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'School',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: SchoolSizes.sm),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SchoolIcon(
                icon: Icons.assignment_rounded,
                text: 'Homework',
                color: SchoolDynamicColors.colorBlue,
                destination: Homework(),
              ),
              SchoolIcon(
                icon: Icons.date_range,
                text: 'Attendance',
                color: SchoolDynamicColors.colorOrange,
                destination: Attendance(),
              ),
              SchoolIcon(
                icon: Icons.assignment,
                text: 'Noticeboard',
                color: SchoolDynamicColors.colorYellow,
                destination: Noticeboard(),
              ),
              SchoolIcon(
                icon: Icons.book,
                text: 'Syllabus',
                color: SchoolDynamicColors.colorGreen,
                destination: Syllabus(),
              ),
            ],
          ),
          const SizedBox(height: SchoolSizes.defaultSpace),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SchoolIcon(
                icon: Icons.receipt_outlined,
                text: 'Routine',
                color: SchoolDynamicColors.colorSkyBlue,
                destination: Routine(),
              ),
              SchoolIcon(
                icon: Icons.directions_bus_filled,
                text: 'Track Bus',
                color: SchoolDynamicColors.colorPink,
                destination: TrackBus(),
              ),
              SchoolIcon(
                icon: Icons.ondemand_video,
                text: 'Online Class',
                color: SchoolDynamicColors.colorTeal,
                destination: OnlineClasses(),
              ),
              SchoolIcon(
                icon: Icons.assignment_turned_in_rounded,
                text: 'Take Leave',
                color: SchoolDynamicColors.colorRed,
                destination: TakeLeave(),
              ),
            ],
          ),
          const SizedBox(height: SchoolSizes.defaultSpace),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SchoolIcon(
                icon: Icons.monetization_on_outlined,
                text: 'Fees',
                color: SchoolDynamicColors.colorPurple,
                destination: Fees(),
              ),
              SchoolIcon(
                icon: Icons.laptop_chromebook_rounded,
                text: 'Online Exam',
                color: SchoolDynamicColors.colorViolet,
              ),
              SchoolIcon(
                icon: Icons.library_books_rounded,
                text: 'Result',
                color: SchoolDynamicColors.colorOrange,
                destination: Result(),
              ),
              SizedBox(
                width: 65,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Study() {
    return Container(
      padding: const EdgeInsets.all(SchoolSizes.md),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
        border: Border.all(
            width: 0.25,
            color: SchoolDynamicColors.borderColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              'Study',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(height: SchoolSizes.md),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SchoolIcon(
                icon: Icons.menu_book_rounded,
                text: 'Notes',
                color: SchoolDynamicColors.colorBlue,
              ),
              SchoolIcon(
                icon: Icons.ondemand_video_rounded,
                text: 'Video Lecture',
                color: SchoolDynamicColors.colorRed,
              ),
              SchoolIcon(
                icon: Icons.quiz,
                text: 'Quiz',
                color: SchoolDynamicColors.colorYellow,
              ),
              SchoolIcon(
                icon: Icons.collections_bookmark,
                text: 'Practice',
                color: SchoolDynamicColors.colorOrange,
              ),
            ],
          ),
          const SizedBox(height: SchoolSizes.defaultSpace),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SchoolIcon(
                icon: Icons.library_books_rounded,
                text: 'Library',
                color: SchoolDynamicColors.colorGreen,
              ),
              SchoolIcon(
                icon: Icons.abc_rounded,
                text: 'Learn English',
                color: SchoolDynamicColors.colorViolet,
              ),
              SizedBox(
                width: 70,
              ),
              SizedBox(
                width: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget Others() {
    return Container(
      padding: const EdgeInsets.all(SchoolSizes.md),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 3),
          ),
        ],
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
        border: Border.all(
            width: 0.25,
            color: SchoolDynamicColors.borderColor.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child:
                Text('Other', style: Theme.of(context).textTheme.headlineSmall),
          ),
          const SizedBox(height: SchoolSizes.md),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SchoolIcon(
                icon: Icons.download,
                text: 'Downloads',
                color: SchoolDynamicColors.colorBlue,
              ),
              SchoolIcon(
                icon: Icons.timer,
                text: 'To Do List',
                color: SchoolDynamicColors.colorRed,
              ),
              SizedBox(
                width: 70,
              ),
              SizedBox(
                width: 70,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
