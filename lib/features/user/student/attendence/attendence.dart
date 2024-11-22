import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/features/user/student/attendence/screens/my_attendance.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../data/repositories/school_class_repository.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../manage_school/models/school_class.dart';

class StudentAttendance0 {
  final String date;
  final String status; // Changed from bool? to String?

  StudentAttendance0({required this.date, required this.status});
}

class AttendanceController extends GetxController {
  RxBool isLoadingAttendance = true.obs;

  RxInt absentCount = 0.obs;
  RxInt presentCount = 0.obs;
  RxInt holidayCount = 0.obs;
  RxInt totalDays = 0.obs;
  RxInt totalWorkingDays = 0.obs;

  List<String> options = ['Present', 'Absent', 'Holiday'];
  RxBool isPresentSelected = true.obs;
  RxBool isAbsentSelected = false.obs;
  RxBool isHolidaySelected = false.obs;

  String studentId = 'S1565';
  String schoolId = 'SCH0000000001';
  String classId = 'CLA0000000001';
  Map<String, Map<String, int>> monthlyAttendance = {};

  final SchoolClassRepository schoolClassRepository = SchoolClassRepository();
  SchoolClass? schoolClass;
  RxList<StudentAttendance0> studentAttendanceList = <StudentAttendance0>[].obs;

  String currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
  Map<String, double> studentAttendancePercentages = {}; // Stores attendance percentages for students
  Map<String, int> studentRanks = {};  // Stores student ranks
  Set<String> holidayDates = {};  // Set of holiday dates for quick lookup
  int totalPresent = 0;
  int totalAbsent = 0;
  int totalHoliday = 0;
  int totalAttendanceDays = 0;

  // The fetchStudentAttendance function
  Future<void> fetchStudentAttendance(String classId, String studentId) async {
    try {
      // Fetch the class object
      SchoolClass? schoolClass = await schoolClassRepository.getSchoolClass(classId);

      if (schoolClass == null) {
        print('Error: schoolClass is null');
        studentAttendanceList.clear(); // Clear the list in case of null response
        return;
      }

      // Step 1: Collect all holiday dates (as strings) and add them to a Set for quick lookup
      holidayDates.clear(); // Clear the set to avoid duplicate holidays
      for (var holiday in schoolClass.holidays) {
        DateTime holidayStart = DateTime.parse(holiday.startDate);
        DateTime holidayEnd = DateTime.parse(holiday.endDate);

        // Add all dates in the range as holiday dates
        for (DateTime date = holidayStart; !date.isAfter(holidayEnd); date = date.add(const Duration(days: 1))) {
          holidayDates.add(DateFormat('yyyy-MM-dd').format(date));
        }
      }

      // Step 2: Process attendance data in a single loop to improve performance
      totalPresent = 0;
      totalAbsent = 0;
      totalHoliday = 0;
      totalAttendanceDays = 0;

      studentAttendanceList.clear(); // Clear the list before repopulating it

      // Process attendance records for each date
      for (var entry in schoolClass.attendanceByDate.entries) {
        DateTime date = entry.value.date;
        String formattedDate = DateFormat('yyyy-MM-dd').format(date);

        // Only process records for the current year
        if (date.year == DateTime.now().year) {
          totalAttendanceDays++; // Count the attendance record for the year

          // Check if the student is present, absent, or on holiday
          String status = holidayDates.contains(formattedDate)
              ? 'Holiday'
              : (entry.value.attendanceRecords[studentId] ?? false ? 'Present' : 'Absent');

          // Update attendance count
          if (status == 'Present') {
            totalPresent++;
          } else if (status == 'Absent') {
            totalAbsent++;
          } else {
            totalHoliday++;
          }

          // Record attendance status for the student
          studentAttendanceList.add(StudentAttendance0(date: formattedDate, status: status));
        }
      }

      // Step 3: Calculate the average attendance for the current student
      double averagePresent = totalAttendanceDays > 0 ? (totalPresent / totalAttendanceDays) * 100 : 0.0;

      // Step 4: Calculate and rank the students based on their attendance percentages
      studentAttendancePercentages.clear();  // Clear the map before re-calculating

      for (var student in schoolClass.students) {
        int studentTotalPresent = 0;
        int studentTotalDays = 0;

        // Loop through attendance records for the student to calculate their attendance percentage
        for (var entry in schoolClass.attendanceByDate.entries) {
          // Check if the student has an entry in attendanceRecords
          if (entry.value.attendanceRecords.containsKey(student.id)) {
            studentTotalDays++;

            // Use the boolean value directly to check if the student is present or absent
            bool isPresent = entry.value.attendanceRecords[student.id] ?? false;

            if (isPresent) {
              studentTotalPresent++;
            }
          }
        }

        // After calculating totalPresent and totalDays, calculate the percentage
        if (studentTotalDays > 0) {
          double attendancePercentage = (studentTotalPresent / studentTotalDays) * 100;
          studentAttendancePercentages[student.id] = attendancePercentage;
        }
      }

      // Step 5: Sort students by attendance percentage (descending order) and assign ranks
      var sortedStudents = studentAttendancePercentages.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      int rank = 1;
      studentRanks.clear();  // Clear the map before assigning new ranks
      for (var student in sortedStudents) {
        studentRanks[student.key] = rank++;
      }

      // Step 6: Display the rank of the current student
      print('Student $studentId Rank: ${studentRanks[studentId]}');

      // Optionally, print the class ranking
      print('Class Attendance Ranking:');
      for (var student in sortedStudents) {
        print('Student ID: ${student.key}, Attendance Percentage: ${student.value.toStringAsFixed(2)}%, Rank: ${studentRanks[student.key]}');
      }

      // Optionally, store or display the results as needed
      countAttendanceStatuses(studentAttendanceList);
    } catch (e) {
      print('Error fetching attendance: $e');
      studentAttendanceList.clear(); // Clear the list in case of an error
    }
  }

