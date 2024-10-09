import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/attendence/attendence.dart';
import 'package:my_school_app/features/user/student/fees/fees.dart';
import 'package:my_school_app/features/user/student/homework/homework.dart';
import 'package:my_school_app/features/user/student/noticeboard/noticeboard.dart';
import 'package:my_school_app/features/user/student/online_class/online_class.dart';
import 'package:my_school_app/features/user/student/result/result.dart';
import 'package:my_school_app/features/user/student/syllabus_and_routine/syllabus.dart';
import 'package:my_school_app/features/user/student/take_leave/take_leave.dart';
import 'package:my_school_app/features/user/student/track_bus/track_bus.dart';
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: SchoolSizes.lg,
            vertical: SchoolSizes.lg,
          ),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DashboardHeader(),
                const SizedBox(height: SchoolSizes.spaceBtwSections),
                Text(
                  'Hey Aryan Student,',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 22),
                ),
                Text(
                  'Unlock Success with our innovative school app',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: SchoolDynamicColors.subtitleTextColor,
                      fontSize: 15),
                ),
                const SizedBox(height: SchoolSizes.defaultSpace),
                SchoolCarouselSliderWithIndicator(images: imageUrls),
                const SizedBox(height: SchoolSizes.defaultSpace),
                RankOverview(),
                AttendanceOverview(),
                FeeDetails(),
                School(),
                Study(),
                Others(),
              ],
            ),
          ),
        ),
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
          padding: EdgeInsets.all(SchoolSizes.md),
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
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'View',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SchoolDynamicColors.subtitleTextColor, fontSize: 13),
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.md),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(SchoolSizes.sm),
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
                  SizedBox(
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
        const SizedBox(height: SchoolSizes.lg),
      ],
    );
  }

  var present = 73.63;
  var absent = 26.45;
  Widget AttendanceOverview() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(SchoolSizes.md),
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
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'View',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SchoolDynamicColors.subtitleTextColor, fontSize: 13),
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
                      SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Presents',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '23 Days',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        SchoolDynamicColors.activeGreen),
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
                      SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Absents',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '3 Days',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color:
                                        SchoolDynamicColors.activeRed),
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
        const SizedBox(height: SchoolSizes.sm),
        Container(
          padding: EdgeInsets.all(SchoolSizes.md),
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
                      'Leaderboard',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    'View',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: SchoolDynamicColors.subtitleTextColor, fontSize: 13),
                  ),
                ],
              ),
              SizedBox(
                height: SchoolSizes.md,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(SchoolSizes.sm),
                        decoration: BoxDecoration(
                          color:
                              SchoolDynamicColors.activeBlue.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(SchoolSizes.cardRadiusXs),
                        ),
                        child: Icon(
                          Icons.public,
                          color: SchoolDynamicColors.activeBlue,
                        ),
                      ),
                      SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'All India Rank',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '35412',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: SchoolDynamicColors.activeBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(SchoolSizes.sm),
                        decoration: BoxDecoration(
                          color:
                              SchoolDynamicColors.activeOrange.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(SchoolSizes.cardRadiusXs),
                        ),
                        child: Icon(
                          Icons.account_balance,
                          color: SchoolDynamicColors.activeOrange,
                        ),
                      ),
                      SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'School Rank',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '2353',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: SchoolDynamicColors.activeBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: SchoolSizes.md + 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(SchoolSizes.sm),
                        decoration: BoxDecoration(
                          color: SchoolDynamicColors.activeRed.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(SchoolSizes.cardRadiusXs),
                        ),
                        child: Icon(
                          Icons.class_,
                          color: SchoolDynamicColors.activeRed,
                        ),
                      ),
                      SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Class Rank',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '2353',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: SchoolDynamicColors.activeBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(SchoolSizes.sm),
                        decoration: BoxDecoration(
                          color:
                              SchoolDynamicColors.activeGreen.withOpacity(0.1),
                          borderRadius:
                              BorderRadius.circular(SchoolSizes.cardRadiusXs),
                        ),
                        child: Icon(
                          Icons.offline_bolt,
                          color: SchoolDynamicColors.activeGreen,
                        ),
                      ),
                      SizedBox(
                        width: SchoolSizes.md,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total Points',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15),
                          ),
                          Text(
                            '18540',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                                    color: SchoolDynamicColors.activeBlue),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: SchoolSizes.lg),
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
              child: Icon(
                Icons.menu_rounded,
                size: SchoolSizes.iconMd,
                color: SchoolDynamicColors.iconColor,
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: SchoolSizes.iconMd,
                  color: SchoolDynamicColors.iconColor,
                ),
                SizedBox(
                  width: SchoolSizes.lg,
                ),
                Icon(
                  Icons.notifications_none_rounded,
                  size: SchoolSizes.iconMd,
                  color: SchoolDynamicColors.iconColor,
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Widget School() {
    return Column(
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
        const SizedBox(height: SchoolSizes.spaceBtwSections),
      ],
    );
  }

  Widget Study() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Study',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: SchoolSizes.sm),
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
        const SizedBox(height: SchoolSizes.spaceBtwSections),
      ],
    );
  }

  Widget Others() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child:
              Text('Other', style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(height: SchoolSizes.sm),
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
        const SizedBox(height: SchoolSizes.spaceBtwSections),
      ],
    );
  }
}
