import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';

class HomeworkHistory extends StatefulWidget {
  const HomeworkHistory({Key? key}) : super(key: key);

  @override
  _HomeworkHistoryState createState() => _HomeworkHistoryState();
}

class _HomeworkHistoryState extends State<HomeworkHistory> {
  late Stream<List<Map<String, dynamic>>> homeworkStream;

  @override
  void initState() {
    super.initState();
    homeworkStream = getHomeworkStreamByTeacher('TEA0000000001');
  }

  Stream<List<Map<String, dynamic>>> getHomeworkStreamByTeacher(
      String teacherId) {
    return FirebaseFirestore.instance
        .collection('homework')
        .where('teacherId', isEqualTo: teacherId)
        .snapshots()
        .map((QuerySnapshot querySnapshot) {
      return querySnapshot.docs
          .map((DocumentSnapshot doc) => doc.data() as Map<String, dynamic>)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: homeworkStream,
        builder: (context, AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return _buildShimmerEffect();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No homework data available.');
          } else {
            List<Map<String, dynamic>> data = snapshot.data!;
            data.sort((a, b) => parseDate(b['timestamp']).compareTo(parseDate(a['timestamp'])));
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(SchoolSizes.lg),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Homework History",
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    const SizedBox(height: SchoolSizes.defaultSpace),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        // Extracting data for the current homework entry
                        final classValue = data[index]['className'] ?? '';
                        final sectionValue = data[index]['sectionName'] ?? '';
                        final timestampValue = data[index]['timestamp'] ?? '';
                        final homeworkTextValue = data[index]['homeworkText'] ?? '';
                        final subjectValue = data[index]['subject'] ?? '';

                        // Checking if the date changes between consecutive entries
                        final bool isDateChange = index == 0 ||
                            data[index - 1]['timestamp'] != timestampValue;

                        // If date changes, add a divider
                        final Widget divider = isDateChange
                            ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            timestampValue, // Assuming timestamp is a date
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: SchoolDynamicColors.placeholderColor, // Customize as needed
                            ),
                          ),
                        )
                            : SizedBox(); // Otherwise, don't add a divider

                        // Building the container for the homework entry
                        final Widget homeworkEntryContainer = Container(
                          margin: EdgeInsets.only(bottom: SchoolSizes.lg),
                          child: homeworkHistory(
                            classValue,
                            sectionValue,
                            timestampValue,
                            homeworkTextValue,
                            subjectValue,
                          ),
                        );

                        // Returning a Column with divider and homework entry
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            divider,
                            homeworkEntryContainer,
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }

  DateTime parseDate(String dateString) {
    return DateFormat('dd MMM yyyy').parse(dateString);
  }

  Widget _buildShimmerEffect() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          5, // Number of shimmering items
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: SchoolSizes.md, horizontal: SchoolSizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
                color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
              ),
              height: 100,
            ),
          ),
        ),
      ),
    );
  }

  Widget homeworkHistory(String className, String sectionName, String date,
      String homework, String subject) {
    return Container(
      padding: EdgeInsets.symmetric(
          vertical: SchoolSizes.md, horizontal: SchoolSizes.md),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
          color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
          border: Border.all(color: SchoolDynamicColors.borderColor, width: 0.5),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: SchoolDynamicColors.activeGreen.withOpacity(0.1),
                    child: Icon(
                      Icons.class_,
                      color: SchoolDynamicColors.activeGreen,
                      size: 12,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Class $className $sectionName',
                    style: Theme.of(Get.context!).textTheme.labelMedium,
                  )
                ],
              ),
              Container(
                width: 1,
                height: 24,
                color: SchoolDynamicColors.borderColor,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: SchoolDynamicColors.activeBlue.withOpacity(0.1),
                    child: Icon(
                      Icons.menu_book_rounded,
                      color: SchoolDynamicColors.activeBlue,
                      size: 12,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    subject,
                    style: Theme.of(Get.context!).textTheme.labelMedium,
                  )
                ],
              ),
              Container(
                width: 1,
                height: 24,
                color: SchoolDynamicColors.borderColor,
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 12,
                    backgroundColor: SchoolDynamicColors.activeOrange.withOpacity(0.1),
                    child: Icon(
                      Icons.date_range_rounded,
                      color: SchoolDynamicColors.activeOrange,
                      size: 12,
                    ),
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    date,
                    style: Theme.of(Get.context!).textTheme.labelMedium,
                  )
                ],
              )
            ],
          ),
          SizedBox(
            height: SchoolSizes.md,
          ),
          // Divider(
          //   thickness: 0.5,
          //   color: SchoolColors.borderColor,
          // ),
          // SizedBox(
          //   height: SchoolSizes.sm,
          // ),

          Text(
            'Homework - $homework',
            style: Theme.of(Get.context!).textTheme.bodyLarge,
          )
        ],
      ),
    );
  }
}
