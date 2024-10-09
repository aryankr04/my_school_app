import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/features/user/management/noticeboard/add_notice.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../student/noticeboard/notice.dart';
import 'add_notice_new.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: FutureBuilder<List<NoticeData>>(
            future: fetchNoticesByTeacherId(
                'TEA0000000001'), // Assuming fetchNoticesByTeacherId returns a Future<List<NoticeData>>
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                final noticeItems = snapshot.data ?? [];
                return ListView.builder(
                  itemCount: noticeItems.length +
                      1, // Add 1 for the "Post New Notice" item
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          SchoolHelperFunctions.navigateToScreen(
                              context, AddNotice());
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: SchoolSizes.lg,
                              horizontal: SchoolSizes.xs),
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
                            border: Border.all(
                                width: 0.5, color: SchoolDynamicColors.borderColor),
                            borderRadius:
                                BorderRadius.circular(SchoolSizes.cardRadiusSm),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(SchoolSizes.sm),
                                decoration: BoxDecoration(
                                  color: SchoolDynamicColors.primaryTintColor,
                                  border: Border.all(
                                      width: 0.5,
                                      color: SchoolDynamicColors.borderColor),
                                  borderRadius: BorderRadius.circular(
                                      SchoolSizes.cardRadiusSm),
                                ),
                                child: Icon(
                                  Icons.add,
                                  color: SchoolDynamicColors.primaryColor,
                                  size: 36,
                                ),
                              ),
                              SizedBox(width: SchoolSizes.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Post New Notice",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                              color: SchoolDynamicColors.headlineTextColor),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: SchoolSizes.md),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: SchoolDynamicColors.primaryColor,
                              )
                            ],
                          ),
                        ),
                      );
                    } else {
                      final notice = noticeItems[index -
                          1]; // Subtract 1 to adjust for the additional item
                      return NoticeItem(
                        title: notice.title,
                        date: notice.date,
                        time: notice.time,
                        description: notice.description,
                        teacherName: notice.teacherId,
                        teacherId: notice.teacherId,
                        isWrite: false,

                      );
                    }
                  },
                );
              }
            },
          )),
    );
  }

  Future<List<NoticeData>> fetchNoticesByTeacherId(String teacherId) async {
    List<NoticeData> notices = [];

    try {
      // Access Firestore instance
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Query notices collection for notices with given teacherId
      QuerySnapshot querySnapshot = await firestore
          .collection('notices')
          .where('teacherId', isEqualTo: teacherId)
          .get();

      // Loop through query snapshot and convert documents to NoticeData objects
      querySnapshot.docs.forEach((doc) {
        Map<String, dynamic>? data =
            doc.data() as Map<String, dynamic>?; // Explicit cast
        if (data != null) {
          NoticeData notice = NoticeData(
            id: doc.id,
            date: data['date'],
            time: data['time'],
            title: data['title'],
            description: data['description'],
            teacherId: data['teacherId'],
            forClass: List<String>.from(data['forClass']),
            schoolId: data['schoolId'],
            forUser: List<String>.from(data['forUser']),
          );
          notices.add(notice);
        }
      });

      return notices;
    } catch (error) {
      print('Error fetching notices from Firebase: $error');
      // Handle the error appropriately, e.g., show an error message to the user
      return [];
    }
  }
}
