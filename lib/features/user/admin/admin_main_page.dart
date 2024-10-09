import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/student/online_class/online_class.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../common/widgets/square_icon_button.dart';
import '../../authentication/screens/create_account.dart';
import '../../manage_school/screens/add_class.dart';
import '../../manage_school/screens/add_school.dart';


class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
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
                  'Welcome Back',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                ),
                Text(
                  'Aryan',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                const SizedBox(height: SchoolSizes.spaceBtwSections),
                buildContainerFees(context),
                const SizedBox(height: SchoolSizes.spaceBtwSections),
                School(),
                Teachers(),
                Students()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Card buildContainerFees(BuildContext context) {
    return Card(
      elevation: 0,
      color: SchoolDynamicColors.primaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusLg),
      ),
      child: Padding(
        padding: const EdgeInsets.all(SchoolSizes.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: CupertinoColors.activeGreen,
                        borderRadius:
                        BorderRadius.circular(SchoolSizes.borderRadiusMd),
                      ),
                      child: const Icon(
                        Icons.currency_rupee_rounded,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: SchoolSizes.md),
                    Text(
                      'Fees',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child:  Text(
                    'View Report',
                    style: TextStyle(
                      color: SchoolDynamicColors.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: SchoolSizes.sm),
            const SizedBox(height: SchoolSizes.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '₹',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: SchoolDynamicColors.activeGreen),
                        ),
                        const SizedBox(width: SchoolSizes.sm),
                        Text(
                          '945,632.87',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: SchoolDynamicColors.activeGreen),
                        ),
                      ],
                    ),
                    const SizedBox(height: SchoolSizes.xs),
                    Text(
                      'Today\'s Collection',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                _buildPercentageChangeWidget(10.5),
              ],
            ),
            const SizedBox(
              height: SchoolSizes.spaceBtwItems,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '₹',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: SchoolDynamicColors.activeRed),
                        ),
                        const SizedBox(width: SchoolSizes.sm),
                        Text(
                          '945,632.87',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(color: SchoolDynamicColors.activeRed),
                        ),
                      ],
                    ),
                    const SizedBox(height: SchoolSizes.xs),
                    Text(
                      'Total Pending Due',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
                _buildPercentageChangeWidget(-5.2),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPercentageChangeWidget(double percentageChange) {
    return Text(
      '${percentageChange > 0 ? '+' : ''}${percentageChange.toStringAsFixed(2)}%',
      style: TextStyle(
        color: percentageChange > 0 ? SchoolDynamicColors.activeGreen : SchoolDynamicColors.activeRed,
        fontSize: 16,
      ),
    );
  }

  Widget DashboardHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              color: SchoolDynamicColors.disabledIconColor.withOpacity(.4),
              borderRadius: BorderRadius.circular(SchoolSizes.buttonRadius),
            ),
            child: const Center(
              child: Icon(
                Icons.menu_rounded,
                size: SchoolSizes.iconMd,
              ),
            ),
          ),
        ),
        Row(
          children: [
            InkWell(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.disabledIconColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(SchoolSizes.buttonRadius),
                ),
                child: const Center(
                  child: Icon(
                    Icons.search_rounded,
                    size: SchoolSizes.iconMd,
                  ),
                ),
              ),
            ),
            const SizedBox(width: SchoolSizes.defaultSpace),
            InkWell(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.disabledIconColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(SchoolSizes.buttonRadius),
                ),
                child: const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    size: SchoolSizes.defaultSpace,
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget School() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child:
          Text('School', style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(height: SchoolSizes.spaceBtwItems),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SchoolIcon(
              destination: AddSchool(),
              icon: Icons.school_rounded,
              text: 'School',
              color: SchoolDynamicColors.colorBlue,
            ),
            SchoolIcon(
              icon: Icons.person,
              text: 'User',
              color: SchoolDynamicColors.colorYellow,
              destination: CreateAccount(),
            ),
            SchoolIcon(
              icon: Icons.class_,
              text: 'Class',
              color: SchoolDynamicColors.colorPink,
              destination: AddClass(),
            ),

          ],
        ),
        const SizedBox(height: SchoolSizes.spaceBtwSections),
      ],
    );
  }

  Widget Teachers() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text('Vehicle',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(height: SchoolSizes.spaceBtwItems),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SchoolIcon(
              icon: Icons.money_rounded,
              text: 'Details',
              color: SchoolDynamicColors.colorBlue,
            ),
            SchoolIcon(
              icon: Icons.date_range,
              text: 'Subjects',
              color: SchoolDynamicColors.colorRed,
            ),
            SchoolIcon(
              icon: Icons.date_range,
              text: 'Exam',
              color: SchoolDynamicColors.colorRed,
            ),
            SchoolIcon(
              icon: Icons.date_range,
              text: 'Vehicle',
              color: SchoolDynamicColors.colorRed,
            ),
          ],
        ),
        const SizedBox(height: SchoolSizes.spaceBtwSections),
      ],
    );
  }

  Widget Students() {
    return Column(
      children: [
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text('Students',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        const SizedBox(height: SchoolSizes.spaceBtwItems),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SchoolIcon(
              icon: Icons.currency_rupee_rounded,
              text: 'Fees',
              color: SchoolDynamicColors.colorBlue,
            ),
            SchoolIcon(
              icon: Icons.receipt_outlined,
              text: 'Routine',
              color: SchoolDynamicColors.colorSkyBlue,
            ),
            SchoolIcon(
              icon: Icons.ondemand_video,
              text: 'Online Class',
              color: SchoolDynamicColors.colorTeal,
              destination: OnlineClasses(),
            ),
            SchoolIcon(
              icon: Icons.laptop_chromebook_rounded,
              text: 'Online Exam',
              color: SchoolDynamicColors.colorViolet,
            ),
          ],
        ),
        const SizedBox(height: SchoolSizes.defaultSpace),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SchoolIcon(
              icon: Icons.library_books_rounded,
              text: 'Result',
              color: SchoolDynamicColors.colorOrange,
            ),
            SchoolIcon(
              icon: Icons.book,
              text: 'Syllabus',
              color: SchoolDynamicColors.colorGreen,
            ),
            SizedBox(
              width: 70,
            ),
            SizedBox(
              width: 70,
            ),
          ],
        ),
        SizedBox(
          height: SchoolSizes.spaceBtwSections,
        )
      ],
    );
  }
}
