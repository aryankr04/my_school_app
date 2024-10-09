import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_school_app/features/user/student/attendence/widgets/attendance_calendar.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';

class MonthlyAttendance {
  final String date;
  final String status;

  MonthlyAttendance({required this.date, required this.status});
}

class AttendanceController extends GetxController {
  RxList<MonthlyAttendance> monthlyAttendance = <MonthlyAttendance>[].obs;

  RxBool isLoadingAttendance = true.obs;

  Future<List<MonthlyAttendance>> fetchStudentAttendanceForMonth(
      String sectionId, String studentId, int year, int month) async {
    try {
      // Get the first and last dates of the month
      DateTime firstDateOfMonth = DateTime(year, month, 1);
      DateTime lastDateOfMonth =
          DateTime(year, month + 1, 0); // Last day of the month

      // Format first and last dates of the month
      String formattedFirstDate =
          SchoolHelperFunctions.getFormattedDate(firstDateOfMonth);
      String formattedLastDate =
          SchoolHelperFunctions.getFormattedDate(lastDateOfMonth);
      print(formattedLastDate);

      // Create a reference to the collection containing attendance data for the student
      var attendanceCollectionReference = FirebaseFirestore.instance
          .collection('attendance')
          .doc(sectionId)
          .collection('students')
          .doc(studentId)
          .collection('dates');

      // Query for documents within the specified date range
      var querySnapshot = await attendanceCollectionReference
          .where(FieldPath.documentId,
              isGreaterThanOrEqualTo: formattedFirstDate)
          .where(FieldPath.documentId, isLessThanOrEqualTo: formattedLastDate)
          .get();

      // List to store the fetched attendance data
      List<MonthlyAttendance> monthlyAttendance = [];

      // Iterate through the query snapshot
      querySnapshot.docs.forEach((document) {
        String formattedDate = document.id;
        bool isPresent = document.data()['present'];
        String status = isPresent ? 'Present' : 'Absent';

        monthlyAttendance
            .add(MonthlyAttendance(date: formattedDate, status: status));
      });

      monthlyAttendance.sort((a, b) => a.date.compareTo(b.date));

      // Return the fetched attendance data
      return monthlyAttendance;
    } catch (e) {
      print(
          'Error fetching student attendance for $studentId for the month of $year-$month: $e');
      // Handle the error as needed
      return [];
    }
  }
}

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  final AttendanceController controller = Get.put(AttendanceController());
  final AttendanceCalendarController attendanceCalendarController =
      Get.put(AttendanceCalendarController());

  void fetchMonthlyAttendanceData() async {
    // Assuming you have the sectionId, studentId, year, and month values available
    controller.isLoadingAttendance(true);
    List<MonthlyAttendance> attendanceList =
        await controller.fetchStudentAttendanceForMonth(
            'SEC0000000004', 'STU0000000001', 2024, 3);
    controller.monthlyAttendance.assignAll(attendanceList);
    controller.isLoadingAttendance(false);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMonthlyAttendanceData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
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
                  AttendanceCalendar(
                    monthlyAttendance: controller.monthlyAttendance,
                  ),
                  const SizedBox(
                    height: SchoolSizes.lg,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Attendance Status',
                        style: Theme.of(context).textTheme.headlineSmall,
                      )),
                  const SizedBox(height: SchoolSizes.md),
                  Container(
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
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                      border: Border.all(
                          width: 0.5, color: SchoolDynamicColors.borderColor),
                    ),
                    padding: const EdgeInsets.all(SchoolSizes.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AttendanceStatus(
                          color: SchoolDynamicColors.activeBlue,
                          title: 'Working ',
                          days: attendanceCalendarController.working.value,
                          total: attendanceCalendarController.working.value,
                        ),
                        Container(
                          width: 2,
                          height: 100,
                          color:
                              SchoolDynamicColors.borderColor.withOpacity(0.5),
                        ),
                        AttendanceStatus(
                          color: SchoolDynamicColors.activeGreen,
                          title: 'Present ',
                          days: attendanceCalendarController.present.value,
                          total: attendanceCalendarController.working.value,
                        ),
                        Container(
                          width: 2,
                          height: 100,
                          color:
                              SchoolDynamicColors.borderColor.withOpacity(0.5),
                        ),
                        AttendanceStatus(
                          color: SchoolDynamicColors.activeRed,
                          title: 'Absent ',
                          days: attendanceCalendarController.absent.value,
                          total: attendanceCalendarController.working.value,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: SchoolSizes.lg),
                  Container(
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
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusSm),
                      border: Border.all(
                          width: 0.5, color: SchoolDynamicColors.borderColor),
                    ),
                    padding: const EdgeInsets.all(SchoolSizes.md),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                                backgroundColor:
                                    SchoolDynamicColors.activeOrange,
                                radius: 4),
                            const SizedBox(width: SchoolSizes.sm),
                            Text(
                              'Total Holidays out of ${attendanceCalendarController.totalDays.value} days -  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: SchoolDynamicColors
                                          .headlineTextColor),
                            ),
                            //const SizedBox(width: SchoolSizes.md),
                            Text(
                              '${attendanceCalendarController.holidays.value}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: SchoolDynamicColors.activeOrange,
                                      fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        CircularPercentIndicator(
                          radius: 38,
                          progressColor: SchoolDynamicColors.activeOrange,
                          backgroundColor:
                              SchoolDynamicColors.activeOrange.withOpacity(0.1),
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          lineWidth: 6,
                          percent: attendanceCalendarController.totalDays > 0
                              ? attendanceCalendarController.holidays.value /
                                  attendanceCalendarController.totalDays.value
                              : 0.0,
                          center: Text(
                            '${attendanceCalendarController.totalDays > 0 ? ((attendanceCalendarController.holidays.value / attendanceCalendarController.totalDays.value) * 100).toStringAsFixed(1) : 0.0}%',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: SchoolDynamicColors
                                  .headlineTextColor, // Adjust the color as needed
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
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
