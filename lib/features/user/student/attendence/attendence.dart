import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/features/user/student/attendence/screens/my_attendance.dart';
import 'package:my_school_app/features/user/student/attendence/widgets/attendance_calendar.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../data/repositories/school_class_repository.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../manage_school/models/school_class.dart';
import '../../teacher/attendence/models/student_attendance.dart';

class StudentAttendance0 {
  final String date;
  final bool status;

  StudentAttendance0({required this.date, required this.status});
}

class AttendanceController extends GetxController {
  RxBool isLoadingAttendance = true.obs;


  RxInt absent = 0.obs;
  RxInt present = 0.obs;
  RxInt holidays = 0.obs;
  RxInt working = 0.obs;
  RxInt totalDays = 0.obs;

  final SchoolClassRepository schoolClassRepository = SchoolClassRepository();
  SchoolClass? schoolClass;
  RxList<StudentAttendance0> studentAttendanceList = <StudentAttendance0>[].obs;

  Future<void> fetchStudentAttendance(String classId, String studentId) async {
    try {
      // Fetch the class object
      SchoolClass? schoolClass =
          await schoolClassRepository.getSchoolClass(classId);

      if (schoolClass == null) {
        print('Error: schoolClass is null');
        studentAttendanceList
            .clear(); // Clear the list in case of null response
        return;
      }

      // Extract attendance for the specific student and map to StudentAttendance0
      var attendanceList = schoolClass.attendanceByDate.entries
          .where(
              (entry) => entry.value.attendanceRecords.containsKey(studentId))
          .map((entry) {
        // Format date to a readable string (e.g., '2024-11-16')
        String formattedDate =
            DateFormat('yyyy-MM-dd').format(entry.value.date);
        bool status = entry.value.attendanceRecords[studentId]! ? true : false;

        return StudentAttendance0(date: formattedDate, status: status);
      }).toList();

      // Update the reactive list
      studentAttendanceList.assignAll(attendanceList);
    } catch (e) {
      print('Error fetching attendance: $e');
      studentAttendanceList.clear(); // Clear the list in case of an error
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchStudentAttendance('CLA0000000001', 'S1565');
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
                  MyAttendanceCalendar(
                      studentAttendanceList: controller.studentAttendanceList),
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
                          days: controller.working.value,
                          total: controller.working.value,
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
                          days: controller.present.value,
                          total: controller.working.value,
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
                          days: controller.absent.value,
                          total: controller.working.value,
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
                              'Total Holidays out of ${controller.totalDays.value} days -  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                      color: SchoolDynamicColors
                                          .headlineTextColor),
                            ),
                            //const SizedBox(width: SchoolSizes.md),
                            Text(
                              '${controller.holidays.value}',
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
                          percent: controller.totalDays > 0
                              ? controller.holidays.value /
                              controller.totalDays.value
                              : 0.0,
                          center: Text(
                            '${controller.totalDays > 0 ? ((controller.holidays.value / controller.totalDays.value) * 100).toStringAsFixed(1) : 0.0}%',
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