  void printAllHolidays(SchoolClass schoolClass) {
    // Check if the schoolClass has holidays
    if (schoolClass.holidays.isEmpty) {
      print("No holidays available.");
      return;
    }

    // Iterate through all holidays and print details
    for (var holiday in schoolClass.holidays) {
      // Convert startDate and endDate from String to DateTime for proper formatting
      DateTime startDate = DateTime.parse(holiday.startDate);
      DateTime endDate = DateTime.parse(holiday.endDate);

      // Print holiday details
      print("Holiday: ${holiday.reason}");
      print("Start Date: ${DateFormat('yyyy-MM-dd').format(startDate)}");
      print("End Date: ${DateFormat('yyyy-MM-dd').format(endDate)}");
      print("--------------------------------");
    }
  }

  // Future<void> fetchStudentAttendance(String classId, String studentId) async {
  //   try {
  //     // Fetch the class object
  //     SchoolClass? schoolClass =
  //         await schoolClassRepository.getSchoolClass(classId);
  //
  //     if (schoolClass == null) {
  //       print('Error: schoolClass is null');
  //       studentAttendanceList
  //           .clear(); // Clear the list in case of null response
  //       return;
  //     }
  //
  //     // Step 1: Collect all holiday dates (as strings) and add them to the list
  //     List<String> holidayDates = [];
  //     for (var holiday in schoolClass.holidays) {
  //       DateTime holidayStart = DateTime.parse(holiday.startDate);
  //       DateTime holidayEnd = DateTime.parse(holiday.endDate);
  //
  //       // Add all dates in the range as holiday dates
  //       for (DateTime date = holidayStart;
  //           date.isBefore(holidayEnd.add(const Duration(days: 1)));
  //           date = date.add(const Duration(days: 1))) {
  //         String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  //         holidayDates.add(formattedDate);
  //       }
  //     }
  //
  //     // Step 2: Collect all attendance records from attendanceByDate
  //     var attendanceList = schoolClass.attendanceByDate.entries
  //         .where(
  //             (entry) => entry.value.attendanceRecords.containsKey(studentId))
  //         .map((entry) {
  //       // Format date to a readable string (e.g., '2024-11-16')
  //       String formattedDate =
  //           DateFormat('yyyy-MM-dd').format(entry.value.date);
  //
  //       // Initially set the status based on the attendance record
  //       String status =
  //           entry.value.attendanceRecords[studentId]! ? 'Present' : 'Absent';
  //
  //       // If the date is a holiday, set the status to 'Holiday'
  //       if (holidayDates.contains(formattedDate)) {
  //         status = 'Holiday';
  //       }
  //       print('${formattedDate} - ${status}');
  //
  //       return StudentAttendance0(date: formattedDate, status: status);
  //     }).toList();
  //
  //     // Step 3: Add all holidays to the attendance list with status 'Holiday'
  //     for (var holidayDate in holidayDates) {
  //       // Check if the holiday date is already in attendance list, if not add it with 'Holiday' status
  //       if (!attendanceList
  //           .any((attendance) => attendance.date == holidayDate)) {
  //         attendanceList
  //             .add(StudentAttendance0(date: holidayDate, status: 'Holiday'));
  //       }
  //     }
  //     // Step 4: Update the reactive list with the final attendance list
  //     studentAttendanceList.assignAll(attendanceList);
  //     countAttendanceStatuses(attendanceList);
  //   } catch (e) {
  //     print('Error fetching attendance: $e');
  //     studentAttendanceList.clear(); // Clear the list in case of an error
  //   }
  // }


