import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../common/widgets/option_list0.dart';
import '../../../../common/widgets/color_chips.dart';
import '../../../../common/widgets/expansion.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/date_and_time.dart';
import '../../../../utils/helpers/helper_functions.dart';
import 'apply.dart';

class RequestedLeaveController extends GetxController {
  RxList<Leave> leaveRequests = <Leave>[].obs;

  RxList<String> requestedTypeList = <String>[
    'All',
    'Approved',
    'Waiting',
    'Cancelled'
  ].obs; // Observable list of requested types
  RxString selectedRequestedType =
      'All'.obs; // Observable selected requested type

  // Method to fetch user leave requests and listen for real-time updates
  Stream<List<Leave>> getUserLeaveRequests(String uid) {
    try {
      CollectionReference leavesRef =
          FirebaseFirestore.instance.collection('leaves');

      // Listen for changes in the query and return a stream of leave requests
      return leavesRef.where('uid', isEqualTo: uid).snapshots().map(
          (querySnapshot) => querySnapshot.docs
              .map((doc) => Leave.fromMap(doc.data(), doc.id))
              .toList());
    } catch (e) {
      print('Error fetching leave requests: $e');
      throw e;
    }
  }

  @override
  void onInit() {
    super.onInit();
    print('fetched');

    // Subscribe to the stream and update leaveRequests when changes occur
    getUserLeaveRequests('STU0000000001').listen((data) {
      leaveRequests.assignAll(data);
    });
  }
}

class RequestedLeave extends StatelessWidget {
  final RequestedLeaveController leaveController =
      Get.put(RequestedLeaveController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Obx(() => Column(
                children: [
                  SizedBox(height: SchoolSizes.lg,),

                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Wrap(
                      runSpacing: 8.0,
                      spacing: 16.0,
                      children: leaveController.requestedTypeList.map((day) {
                        return CardButton(
                          text: day,
                          isSelected: day ==
                              leaveController.selectedRequestedType.value,
                          onPressed: () {
                            leaveController.selectedRequestedType.value = day;
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(
                    height: SchoolSizes.lg,
                  ),

                  StreamBuilder<List<Leave>>(
                    stream: leaveController
                        .getUserLeaveRequests('STU0000000001')
                        .map((leaveList) {
                      // Filter based on selectedRequestedType
                      return leaveList
                          .where((leave) =>
                              leave.status ==
                                  leaveController.selectedRequestedType.value ||
                              leaveController.selectedRequestedType.value ==
                                  'All')
                          .toList()
                        // Sort based on requestedOn (you can change this based on your requirement)
                        ..sort((a, b) {
                          if (leaveController.selectedRequestedType.value ==
                              'All') {
                            // Sort by decreasing request number for all statuses
                            return b.requestNumber.compareTo(a.requestNumber);
                          } else {
                            // Sort by status and then by decreasing request number
                            int statusComparison = a.status.compareTo(b.status);
                            if (statusComparison != 0) {
                              // If statuses are different, return the comparison result
                              return statusComparison;
                            } else {
                              // If statuses are the same, sort by decreasing request number
                              return b.requestNumber.compareTo(a.requestNumber);
                            }
                          }
                        });
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmerRequestedLeave();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        List<Leave> leaveRequests = snapshot.data ?? [];

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: leaveRequests.length,
                          itemBuilder: (context, index) {
                            Leave leave = leaveRequests[index];
                            return RequestedLeaveCard(
                              requestNo: leave.requestNumber.toString(),
                              requestedOn: SchoolDateAndTimeFunction.getReadableDate(leave.requestedOn),
                              period: '${SchoolDateAndTimeFunction.getReadableDate(leave.fromDate)} - ${SchoolDateAndTimeFunction.getReadableDate(leave.fromDate)}',
                              reason: leave.reason,
                              status: leave.status,
                              leaveType: leave.leaveType,
                            );
                          },
                        );
                      }
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }

  Widget _buildShimmerRequestedLeave() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: List.generate(
          5, // Number of shimmering items
          (index) => Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: SchoolSizes.md, horizontal: SchoolSizes.md),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
                color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
              ),
              height: 250,
            ),
          ),
        ),
      ),
    );
  }
}

class RequestedLeaveCard extends StatelessWidget {
  final String requestNo;
  final String? requestedOn;
  final String period;
  final String reason;
  final String status;
  final String leaveType;

  RequestedLeaveCard({
    required this.requestNo,
    this.requestedOn,
    required this.period,
    required this.reason,
    required this.status,
    Key? key,
    required this.leaveType,
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
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Request No  $requestNo',
                        style: Theme.of(Get.context!).textTheme.titleMedium,
                      ),
                      Text(
                          requestedOn!,
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
                      text: 'Waiting',
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
                // buildInfoRow(
                //   _getStatusColor(),
                //   _getStatusColor().withOpacity(0.1),
                //   Icons.date_range_rounded,
                //   'Requested on',
                //   requestedOn!,
                // ),
                // const SizedBox(height: SchoolSizes.md),
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
                  height: SchoolSizes.md,
                ),

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
    return Row(crossAxisAlignment: CrossAxisAlignment.start,
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
              width: 300,
              child: Text(
                value,
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w500),
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
      ],
    );
  }

  IconData _getStatusIcon() {
    switch (status.toLowerCase()) {
      case 'approved':
        return Icons.check_circle;
      case 'waiting':
        return Icons.info;
      case 'cancelled':
        return Icons.cancel;
      default:
        return Icons.help; // Handle unknown status
    }
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
        return Colors.grey; // Handle unknown status
    }
  }
}
