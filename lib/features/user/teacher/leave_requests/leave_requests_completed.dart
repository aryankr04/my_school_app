import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/date_and_time.dart';
import '../../student/take_leave/apply.dart';
import 'leave_requests_waiting.dart';

class LeaveRequestsCompleted extends StatelessWidget {
  const LeaveRequestsCompleted({Key? key}) : super(key: key);

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
            //   "Completed Requests",
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
                    .where('status',
                        whereIn: ['Cancelled', 'Approved']).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No leave requests available'));
                  } else {
                    final leaveRequests = snapshot.data!.docs
                        .map((doc) => Leave.fromMap(
                            doc.data() as Map<String, dynamic>, doc.id))
                        .toList();

                    // Sort the leave requests by requestedOn date
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
                            : SizedBox(); // Otherwise, don't add a divider

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
