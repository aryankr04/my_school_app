import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';

class FeePayments extends StatelessWidget {
  const FeePayments({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDateTime = DateFormat('dd MMM yyyy At h:mm a').format(now);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SchoolSizes.lg),
        child: Column(
          children: [
            SizedBox(height: SchoolSizes.md,),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Payments History',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
              ),
            ),
            SizedBox(height: SchoolSizes.md,),
            Paid('Aryan Kumar', formattedDateTime, 6500,2456),
            Paid('Aryan Kumar', formattedDateTime, 6500,2456),
            Paid('Aryan Kumar', formattedDateTime, 6500,2456),
            Paid('Aryan Kumar', formattedDateTime, 6500,2456),
            Paid('Aryan Kumar', formattedDateTime, 6500,2456),

          ],
        ),
      ),
    );
  }

  Widget Paid(String senderName, String dateTime, int amount,int dueAfterPayment) {
    return Container(
      margin: EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(SchoolSizes.md - 4),
      decoration: BoxDecoration(
        color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
        border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: SchoolDynamicColors.grey,
              ),
              SizedBox(
                width: SchoolSizes.md,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    senderName,
                    style: Theme.of(Get.context!)
                        .textTheme
                        .titleLarge
                        ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    dateTime.toString(),
                    style: Theme.of(Get.context!).textTheme.labelMedium,
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '- ₹ $dueAfterPayment',
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: SchoolDynamicColors.activeRed),
              ),
              Text(
                '+ ₹ $amount',
                style: Theme.of(Get.context!)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: SchoolDynamicColors.activeGreen),
              ),

            ],
          ),
        ],
      ),
    );
  }
}
