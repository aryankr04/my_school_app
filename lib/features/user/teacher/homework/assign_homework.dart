import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/elevated_button.dart';
import 'package:my_school_app/common/widgets/square_icon_button.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/features/user/teacher/homework/search_homework.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../../common/widgets/dropdown_form_feild.dart';
import '../../../../utils/constants/lists.dart';
import 'assign_homework_controller.dart';

class AssignHomework extends StatefulWidget {
  @override
  State<AssignHomework> createState() => _AssignHomeworkState();
}

class _AssignHomeworkState extends State<AssignHomework> {
  final AssignHomeworkController controller = Get.put(AssignHomeworkController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Obx(() => Column(
            children: [
              InkWell(
                onTap: () {
                  SchoolHelperFunctions.navigateToScreen(
                      context, SearchHomework());
                },
                child: Container(
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
                                width: 0.5, color: SchoolDynamicColors.borderColor),
                            borderRadius:
                            BorderRadius.circular(SchoolSizes.cardRadiusSm),
                          ),
                          child: Icon(
                            Icons.search_rounded,
                            color: SchoolDynamicColors.primaryColor,
                            size: 36,
                          ),
                        ),
                        SizedBox(
                          width: SchoolSizes.md,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Search Homework",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: SchoolDynamicColors.headlineTextColor),
                              ),
                              Text(
                                  "Search Homeworks according to the class and date",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: Theme.of(context).textTheme.labelSmall)
                            ],
                          ),
                        ),
                        SizedBox(
                          width: SchoolSizes.md,
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: SchoolDynamicColors.primaryColor,
                        )
                      ],
                    )),
              ),
              const SizedBox(height: SchoolSizes.spaceBtwSections),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Assign Homework",
                    style: Theme.of(context).textTheme.headlineSmall),
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              Row(
                children: [
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.classList,
                      labelText: 'Class',
                      validator: RequiredValidator(errorText: 'Select Class'),
                      selectedValue: controller.selectedClass.value,
                      onSelected: (value) {
                        controller.selectedClass.value = value;
                      },
                    ),
                  ),
                  const SizedBox(width: SchoolSizes.defaultSpace),
                  Expanded(
                    child: SchoolDropdownFormField(
                      items: SchoolLists.sectionList,
                      labelText: 'Section',
                      validator: RequiredValidator(errorText: 'Select Section'),
                      selectedValue: controller.selectedClass.value,
                      onSelected: (value) {
                        controller.selectedSection.value = value;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolDropdownFormField(
                items: SchoolLists.subjectList,
                labelText: 'Subject',
                validator: RequiredValidator(errorText: 'Select Section'),
                selectedValue: controller.selectedSubject.value,
                onSelected: (value) {
                  controller.selectedSubject.value = value;
                },
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),
              SchoolTextFormField(
                labelText: 'Homework',
                maxLines: 2,
                controller: controller.homeworkController,
              ),
              const SizedBox(height: SchoolSizes.defaultSpace),

              SchoolElevatedButton(text: 'Assign', onPressed: () {controller.storeHomeworkData();})
            ],
          )),
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
                      subject,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontSize: 16),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      homework,
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
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
                              ?.copyWith(color: SchoolDynamicColors.subtitleTextColor),
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
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {},
      headerProps: EasyHeaderProps(
          monthPickerType: MonthPickerType.switcher,
          selectedDateFormat: SelectedDateFormat.fullDateMonthAsStrDY,
          selectedDateStyle: TextStyle(
              color: SchoolDynamicColors.headlineTextColor,
              fontWeight: FontWeight.w500,
              fontSize: 18)),
      dayProps: EasyDayProps(
        height: 100,
        width: 70,
        dayStructure: DayStructure.dayStrDayNumMonth,
        inactiveDayStyle: DayStyle(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                border: Border.all(color: SchoolDynamicColors.darkGrey, width: 0.25)),
            dayNumStyle: const TextStyle(
                color: SchoolDynamicColors.darkGrey,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
        todayStyle: const DayStyle(
            dayNumStyle: TextStyle(
                color: SchoolDynamicColors.darkGrey,
                fontSize: 18,
                fontWeight: FontWeight.w500)),
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
