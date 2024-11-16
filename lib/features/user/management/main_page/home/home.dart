import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:my_school_app/features/user/management/noticeboard/noticeboard.dart';
import 'package:my_school_app/features/user/student/attendence/attendence.dart';
import 'package:my_school_app/features/user/student/fees/fees.dart';
import 'package:my_school_app/features/user/student/homework/homework.dart';
import 'package:my_school_app/features/user/student/result/result.dart';
import 'package:my_school_app/features/user/student/take_leave/take_leave.dart';
import 'package:my_school_app/features/user/student/track_bus/track_bus.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../../../../../common/widgets/carousel _slider_with_indicator.dart';
import '../../../../../common/widgets/square_icon_button.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../manage_routine/screens/management/manage_routine.dart';
import '../../../../manage_routine/screens/student/routine.dart';
import '../../../student/result/create_result_format.dart';
import '../../../teacher/attendence/screens/attendence.dart';
import '../../manage_syllabus/manage_syllabus.dart';

class NavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Aryan Kumar'),
            accountEmail: Text('aryankr_04'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://avatar.iran.liara.run/public/18',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.favorite,color: SchoolDynamicColors.iconColor,),
            title: Text(
              'Favorites',
              style: TextStyle(color: SchoolDynamicColors.headlineTextColor),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.person,color: SchoolDynamicColors.iconColor,),
            title: Text(
              'Friends',
              style: TextStyle(color: SchoolDynamicColors.headlineTextColor),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.share,color: SchoolDynamicColors.iconColor,),
            title: Text(
              'Share',
              style: TextStyle(color: SchoolDynamicColors.headlineTextColor),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.notifications,color: SchoolDynamicColors.iconColor,),
            title: Text(
              'Request',
              style: TextStyle(color: SchoolDynamicColors.headlineTextColor),
            ),
          ),
          Divider(color: SchoolDynamicColors.borderColor,),
          ListTile(
            leading: Icon(Icons.settings,color: SchoolDynamicColors.iconColor,),
            title: Text(
              'Settings',
              style: TextStyle(color: SchoolDynamicColors.headlineTextColor),
            ),
            onTap: () => null,
          ),
          ListTile(
            leading: Icon(Icons.description,color: SchoolDynamicColors.iconColor,),
            title: Text(
              'Policies',
              style: TextStyle(color: SchoolDynamicColors.headlineTextColor),
            ),
            onTap: () => null,
          ),
          Divider(color: SchoolDynamicColors.borderColor,),
          ListTile(
            title: Text(
              'Exit',
              style: TextStyle(color: SchoolDynamicColors.headlineTextColor),
            ),
            leading: Icon(Icons.exit_to_app,color: SchoolDynamicColors.iconColor,),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}

class ManagementHome extends StatefulWidget {
  const ManagementHome({Key? key}) : super(key: key);

  @override
  State<ManagementHome> createState() => _ManagementHomeState();
}

class _ManagementHomeState extends State<ManagementHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
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
                  'Hey Aryan Manager,',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontSize: 22),
                ),
                Text(
                  'Unlock Success with our innovative school app',
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: SchoolDynamicColors.subtitleTextColor, fontSize: 15),
                ),
                const SizedBox(height: SchoolSizes.defaultSpace),
                SchoolCarouselSliderWithIndicator(images: imageUrls),
                const SizedBox(height: SchoolSizes.defaultSpace),
                Management(),
                Teacher(),
                Students(),
                Study(),
                School(),
                Others(),
              ],
            ),
          ),
        ),
      ),
    );
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

  String getGreeting() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
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
  Widget Management() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Management',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: SchoolSizes.sm),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SchoolIcon(
              icon: Icons.date_range,
              text: 'Attendance',
              color: SchoolDynamicColors.colorOrange,
              destination: Attendance(),
            ),
            SchoolIcon(
              icon: Icons.assignment_rounded,
              text: 'Timetable',
              color: SchoolDynamicColors.colorBlue,
              destination: Homework(),
            ),
            SchoolIcon(
              icon: Icons.book,
              text: 'Take Leave',
              color: SchoolDynamicColors.colorGreen,
              destination: TakeLeave(),
            ),
            SchoolIcon(
              icon: Icons.assignment,
              text: 'Noticeboard',
              color: SchoolDynamicColors.colorYellow,
              destination: Noticeboard(),
            ),
          ],
        ),
        const SizedBox(
          height: SchoolSizes.spaceBtwSections,
        )
      ],
    );
  }

  Widget Teacher() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Teacher',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: SchoolSizes.sm),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SchoolIcon(
              icon: Icons.assignment_rounded,
              text: 'Manage Routine',
              color: SchoolDynamicColors.colorBlue,
              destination: ManageRoutine(),
            ),


          ],
        ),
        const SizedBox(
          height: SchoolSizes.spaceBtwSections,
        )
      ],
    );
  }

  Widget Students() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            'Students',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
        ),
        const SizedBox(height: SchoolSizes.sm),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            SchoolIcon(
              icon: Icons.date_range,
              text: 'Attendance',
              color: SchoolDynamicColors.colorOrange,
              destination: TAttendance(),
            ),
            SchoolIcon(
              icon: Icons.receipt_outlined,
              text: 'Manage Routine',
              color: SchoolDynamicColors.colorSkyBlue,
              destination: MyRoutine(),
            ),
            SchoolIcon(
              icon: Icons.book,
              text: 'Manage Syllabus',
              color: SchoolDynamicColors.colorGreen,
              destination: ManageSyllabus(),
            ),
            SchoolIcon(
              icon: SvgPicture.asset(
                'assets/logos/exam_result.svg',
                color: Colors.white,
                fit: BoxFit.cover,
              ),
              text: 'Result',
              color: SchoolDynamicColors.colorOrange,
              destination: CreateResultFormat(),
            ),
          ],
        ),
        const SizedBox(height: SchoolSizes.lg),

        Row(          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            SchoolIcon(
              icon: Icons.monetization_on_outlined,
              text: 'Fees',
              color: SchoolDynamicColors.colorPurple,
              destination: Fees(),
            ),
            SizedBox(
              width: 70,
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
              icon: Icons.directions_bus_filled,
              text: 'Track Bus',
              color: SchoolDynamicColors.colorPink,
              destination: TrackBus(),
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
              icon: Icons.library_books_rounded,
              text: 'Library',
              color: SchoolDynamicColors.colorGreen,
            ),
            SizedBox(width: 70,)
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
