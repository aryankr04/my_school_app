import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/features/manage_school/models/school_class.dart';
import 'package:my_school_app/features/user/teacher/attendence/controller/submit_attendance_controller.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../data/repositories/school_class_repository.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/dynamic_colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../models/student_attendance.dart';

class MySubmitAttendance extends StatefulWidget {
  const MySubmitAttendance({Key? key}) : super(key: key);

  @override
  _MySubmitAttendanceState createState() => _MySubmitAttendanceState();
}

class _MySubmitAttendanceState extends State<MySubmitAttendance> {
  final SubmitAttendanceController _controller =
      Get.put(SubmitAttendanceController());

  @override
  void initState() {
    super.initState();
    _controller.fetchClass('CLA0000000001');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit Attendance'),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(SchoolSizes.lg),
        child: ElevatedButton(
          onPressed: () => _controller.addTodayAttendanceToClass(
            _controller.schoolClass!,
            _controller.studentAttendanceList,
            'TEA0000000001',
            'Aryan Kumar',
          ),
          child: Text('Confirm and Submit Attendance'),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Obx(() {

        return SingleChildScrollView(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              _buildAttendanceStatusRow(),
              const SizedBox(height: SchoolSizes.lg),
              _controller.hasAttendanceForToday(_controller.schoolClass!)
                  ? SizedBox()
                  : _buildNoAttendanceToday(),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Class ${_controller.schoolClass?.className} ${_controller.schoolClass?.section} ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: SchoolDynamicColors.headlineTextColor,
                      ),
                ),
              ),
              const SizedBox(height: SchoolSizes.md),
              _buildAttendanceList(),
              const SizedBox(height: 100),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildAttendanceStatusRow() {
    return Obx(() {
      return Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Today's Attendance Status",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: SchoolDynamicColors.headlineTextColor,
                  ),
            ),
          ),
          const SizedBox(height: SchoolSizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _attendanceCardWithIndicator(
                name: 'Present',
                value: _controller.totalPresentStudents.value,
                total: _controller.totalStudents.value,
                color: SchoolDynamicColors.activeGreen,
              ),
              SizedBox(width: SchoolSizes.lg),
              _attendanceCardWithIndicator(
                name: 'Absent',
                value: _controller.totalAbsentStudents.value,
                total: _controller.totalStudents.value,
                color: SchoolDynamicColors.activeRed,
              ),
            ],
          ),
        ],
      );
    });
  }

  Widget _attendanceCardWithIndicator({
    required String name,
    required int value,
    required int total,
    required Color color,
  }) {
    double percentage = total > 0 ? (value / total).clamp(0.0, 1.0) : 0.0;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
            vertical: SchoolSizes.sm, horizontal: SchoolSizes.sm),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
        ),
        child: Column(
          children: [
            CircularPercentIndicator(
              radius: 36,
              animateFromLastPercent: true,
              progressColor: color,
              backgroundColor: color.withOpacity(0.1),
              animation: true,
              animationDuration: 1000,
              circularStrokeCap: CircularStrokeCap.round,
              lineWidth: 6,
              percent: percentage,
              center: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Text(
                  '${(percentage * 100).toStringAsFixed(1)}%',
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: SchoolSizes.sm),
            Text(
              '$value/$total',
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: SchoolColors.headlineTextColor),
            ),
            SizedBox(height: SchoolSizes.sm - 6),
            Text(
              name,
              style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: SchoolColors.subtitleTextColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoAttendanceToday() {
    return Container(
      margin: EdgeInsets.only(bottom: SchoolSizes.lg),
      padding: const EdgeInsets.all(SchoolSizes.sm + 4),
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
        border: Border.all(width: 0.25, color: SchoolDynamicColors.borderColor),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: SchoolColors.activeRed, size: 24),
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              "Attendance Not Conducted for Today.",
              style: Theme.of(context).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.close_rounded,
                color: SchoolColors.iconColor, size: 24),
          ),
        ],
      ),
    );
  }

  Widget _buildAttendanceList() {
    return Container(
      decoration: BoxDecoration(
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
      ),
      child: Column(
        children: [
          _buildAttendanceHeader(),
          markAllWidget(),
          _controller.isLoadingAttendance.value
              ? _buildShimmerStudentsList()
              : _controller.studentAttendanceList.isNotEmpty
                  ? Obx(() {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _controller.studentAttendanceList.length,
                        itemBuilder: (context, index) {
                          var student =
                              _controller.studentAttendanceList[index];
                          return AttendanceCard(
                            name: student.name,
                            id: student.studentId,
                            roll: student.roll,
                            isPresent: student.isPresent,
                            onMarkPresent: () {
                              _controller.toggleAttendanceForStudent(
                                  student.studentId);
                              student.isPresent.value = true;
                              _controller.countPresentStudents();
                              _controller.countAbsentStudents();
                            },
                            onMarkAbsent: () {
                              _controller.toggleAttendanceForStudent(
                                  student.studentId);
                              student.isPresent.value = false;
                              _controller.countPresentStudents();
                              _controller.countAbsentStudents();
                            },
                          );
                        },
                      );
                    })
                  : const SizedBox(),
        ],
      ),
    );
  }

  Widget _buildAttendanceHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: SchoolSizes.md, horizontal: SchoolSizes.sm + 4),
      decoration: BoxDecoration(
        color: SchoolDynamicColors.activeBlue.withOpacity(0.1),
        border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(SchoolSizes.cardRadiusSm),
          topLeft: Radius.circular(SchoolSizes.cardRadiusSm),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Roll No",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SchoolDynamicColors.activeBlue,
                      fontWeight: FontWeight.w500)),
              SizedBox(
                width: SchoolSizes.sm + 4,
              ),
              Text("Student",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SchoolDynamicColors.activeBlue,
                      fontWeight: FontWeight.w500)),
            ],
          ),
          Row(
            children: [
              Text("Present",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SchoolDynamicColors.activeBlue,
                      fontWeight: FontWeight.w500)),
              const SizedBox(width: SchoolSizes.md),
              Text("Absent",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SchoolDynamicColors.activeBlue,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      ),
    );
  }

  Widget markAllWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(
          vertical: SchoolSizes.sm, horizontal: SchoolSizes.sm),
      decoration: BoxDecoration(
        color: SchoolHelperFunctions.isDarkMode(Get.context!)
            ? SchoolDynamicColors.darkerGreyBackgroundColor
            : SchoolDynamicColors.activeOrangeTint,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 60),
              Text(
                "Mark All",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: SchoolDynamicColors.headlineTextColor,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
          Obx(
            () => Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _controller.toggleAttendanceForAll(true);
                    _controller.isPresentAll.value = true;
                    _controller.countPresentStudents();
                    _controller.countAbsentStudents();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(SchoolSizes.sm),
                    decoration: BoxDecoration(
                      color: _controller.areAllStudentsPresent()
                          ? SchoolDynamicColors.activeGreenTint
                          : SchoolDynamicColors.white,
                      shape: BoxShape.circle,
                    ),
                    child: _controller.areAllStudentsPresent()
                        ? Icon(
                            Icons.check_circle_outline,
                            size: 24,
                            color: SchoolDynamicColors.activeGreen,
                          )
                        : const Icon(
                            Icons.circle_outlined,
                            size: 24,
                            color: SchoolDynamicColors.black,
                          ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _controller.toggleAttendanceForAll(false);
                    _controller.isPresentAll.value = false;
                    _controller.countPresentStudents();
                    _controller.countAbsentStudents();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(SchoolSizes.sm),
                    decoration: BoxDecoration(
                      color: !_controller.areAllStudentsAbsent()
                          ? SchoolDynamicColors.white
                          : SchoolDynamicColors.activeRedTint,
                      shape: BoxShape.circle,
                    ),
                    child: !_controller.areAllStudentsAbsent()
                        ? const Icon(
                            Icons.circle_outlined,
                            size: 24,
                            color: SchoolDynamicColors.black,
                          )
                        : Icon(
                            Icons.cancel,
                            size: 24,
                            color: SchoolDynamicColors.activeRed,
                          ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildShimmerStudentsList() {
  return Shimmer.fromColors(
    baseColor: SchoolDynamicColors.backgroundColorGreyLightGrey!,
    highlightColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey!,
    child: ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                width: double.infinity, height: 35, color: Colors.white),
          ),
        );
      },
    ),
  );
}

