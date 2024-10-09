import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_school_app/common/widgets/expansion.dart';
import 'package:my_school_app/utils/constants/colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:readmore/readmore.dart';

import '../../../../common/widgets/color_chips.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/helpers/date_and_time.dart';
import '../../management/noticeboard/add_notice_new.dart';

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
                  itemCount: noticeItems
                      .length, // Add 1 for the "Post New Notice" item
                  itemBuilder: (context, index) {
                    final notice = noticeItems[
                        index]; // Subtract 1 to adjust for the additional item
                    return NoticeItem(
                      title: notice.title,
                      date: SchoolDateAndTimeFunction.getReadableDate(notice.date),
                      time: notice.time,
                      description: notice.description,
                      teacherName: notice.teacherId,
                      teacherId: notice.teacherId,
                      isWrite: false,
                    );
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

class NoticeItem extends StatelessWidget {
  final String title;
  final String date;
  final String time;
  final String description;
  final bool isWrite;
  final String teacherName;
  final String teacherId;
  final List<String>? forUser;
  final List<String>? forClass;
  final VoidCallback? onDelete; // Callback function for delete action

  const NoticeItem({
    Key? key,
    required this.title,
    required this.date,
    required this.time,
    required this.description,
    required this.isWrite,
    required this.teacherName,
    required this.teacherId,
    this.forUser,
    this.forClass,
    this.onDelete, // Accepting onDelete callback
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
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
            border:
                Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(SchoolSizes.sm),
                      decoration: BoxDecoration(
                        color: SchoolDynamicColors.activeBlue.withOpacity(0.1),
                        borderRadius:
                            BorderRadius.circular(SchoolSizes.cardRadiusXs),
                      ),
                      child: Icon(
                        Icons.notifications,
                        color: SchoolDynamicColors.activeBlue,
                      ),
                    ),
                    SizedBox(
                      width: SchoolSizes.md,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(title,
                                  style:
                                      Theme.of(context).textTheme.titleLarge),
                              isWrite
                                  ? IconButton(
                                      onPressed: onDelete,
                                      icon: Icon(
                                        Icons.delete,
                                        color: SchoolDynamicColors.activeRed,
                                      ))
                                  : SizedBox()
                            ],
                          ),
                          SizedBox(
                            height: SchoolSizes.sm - 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.date_range,
                                    size: 14,
                                    color: SchoolDynamicColors.iconColor,
                                  ),
                                  SizedBox(
                                    width: SchoolSizes.xs,
                                  ),
                                  Text(date,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              color: SchoolDynamicColors
                                                  .subtitleTextColor)),
                                ],
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 14,
                                    color: SchoolDynamicColors.iconColor,
                                  ),
                                  SizedBox(
                                    width: SchoolSizes.xs,
                                  ),
                                  Text(time,
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelLarge
                                          ?.copyWith(
                                              color: SchoolDynamicColors
                                                  .subtitleTextColor)),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: SchoolColors.dividerColor,
                width: double.infinity,
                height: .5,
              ),
// Divider(thickness: .5,color: SchoolColors.dividerColor,),
              // const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.all(SchoolSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Notice -',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    SizedBox(
                      height: SchoolSizes.xs,
                    ),
                    ReadMoreText(
                      description,
                      trimLines: 5,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'More',
                      trimExpandedText: 'Less',
                      moreStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                      lessStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic),
                    ),
                    SizedBox(
                      height: SchoolSizes.md - 4,
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.person,
                            size: 16,
                            color: SchoolDynamicColors.iconColor,
                          ),
                          radius: 16,
                          backgroundColor: SchoolDynamicColors.softGrey,
                        ),
                        SizedBox(
                          width: SchoolSizes.md - 4,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Aryan Kumar',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 13),
                            ),
                            Text(
                              teacherId,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: SchoolColors.subtitleTextColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              isWrite
                  ? Padding(
                      padding: const EdgeInsets.only(
                          left: SchoolSizes.md, right: SchoolSizes.md),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            color: SchoolColors.dividerColor,
                            width: double.infinity,
                            height: .5,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          SchoolExpansionTile(
                              title: Text(
                                'Only For',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Divider(
                                    //   color: SchoolDynamicColors.borderColor,
                                    // ),
                                    const SizedBox(
                                      height: SchoolSizes.sm,
                                    ),
                                    Wrap(
                                      runSpacing: 8.0,
                                      spacing: 12.0,
                                      children:
                                          forUser!.asMap().entries.map((entry) {
                                        String day = entry.value;

                                        return ColorChips(
                                          text: day,
                                          color: SchoolDynamicColors.activeBlue,
                                          padding: 4,
                                          borderRadius:
                                              SchoolSizes.cardRadiusXs,
                                        );
                                      }).toList(),
                                    ),
                                    if (forClass!.isNotEmpty)
                                      const SizedBox(
                                        height: SchoolSizes.md,
                                      ),
                                    Wrap(
                                      runSpacing: 8.0,
                                      spacing: 12.0,
                                      children: forClass!
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        String day = entry.value;

                                        return ColorChips(
                                          text: day,
                                          color: SchoolDynamicColors.activeBlue,
                                          padding: 4,
                                        );
                                      }).toList(),
                                    ),
                                    SizedBox(
                                      height: SchoolSizes.md,
                                    )
                                  ],
                                )
                              ]),
                        ],
                      ),
                    )
                  : SizedBox(),
            ],
          ),
        ),
        const SizedBox(
          height: SchoolSizes.lg,
        )
      ],
    );
  }
}