  Map<String, RxInt> countAttendanceStatuses(
      List<StudentAttendance0> attendanceList) {
    // Iterate through the attendance list and count statuses for the current month
    for (var attendance in attendanceList) {
      // Check if the attendance date is in the current month (compare 'yyyy-MM' format)
      String currentMonth = DateFormat('yyyy-MM').format(DateTime.now());
      String attendanceMonth =
          DateFormat('yyyy-MM').format(DateTime.parse(attendance.date));

// print(attendanceMonth);
      // Only process records for the current month
      if (attendanceMonth == currentMonth) {
        // Increment the appropriate count based on the status
        switch (attendance.status) {
          case 'Present':
            presentCount.value++;
            break;
          case 'Absent':
            absentCount.value++;
            break;
          case 'Holiday':
            holidayCount.value++;
            break;
        }
      }
    }
    totalWorkingDays.value = absentCount.value + presentCount.value;
    // Parse the provided attendanceMonth string to a DateTime object

    DateTime firstDayOfMonth = DateTime.parse('$currentMonth-01');

    // Find the last day of the month (by adding one month and subtracting one day)
    totalDays.value =
        DateTime(firstDayOfMonth.year, firstDayOfMonth.month + 1, 0).day;

    // Return the counts in a map
    return {
      'Present': presentCount,
      'Absent': absentCount,
      'Holiday': holidayCount,
    };
  }
}

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance>
    with SingleTickerProviderStateMixin {
  final AttendanceController controller = Get.put(AttendanceController());

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize the AnimationController with a duration.
    controller.fetchStudentAttendance('CLA0000000001', 'S1565');
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Create an animation with a linear tween.
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);

    // Start the animation.
    _controller.forward();
  }

  final List<int> attendance = [
    22,
    20,
    15,
    25,
    27,
    28,
    26,
    24,
    23,
    25,
    29,
    28
  ]; // Each index represents a month.
  RxString selectedMonthlyReportOption = 'Present'.obs;
  RxList<String> monthlyReportOptions = <String>[].obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Obx(() => Column(
                children: [
                  TextButton(
                      onPressed: () async {
                        controller.fetchStudentAttendance(
                            controller.classId, controller.studentId);
                      },
                      child: const Text('Fetch')),
                  MyAttendanceCalendar(
                    studentAttendanceList: controller.studentAttendanceList,
                    onMonthChanged: (currentMonth) {
                      controller.currentMonth = currentMonth.toString();
                    },
                  ),
                  const SizedBox(
                    height: SchoolSizes.lg,
                  ),

                  Container(
                    padding: const EdgeInsets.all(SchoolSizes.md),
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
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                      border: Border.all(
                          width: .5, color: SchoolDynamicColors.borderColor),
                    ),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'November Attendance ',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            )),
                        const SizedBox(height: SchoolSizes.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            attendanceCardWithIndicator(
                                name: 'Present',
                                value: controller.presentCount.value,
                                total: controller.totalWorkingDays.value,
                                color: SchoolDynamicColors.activeGreen),
                            attendanceCardWithIndicator(
                                name: 'Absent',
                                value: controller.absentCount.value,
                                total: controller.totalWorkingDays.value,
                                color: SchoolDynamicColors.activeRed),
                            attendanceCardWithIndicator(
                                name: 'Holidays',
                                value: controller.holidayCount.value,
                                total: controller.totalDays.value,
                                color: SchoolDynamicColors.activeOrange),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SchoolSizes.lg,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: SchoolSizes.md),
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
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                      border: Border.all(
                          width: .5, color: SchoolDynamicColors.borderColor),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: SchoolSizes.md),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        'Monthly Report',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blueAccent,
                                        ),
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: SchoolSizes.sm,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween, // Aligns items to the start (left) of the row
                                crossAxisAlignment: CrossAxisAlignment
                                    .center, // Aligns items vertically in the center
                                children: [
                                  {
                                    'label': 'Present',
                                    'selected': controller.isPresentSelected,
                                  },
                                  {
                                    'label': 'Absent',
                                    'selected': controller.isAbsentSelected,
                                  },
                                  {
                                    'label': 'Holiday',
                                    'selected': controller.isHolidaySelected,
                                  },
                                ].map((option) {
                                  RxBool isSelected =
                                      option['selected'] as RxBool;
                                  String label = option['label'] as String;

                                  return Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        // Toggle the selection state
                                        isSelected.value = !isSelected.value;
                                      },
                                      child: Obx(
                                        () => Container(
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: SchoolSizes.sm),
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: SchoolSizes.sm,
                                            horizontal: SchoolSizes.sm + 8,
                                          ),
                                          decoration: BoxDecoration(
                                            color: isSelected.value
                                                ? SchoolDynamicColors.activeBlue
                                                    .withOpacity(
                                                        0.1) // Highlight selected
                                                : SchoolDynamicColors
                                                    .backgroundColorGreyLightGrey,
                                            borderRadius: BorderRadius.circular(
                                                SchoolSizes.lg),
                                            border: Border.all(
                                              color: isSelected.value
                                                  ? SchoolDynamicColors
                                                      .primaryColor
                                                  : Colors.transparent,
                                              width:
                                                  isSelected.value ? 0.75 : 0,
                                            ),
                                          ),
                                          child: Text(
                                            label,
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: isSelected.value
                                                  ? SchoolColors.activeBlue
                                                  : SchoolDynamicColors
                                                      .subtitleTextColor,
                                              fontWeight: isSelected.value
                                                  ? FontWeight.w500
                                                  : FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: SchoolSizes.lg + 8,
                        ),
                        Container(
                          height: Get.width * 0.5,
                          child: AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              // Extract month names (e.g., "Jan" from "Jan 2024")
                              List<String> monthNames = controller
                                  .monthlyAttendance.keys
                                  .map((monthKey) {
                                return monthKey.split(
                                    ' ')[0]; // Get month name (e.g., "Jan")
                              }).toList();

                              // Generate bar data based on `monthlyAttendance`
                              List<BarChartGroupData> barGroups = List.generate(
                                monthNames.length,
                                (index) {
                                  String monthKey = controller
                                      .monthlyAttendance.keys
                                      .toList()[index];
                                  Map<String, int> attendanceData =
                                      controller.monthlyAttendance[monthKey]!;

                                  double presentValue =
                                      attendanceData['Present']?.toDouble() ??
                                          0;
                                  double absentValue =
                                      attendanceData['Absent']?.toDouble() ?? 0;
                                  double holidayValue =
                                      attendanceData['Holiday']?.toDouble() ??
                                          0;

                                  List<BarChartRodData> barRods = [];
// Calculate width based on selected flags
                                  double rodWidth = (controller
                                              .isPresentSelected.value &&
                                          controller.isAbsentSelected.value &&
                                          controller.isHolidaySelected.value)
                                      ? 4
                                      : 8;
                                  // Conditionally add bar rods based on the booleans
                                  if (controller.isPresentSelected.value) {
                                    barRods.add(
                                      BarChartRodData(
                                        toY: presentValue * _animation.value,
                                        width: rodWidth,
                                        borderRadius: BorderRadius.circular(24),
                                        color: SchoolColors.activeGreen,
                                      ),
                                    );
                                  }

                                  if (controller.isAbsentSelected.value) {
                                    barRods.add(
                                      BarChartRodData(
                                        toY: absentValue * _animation.value,
                                        width: rodWidth,
                                        borderRadius: BorderRadius.circular(24),
                                        color: SchoolColors.activeRed,
                                      ),
                                    );
                                  }

                                  if (controller.isHolidaySelected.value) {
                                    barRods.add(
                                      BarChartRodData(
                                        toY: holidayValue * _animation.value,
                                        width: rodWidth,
                                        borderRadius: BorderRadius.circular(24),
                                        color: SchoolColors.activeOrange,
                                      ),
                                    );
                                  }

                                  return BarChartGroupData(
                                    x: index,
                                    barsSpace: 4,
                                    showingTooltipIndicators:
                                        List.generate(barRods.length, (i) => i),
                                    barRods: barRods,
                                  );
                                },
                              );

                              return BarChart(
                                BarChartData(
                                  maxY:
                                      31, // Maximum Y value (31 days in a month)
                                  barGroups: barGroups,
                                  titlesData: FlTitlesData(
                                    leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles:
                                              false), // Hide left titles
                                    ),
                                    rightTitles: const AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles:
                                              false), // Hide right titles
                                    ),
                                    topTitles: const AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: false), // Hide top titles
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true, // Show bottom titles
                                        getTitlesWidget: (value, _) {
                                          if (value < 0 ||
                                              value >= monthNames.length) {
                                            return const SizedBox();
                                          }
                                          return Text(
                                            monthNames[value.toInt()],
                                            style: const TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  SchoolColors.captionTextColor,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  gridData: const FlGridData(
                                      show: false), // No gridlines
                                  borderData:
                                      FlBorderData(show: false), // No border
                                  barTouchData: BarTouchData(
                                    enabled: false,
                                    touchTooltipData: BarTouchTooltipData(
                                      tooltipPadding: const EdgeInsets.all(0),
                                      getTooltipColor:
                                          (BarChartGroupData group) {
                                        return Colors
                                            .transparent; // Transparent background
                                      },
                                      tooltipMargin: 0,
                                      getTooltipItem:
                                          (group, groupIndex, rod, rodIndex) {
                                        return BarTooltipItem(
                                          '${rod.toY.toInt()}', // Display bar value
                                          const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        );
                                      },
                                    ),
                                    handleBuiltInTouches: true,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SchoolSizes.lg,
                  ),
                  Container(
                    padding: const EdgeInsets.all(SchoolSizes.md),
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
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                      border: Border.all(
                          width: .5, color: SchoolDynamicColors.borderColor),
                    ),
                    child: Column(
                      children: [
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Yearly Report',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                              ),
                            )),
                        const SizedBox(
                          height: SchoolSizes.md,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            attendanceCardWithIndicator(
                                name: 'Present',
                                value: controller.presentCount.value,
                                total: controller.totalWorkingDays.value,
                                color: SchoolDynamicColors.activeGreen),
                            attendanceCardWithIndicator(
                                name: 'Absent',
                                value: controller.absentCount.value,
                                total: controller.totalWorkingDays.value,
                                color: SchoolDynamicColors.activeRed),
                            attendanceCardWithIndicator(
                                name: 'Holidays',
                                value: controller.holidayCount.value,
                                total: controller.totalDays.value,
                                color: SchoolDynamicColors.activeOrange),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SchoolSizes.lg,
                  ),
                  // Section 1: Student Average vs Class Average
                  Container(
                    padding: const EdgeInsets.all(SchoolSizes.md),
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
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                      border: Border.all(
                          width: .5, color: SchoolDynamicColors.borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section 1: Average vs Class Average
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Your Average vs Class Average",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        const SizedBox(height: SchoolSizes.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildAverageBox(
                                "Your Average", studentAverage, Colors.green),
                            const SizedBox(
                              width: SchoolSizes.md,
                            ),
                            _buildAverageBox(
                                "Class Average", classAverage, Colors.blue),
                          ],
                        ),
                        const SizedBox(height: 20),

                        Row(
                          children: [
                            Icon(
                              performanceDifference >= 0
                                  ? Icons.trending_up
                                  : Icons.trending_down,
                              color: performanceDifference >= 0
                                  ? Colors.green
                                  : Colors
                                      .red, // Green for positive, Red for negative
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Difference: ${performanceDifference >= 0 ? '+$performanceDifference%' : performanceDifference} vs Class",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: performanceDifference >= 0
                                    ? Colors.green
                                    : Colors.red, // Color matching the icon
                                fontStyle: FontStyle
                                    .italic, // Added italics for emphasis
                              ),
                            ),
                          ],
                        ),

                        // Progress Bar (if needed for visualization)
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: SchoolSizes.lg,
                  ),
                  Container(
                    padding: const EdgeInsets.all(SchoolSizes.md),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.white.withOpacity(0.8),
                          Colors.grey[100]!
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                      border: Border.all(
                          width: 0.5, color: SchoolDynamicColors.borderColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Section 2: Rank Header
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Rank Overview",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        const SizedBox(height: SchoolSizes.md),

                        // Row for student and top ranks with icons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildRankBox("Your Rank", studentRank, 78,
                                Colors.orangeAccent),
                            _buildRankBox(
                                "Top Rank", topRank, 85, Colors.blueAccent),
                          ],
                        ),
                        const SizedBox(height: 20),

                        // Rank Breakdown with progress bars
                        const Text(
                          "Rank Breakdown",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 10),
                        _buildRankDistributionChart(),
                      ],
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }

  // Rank Box with Custom Icon and Shadow Effects

  Widget _buildRankBox(String label, int rank, double percentage, Color color) {
    return Container(
      padding:
          const EdgeInsets.symmetric(horizontal: SchoolSizes.sm + 4, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Rank Icon
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            child: Icon(
              rank == 1
                  ? Icons.emoji_events
                  : rank == 2
                      ? Icons.emoji_events_outlined
                      : Icons.star_border,
              key: ValueKey<int>(rank),
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: SchoolSizes.sm),

          // Rank and Percentage Information
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$label: $rank${rank == 1 ? 'st' : rank == 2 ? 'nd' : rank == 3 ? 'rd' : 'th'}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              Row(
                children: [

                  Text(
                    "${percentage.toStringAsFixed(1)}%",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRankDistributionChart() {
    return Column(
      children: [
        _buildRankDistributionRow(
          "Aryan Kumar",
          '123',
          '1',
          '92.5',
          Colors.green,
        ),
        _buildRankDistributionRow(
          "Asad Alam",
          '123',
          '2',
          '87.3',
          Colors.blue,
        ),
        _buildRankDistributionRow(
            "Rohit Kumar", '123', '3', '98.4', Colors.orange),
      ],
    );
  }

  Widget _buildRankDistributionRow(
    String name,
    String id,
    String rank,
    String percentage,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0), // Improved padding for vertical spacing
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Profile Icon with Circle and Background Color
          Container(
              padding: const EdgeInsets.all(8 + 4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.2), // Light background for icon
              ),
              child: Text(
                rank == '1'
                    ? "1st"
                    : rank == '2'
                        ? "2nd"
                        : rank == '3'
                            ? "3rd"
                            : rank, // Handle other ranks
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.copyWith(color: color),
              )),
          const SizedBox(
              width:
                  12), // Increased width for better spacing between the icon and text

          // Text Column with name and ID
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 14, // Increased font size for better readability
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                // SizedBox(height: 4), // Spacing between name and ID
                Text(
                  id,
                  style: Theme.of(context).textTheme.labelMedium,
                ),
              ],
            ),
          ),

          // Progress Percentage Display (assuming static 78.3% for now)
          const SizedBox(width: 12),
          Text(
            '${percentage}%',
            style: const TextStyle(
              fontSize: 14, // Font size for percentage
              fontWeight: FontWeight.w600,
              color: SchoolColors
                  .subtitleTextColor, // Use the passed color for the percentage text
            ),
          ),
        ],
      ),
    );
  }

  final double studentAverage = 85.0;
  final double classAverage = 78.0;
  final int studentRank = 4;
  final int topRank = 1;
  final double performanceDifference = 7;

  // Helper function to build average boxes
  Widget _buildAverageBox(String label, double value, Color color) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color, width: 1),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  "$value%",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(
              height: SchoolSizes.md -
                  4), // Add space between the text container and progress bar
          LinearProgressIndicator(
            value: value / 100, // Use the parameter value
            minHeight: SchoolSizes.sm - 2,
            backgroundColor: color.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(
                color), // Use the same color for the progress bar
            borderRadius: const BorderRadius.all(Radius.circular(SchoolSizes.md)),
          ),
        ],
      ),
    );
  }
}