class AttendanceCard extends StatelessWidget {
  final String name;
  final String id;
  final String roll;
  final RxBool isPresent;
  final VoidCallback onMarkPresent;
  final VoidCallback onMarkAbsent;

  AttendanceCard({
    super.key,
    required this.name,
    required this.id,
    required this.roll,
    required this.isPresent,
    required this.onMarkPresent,
    required this.onMarkAbsent,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 12.0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                    backgroundColor:
                        SchoolDynamicColors.activeBlue.withOpacity(0.1),
                    child: Text(
                      roll,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: SchoolDynamicColors.activeBlue,
                          ),
                    )),
                const SizedBox(width: SchoolSizes.md),
                SizedBox(
                  width: 170,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              Text(
                                id,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: isPresent.value ? onMarkAbsent : onMarkPresent,
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: isPresent.value
                          ? SchoolDynamicColors.activeGreenTint
                          : Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPresent.value
                          ? Icons.check_circle_outline
                          : Icons.circle_outlined,
                      size: 24,
                      color: isPresent.value
                          ? SchoolDynamicColors.activeGreen
                          : Colors.black, // Fixed color values
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: isPresent.value ? onMarkAbsent : onMarkPresent,
                  child: Container(
                    padding: const EdgeInsets.all(8.0), // Fixed padding value
                    decoration: BoxDecoration(
                      color: isPresent.value
                          ? Colors.white
                          : SchoolDynamicColors
                              .activeRedTint, // Fixed color value
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isPresent.value ? Icons.circle_outlined : Icons.cancel,
                      size: 24,
                      color: isPresent.value
                          ? Colors.black
                          : SchoolDynamicColors.activeRed, // Fixed color values
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
