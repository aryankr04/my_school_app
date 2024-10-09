import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';

class FeeDetails extends StatelessWidget {
  const FeeDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(SchoolSizes.lg),
        child: Column(
          children: [
            Container(
                padding: const EdgeInsets.only(
                    left: SchoolSizes.sm,
                    right: SchoolSizes.lg,
                    top: SchoolSizes.sm,
                    bottom: SchoolSizes.sm),
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: SchoolDynamicColors.activeBlue.withOpacity(.1),
                              borderRadius: BorderRadius.circular(
                                  SchoolSizes.borderRadiusMd),
                            ),
                            child: Icon(
                              Icons.currency_rupee_rounded,
                              size: 22,
                              color: SchoolDynamicColors.activeBlue,
                            ),
                          ),
                          const SizedBox(width: SchoolSizes.md),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '- ₹ 3500',
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall
                                    ?.copyWith(color: SchoolDynamicColors.activeRed),
                              ),
                              Text(
                                'Total Fee Due',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                      FilledButton(
                          onPressed: () {},
                          child: Text(
                            'Pay',
                            style: TextStyle(fontSize: 14),
                          ))
                    ])),
            SizedBox(
              height: SchoolSizes.spaceBtwSections,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Fee Details',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
              ),
            ),
            SizedBox(height: SchoolSizes.md,),
            Container(
                padding: const EdgeInsets.all(SchoolSizes.md),
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'December',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
                            ),
                            Text('₹ 2500',
                                style:
                                Theme.of(context).textTheme.headlineSmall),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 8, horizontal: 32),
                          decoration: BoxDecoration(
                            color: SchoolDynamicColors.activeGreen,
                            borderRadius: BorderRadius.circular(48),
                          ),
                          child: Text(
                            'Paid',
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                    Divider(
                      thickness: 0.4,color: Colors.grey,
                    ),
                    _buildTextColumn('Tution Fee', '4500'),
                    _buildTextColumn('Late Charges', '456'),
                    _buildTextColumn('ID Card Charge', '545'),
                    _buildTextColumn('Books Fee', '456'),
                    _buildTextColumn('Stationary Fee', '754'),
                    _buildTextColumn('Transport Fee', '400'),
                    _buildTextColumn('Discount', '- 300'),
                    SizedBox(
                      height: SchoolSizes.sm,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Fee",
                          style: Theme.of(Get.context!)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                              fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "₹ 12546",
                          style: Theme.of(Get.context!)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(
                              color: SchoolDynamicColors.headlineTextColor,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildTextColumn(String text1, String text2) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text1,
              style: Theme.of(Get.context!).textTheme.bodyMedium?.copyWith(
                  color: SchoolDynamicColors.subtitleTextColor, fontWeight: FontWeight.w500),
            ),
            Text(
              '₹ $text2',
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
            ),
          ],
        ),
        SizedBox(height: SchoolSizes.sm,),

      ],
    );
  }
}
