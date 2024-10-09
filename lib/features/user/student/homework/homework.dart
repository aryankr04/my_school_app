import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

class HomeworkController extends GetxController {
  final Rx<List<Map<String, dynamic>>> _homeworkStream =
      Rx<List<Map<String, dynamic>>>([]);

  Stream<List<Map<String, dynamic>>> get homeworkStream =>
      _homeworkStream.stream;

  RxString selectedDate = ''.obs;
  //RxBool isLoading=true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeworkStream(DateTime.now());
    // Future.delayed(const Duration(seconds: 2), () {
    //   isLoading(false);
    // });
  }

  Future<void> fetchHomeworkStream(DateTime selectedDate) async {
    final String date = DateFormat('dd MMM yyyy').format(selectedDate);
    FirebaseFirestore.instance
        .collection('homework')
        .where('schoolId', isEqualTo: 'SCH0000000001')
        .where('className', isEqualTo: '6')
        .where('sectionName', isEqualTo: 'G')
        .where('timestamp', isEqualTo: date)
        .snapshots()
        .listen((querySnapshot) {
      _homeworkStream.value =
          querySnapshot.docs.map((doc) => doc.data()).toList();
    });
  }
}

class Homework extends StatefulWidget {
  const Homework({super.key});

  @override
  State<Homework> createState() => _HomeworkState();
}

class _HomeworkState extends State<Homework> {
  final HomeworkController homeworkController = Get.put(HomeworkController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeworkController.fetchHomeworkStream(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Homework'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: SchoolSizes.lg,
            ),
            WeekCalendar(
              onDateChange: (selectedDate) {
                homeworkController.fetchHomeworkStream(selectedDate);
                homeworkController.selectedDate.value =
                    DateFormat('dd MMM yyyy').format(selectedDate);
                ;
              },
            ),
            const SizedBox(
              height: SchoolSizes.spaceBtwSections,
            ),
            StreamBuilder<List<Map<String, dynamic>>>(
              stream: homeworkController.homeworkStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                final List<Map<String, dynamic>> homeworkData =
                    snapshot.data ?? [];
                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: SchoolSizes.lg),
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
                    border:
                        Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
                    borderRadius:
                        BorderRadius.circular(SchoolSizes.cardRadiusSm),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Homework",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(color: SchoolDynamicColors.activeBlue)),
                      Text(
                          homeworkController.selectedDate.value ==
                                  DateFormat('dd MMM yyyy')
                                      .format(DateTime.now())
                              ? "Today's Homework"
                              : 'Date: ${homeworkController.selectedDate.value}',
                          style: Theme.of(context).textTheme.bodyLarge),
                      if (homeworkData.isNotEmpty)
                        Column(
                          children: homeworkData.map((homework) {
                            return HomeworkCard(
                              subject: homework['subject'] ?? '',
                              homework: homework['homeworkText'] ?? '',
                              assignBy: homework['teacherId'] ?? '',
                            );
                          }).toList(),
                        )
                      else
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 24),
                            child:
                                Center(child: Text('No homework for today'))),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class HomeworkCard extends StatelessWidget {
  String subject;
  String homework;
  String assignBy;

  HomeworkCard({
    Key? key,
    required this.subject,
    required this.homework,
    required this.assignBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.all(SchoolSizes.sm),
      decoration: BoxDecoration(
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
      ),
      child: Column(
        children: [
          SizedBox(
            height: SchoolSizes.sm,
          ),
          Divider(
            thickness: 0.2,
            color: Colors.grey,
          ),
          SizedBox(
            height: SchoolSizes.sm,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                alignment: Alignment.center,
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.backgroundColorTintLightGrey,
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
                ),
                child: Icon(
                  Icons.abc,
                  color: SchoolDynamicColors.primaryIconColor,
                  size: 36,
                ),
              ),
              const SizedBox(width: SchoolSizes.spaceBtwItems),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      homework,
                      style: Theme.of(context).textTheme.titleMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      subject,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),

                    // const SizedBox(
                    //   height: 4,
                    // ),
                    Row(
                      children: [
                        const Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '$assignBy ',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.copyWith(
                                  color: SchoolDynamicColors.subtitleTextColor,
                                  fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class WeekCalendar extends StatelessWidget {
  const WeekCalendar({
    Key? key,
    required this.onDateChange,
  }) : super(key: key);

  final Function(DateTime) onDateChange;

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        onDateChange(selectedDate); // Pass the selected date to the callback
      },
      headerProps: EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
        selectedDateStyle: TextStyle(
          color: SchoolDynamicColors.headlineTextColor,
          fontWeight: FontWeight.w500,
          fontSize: 18,
        ),
      ),
      dayProps: EasyDayProps(
        height: 100,
        width: 70,
        dayStructure: DayStructure.dayStrDayNumMonth,
        inactiveDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            border: Border.all(color: SchoolDynamicColors.darkGrey, width: 0.25),
          ),
          dayNumStyle: const TextStyle(
            color: SchoolDynamicColors.darkGrey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        todayStyle: const DayStyle(
          dayNumStyle: TextStyle(
            color: SchoolDynamicColors.darkGrey,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            color: SchoolDynamicColors.backgroundColorPrimaryLightGrey,
          ),
        ),
      ),
    );
  }
}

class HomeworkCards extends StatelessWidget {
  String subject;
  String homework;
  String assignBy;

  HomeworkCards({
    Key? key,
    required this.subject,
    required this.homework,
    required this.assignBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(SchoolSizes.sm),
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
      ),
      child: Column(
        children: [],
      ),
    );
  }
}