Widget attendanceCardWithIndicator({
  required String name,
  required int value,
  required int total,
  required Color color,
}) {
  double percentage = total > 0 ? (value / total).clamp(0.0, 1.0) : 0.0;

  return Container(
    padding: const EdgeInsets.symmetric(
        vertical: SchoolSizes.sm + 2, horizontal: SchoolSizes.md - 2),
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
        const SizedBox(height: SchoolSizes.sm),
        Text(
          '$value/$total',
          style: const TextStyle(
              height: 1,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: SchoolColors.headlineTextColor),
        ),
        // SizedBox(height: SchoolSizes.sm - 6),
        Text(
          name,
          style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: SchoolColors.subtitleTextColor),
        ),
      ],
    ),
  );
}

class AttendanceStatus extends StatelessWidget {
  final Color color;
  final String title;
  final int days;
  final int total;

  const AttendanceStatus({
    Key? key,
    required this.color,
    required this.title,
    required this.days,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double attendanceValue = total > 0 ? days / total : 0.0;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularPercentIndicator(
          radius: 38,
          animateFromLastPercent: true,
          progressColor: color,
          backgroundColor: color.withOpacity(0.1),
          animation: true,
          circularStrokeCap: CircularStrokeCap.round,
          lineWidth: 6,
          percent: attendanceValue,
          center: Text(
            '${(attendanceValue * 100).toStringAsFixed(1)}%',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: SchoolDynamicColors
                  .headlineTextColor, // Adjust the color as needed
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(backgroundColor: color, radius: 4),
            const SizedBox(width: SchoolSizes.sm),
            Text(
              '$title ',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
            ),
            const SizedBox(width: 0),
            Text(
              days.toString(),
              style:
                  Theme.of(context).textTheme.bodyLarge?.copyWith(color: color),
            ),
          ],
        ),
      ],
    );
  }
}
