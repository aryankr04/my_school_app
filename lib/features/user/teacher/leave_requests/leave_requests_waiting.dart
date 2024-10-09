import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/color_chips.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/expansion.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/date_and_time.dart';
import '../../student/take_leave/apply.dart';

class LeaveRequestsWaiting extends StatelessWidget {
  const LeaveRequestsWaiting({Key? key}) : super(key: key);

  void updateLeaveStatus(String leaveId, String newStatus) {
    CollectionReference leaves =
        FirebaseFirestore.instance.collection('leaves');
    leaves.doc(leaveId).update({'status': newStatus});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SchoolSizes.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   "Waiting Requests",
            //   style: Theme.of(context).textTheme.headlineSmall,
            // ),
            // const SizedBox(height: 10),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('leaves')
                    .where('schoolId', isEqualTo: 'SCH0000000001')
                    .where('className', isEqualTo: '1')
                    .where('sectionName', isEqualTo: 'A')
                    .where('status', isEqualTo: 'Waiting')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text('No leave requests available'));
                  } else {
                    final leaveRequests = snapshot.data!.docs.map((doc) {
                      return Leave.fromMap(
                          doc.data() as Map<String, dynamic>, doc.id);
                    }).toList();

                    // Sort the leave requests by latest to oldest requested date
                    leaveRequests
                        .sort((a, b) => b.requestedOn.compareTo(a.requestedOn));

                    return ListView.builder(
                      itemCount: leaveRequests.length,
                      itemBuilder: (context, index) {
                        final leaveRequest = leaveRequests[index];
                        final currentDate = leaveRequest.requestedOn;

                        // Check if the date changes between consecutive leave requests
                        final bool isDateChange = index == 0 ||
                            leaveRequests[index - 1].requestedOn != currentDate;

                        // If date changes, add a divider
                        final Widget divider = isDateChange
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  currentDate, // Assuming requestedOn is a date
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: SchoolDynamicColors
                                        .subtitleTextColor, // Customize as needed
                                  ),
                                ),
                              )
                            : const SizedBox(); // Otherwise, don't add a divider

                        // Build the LeaveRequestCard
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            divider,
                            LeaveRequestCard(
                              requestNo: leaveRequest.id,
                              period:
                                  '${SchoolDateAndTimeFunction.getReadableDate(leaveRequest.fromDate)} - ${SchoolDateAndTimeFunction.getReadableDate(leaveRequest.fromDate)}',
                              reason: leaveRequest.reason,
                              status: leaveRequest.status,
                              leaveType: leaveRequest.leaveType,
                              requestedOn:
                                  SchoolDateAndTimeFunction.getReadableDate(
                                      leaveRequest.requestedOn),
                              onApprove: () {
                                updateLeaveStatus(leaveRequest.id, 'Approved');
                              },
                              onCancel: () {
                                updateLeaveStatus(leaveRequest.id, 'Cancelled');
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaveRequestCard extends StatelessWidget {
  final String requestNo;
  final String requestedOn;
  final String period;
  final String reason;
  final String status;
  final String leaveType;
  final VoidCallback? onApprove;
  final VoidCallback? onCancel;

  const LeaveRequestCard({
    required this.requestNo,
    required this.requestedOn,
    required this.period,
    required this.reason,
    required this.status,
    required this.leaveType,
    this.onApprove,
    this.onCancel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
          left: SchoolSizes.md, right: SchoolSizes.md, top: SchoolSizes.md),
      margin: const EdgeInsets.only(bottom: SchoolSizes.lg),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(SchoolSizes.cardRadiusXs),
                      color: SchoolDynamicColors.backgroundColorTintLightGrey,
                    ),
                    child: Icon(Icons.assignment,
                        size: 20, color: SchoolDynamicColors.primaryIconColor),
                  ),
                  const SizedBox(width: SchoolSizes.md),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Aryan Kumar',
                        style: Theme.of(Get.context!).textTheme.titleMedium,
                      ),
                      Text(
                        'Roll no - 14',
                        style: Theme.of(Get.context!)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: SchoolDynamicColors.activeBlue),
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  if (status == 'Approved')
                    ColorChips(
                      text: 'Approved',
                      color: SchoolDynamicColors.activeGreen,
                    )
                  else if (status == 'Cancelled')
                    ColorChips(
                      text: 'Cancelled',
                      color: SchoolDynamicColors.activeRed,
                    )
                  else if (status == 'Waiting')
                    ColorChips(
                      text: leaveType,
                      color: SchoolDynamicColors.activeOrange,
                    ),
                ],
              )
            ],
          ),
          Divider(
            thickness: 0.75,
            color: SchoolDynamicColors.borderColor,
          ),
          SchoolExpansionTile(
              title: Row(
                children: [
                  Text(
                    'Leave Details',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(
                    width: SchoolSizes.lg,
                  ),
                ],
              ),
              children: [
                buildInfoRow(
                  _getStatusColor(),
                  _getStatusColor().withOpacity(0.1),
                  Icons.date_range_rounded,
                  'Requested on',
                  requestedOn!,
                ),
                const SizedBox(height: SchoolSizes.md),
                buildInfoRow(
                  _getStatusColor(),
                  _getStatusColor().withOpacity(0.1),
                  Icons.date_range_rounded,
                  'Period',
                  period,
                ),
                const SizedBox(height: SchoolSizes.md),
                buildInfoRow(
                  _getStatusColor(),
                  _getStatusColor().withOpacity(0.1),
                  Icons.sick,
                  'Leave Type',
                  leaveType,
                ),
                const SizedBox(height: SchoolSizes.md),
                buildInfoRow(
                  _getStatusColor(),
                  _getStatusColor().withOpacity(0.1),
                  Icons.help_rounded,
                  'Reason',
                  reason,
                ),
                const SizedBox(
                  height: SchoolSizes.lg,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (status == 'Waiting' || status == 'Cancelled')
                      Expanded(
                        child: GestureDetector(
                          onTap: onApprove,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                              vertical: SchoolSizes.sm + 4,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  SchoolHelperFunctions.isDarkMode(Get.context!)
                                      ? SchoolDynamicColors.activeGreen
                                          .withOpacity(0.8)
                                      : SchoolDynamicColors.activeGreen,
                              borderRadius: BorderRadius.circular(
                                  SchoolSizes.cardRadiusSm),
                            ),
                            child: Text(
                              "Approve",
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: SchoolHelperFunctions.isDarkMode(
                                              Get.context!)
                                          ? SchoolDynamicColors.white
                                          : Colors.white),
                            ),
                          ),
                        ),
                      ),
                    if (status == 'Waiting')
                      const SizedBox(
                        width: SchoolSizes.md,
                      ),
                    if (status == 'Waiting' || status == 'Approved')
                      Expanded(
                        child: GestureDetector(
                          onTap: onCancel,
                          child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                vertical: SchoolSizes.sm + 4),
                            decoration: BoxDecoration(
                              color:
                                  SchoolHelperFunctions.isDarkMode(Get.context!)
                                      ? SchoolDynamicColors.activeRed
                                          .withOpacity(0.8)
                                      : SchoolDynamicColors.activeRed,
                              borderRadius: BorderRadius.circular(
                                  SchoolSizes.cardRadiusSm),
                            ),
                            child: Text(
                              "Cancel",
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: SchoolHelperFunctions.isDarkMode(
                                              Get.context!)
                                          ? SchoolDynamicColors.white
                                          : Colors.white),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: SchoolSizes.md,
                )
              ]),
        ],
      ),
    );
  }

  Widget buildInfoRow(
    Color? color,
    Color? tint,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        CircleAvatar(
          radius: 15,
          backgroundColor: tint,
          child: Icon(
            icon,
            color: color,
            size: 16,
          ),
        ),
        const SizedBox(width: SchoolSizes.md),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$label',
              style: TextStyle(
                  fontSize: 12,
                  color: SchoolDynamicColors.subtitleTextColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 280,
              child: Text(
                value,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }

  Color _getStatusColor() {
    switch (status.toLowerCase()) {
      case 'approved':
        return Colors.green;
      case 'waiting':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
