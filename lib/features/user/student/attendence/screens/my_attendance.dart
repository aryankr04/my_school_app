import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../attendence.dart';

class MyAttendanceCalendar extends StatelessWidget {
  final RxList<StudentAttendance0> studentAttendanceList; // Reactive attendance list

  MyAttendanceCalendar({required this.studentAttendanceList, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Create a map of attendance records from the RxList
      Map<String, bool> attendanceRecords = {
        for (var attendance in studentAttendanceList)
          attendance.date: attendance.status == "Present",
      };

      return _AttendanceCalendarWidget(attendanceRecords: attendanceRecords);
    });
  }
}

class _AttendanceCalendarWidget extends StatefulWidget {
  final Map<String, bool> attendanceRecords; // Date ('YYYY-MM-DD') -> Present (true/false)

  _AttendanceCalendarWidget({required this.attendanceRecords, Key? key})
      : super(key: key);

  @override
  _AttendanceCalendarWidgetState createState() =>
      _AttendanceCalendarWidgetState();
}

class _AttendanceCalendarWidgetState extends State<_AttendanceCalendarWidget> {
  DateTime _currentMonth = DateTime.now();

  void _changeMonth(int increment) {
    setState(() {
      _currentMonth = DateTime(
        _currentMonth.year,
        _currentMonth.month + increment,
        1,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String yearMonth = DateFormat('yyyy-MM').format(_currentMonth);

    // Generate list of all days in the current month
    final DateTime firstDayOfMonth =
    DateTime(_currentMonth.year, _currentMonth.month, 1);
    final DateTime lastDayOfMonth =
    DateTime(_currentMonth.year, _currentMonth.month + 1, 0);
    final int daysInMonth = lastDayOfMonth.day;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        border: Border.all(width: .5, color: SchoolDynamicColors.borderColor),
      ),
      child: Column(
        children: [
          // Header with navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => _changeMonth(-1), // Go to previous month
              ),
              Text(
                DateFormat.yMMMM().format(_currentMonth),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
              IconButton(
                icon: const Icon(Icons.arrow_forward),
                onPressed: () => _changeMonth(1), // Go to next month
              ),
            ],
          ),
          const SizedBox(height: SchoolSizes.md),
          // Days of the week labels
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text("Sun"),
              Text("Mon"),
              Text("Tue"),
              Text("Wed"),
              Text("Thu"),
              Text("Fri"),
              Text("Sat"),
            ],
          ),
          const SizedBox(height: SchoolSizes.md),
          // Calendar Grid
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, // 7 days in a week
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            itemCount: daysInMonth + firstDayOfMonth.weekday - 1,
            itemBuilder: (context, index) {
              // Handle padding for the first week
              if (index < firstDayOfMonth.weekday - 1) {
                return const SizedBox.shrink();
              }

              // Actual date number
              final int day = index - (firstDayOfMonth.weekday - 2);
              final String dateKey =
                  "$yearMonth-${day.toString().padLeft(2, '0')}";

              // Check attendance status
              bool? isPresent = widget.attendanceRecords[dateKey];

              return Container(
                margin: const EdgeInsets.all(7),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isPresent == true
                      ? SchoolDynamicColors.activeGreen // Present
                      : isPresent == false
                      ? SchoolDynamicColors.activeRed // Absent
                      : Colors.transparent, // No data
                ),
                alignment: Alignment.center,
                child: Text(
                  "$day",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 13,
                    color: isPresent == null
                        ? SchoolDynamicColors.subtitleTextColor
                        : Colors.white,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
