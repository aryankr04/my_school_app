import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/waste/circular_indicator_with_value.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ExamResults extends StatelessWidget {
  const ExamResults({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Exam Results',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall
                      ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                ),
              ),
              SizedBox(
                height: SchoolSizes.md,
              ),
              ResultCard(
                examName: 'Final Exam',
                percentage: 68.25,
                downloadLink: 'https://example.com/download',
                rank: 48,
                classs: '12',
                marks: 300,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final String examName;
  final String classs;
  final double percentage;
  final String downloadLink;
  final int rank;
  final int marks;

  ResultCard({
    required this.examName,
    required this.percentage,
    required this.downloadLink,
    required this.rank,
    required this.classs,
    required this.marks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 24),
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
        border: Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
        borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.description_rounded,
                    color: SchoolDynamicColors.activeBlue,
                    size: 48,
                  ),
                  SizedBox(
                    width: SchoolSizes.md,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          examName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(Get.context!)
                              .textTheme
                              .titleLarge
                              ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                        ),
                      ),
                      Text(
                        'Class - $classs',
                        style: Theme.of(Get.context!).textTheme.labelMedium,
                      ),

                      Text(
                        'Total - $marks',
                        style: Theme.of(Get.context!).textTheme.labelMedium,
                      ),

                      //LinearProgressIndicator(backgroundColor: Colors.black,color: SchoolColors.activeGreen,value: 0.24,minHeight: 2,)
                    ],
                  ),
                ],
              ),
              CircularPercentIndicator(
                radius: 32,
                animateFromLastPercent: true,
                progressColor: percentage > 40
                    ? SchoolDynamicColors.activeGreen
                    : SchoolDynamicColors.activeRed,
                backgroundColor: percentage > 40
                    ? SchoolDynamicColors.activeGreen.withOpacity(0.1)
                    : SchoolDynamicColors.activeRed.withOpacity(0.1),
                animation: true,
                circularStrokeCap: CircularStrokeCap.round,
                lineWidth: 6,
                percent: percentage / 100,
                center: Text(
                  '${(percentage).toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color:
                        SchoolDynamicColors.headlineTextColor, // Adjust the color as needed
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SchoolSizes.md, vertical: SchoolSizes.sm),
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.white,
                  border: Border.all(width: 1, color: SchoolDynamicColors.borderColor),
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
                ),
                child: Text(
                  'Rank - $rank',
                  style: TextStyle(
                      color: SchoolDynamicColors.headlineTextColor,
                      fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: SchoolSizes.sm),
                  decoration: BoxDecoration(
                    color: SchoolDynamicColors.backgroundColorWhiteLightGrey,
                    borderRadius:
                        BorderRadius.circular(SchoolSizes.cardRadiusXs),
                    border:
                        Border.all(width: 0.5, color: SchoolDynamicColors.activeBlue),
                  ),
                  child: Text(
                    'Download',
                    style: TextStyle(
                        color: SchoolDynamicColors.activeBlue,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              //SizedBox(width: 24,),

              Container(
                width: 100,
                padding: EdgeInsets.symmetric(
                    horizontal: SchoolSizes.spaceBtwSections,
                    vertical: SchoolSizes.sm),
                decoration: BoxDecoration(
                  color: SchoolDynamicColors.activeBlue,
                  borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusXs),
                ),
                child: Text(
                  'View',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
