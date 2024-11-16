import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/colors.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../models/class_routine0.dart';
import '../../widgets/timeline_item.dart';

class TimelineItem extends StatelessWidget {
  final bool isMatch;
  final bool isStudent;
  final bool isWrite;
  final List<DayEvent> events;
  final String dayName;
  final Function(int index) onDelete;
  final Function(int index, DayEvent updatedEvent) onEdit;

  const TimelineItem({
    Key? key,
    required this.isWrite,
    required this.isMatch,
    required this.events,
    required this.dayName,
    required this.isStudent,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            color: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
            borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusSm),
            border:
                Border.all(width: 0.5, color: SchoolDynamicColors.borderColor),
          ),
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: SchoolSizes.sm + 2),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "$dayName Routine",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
              Divider(
                thickness: 0.75,
                height: 0.75,
                color: SchoolColors.dividerColor,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: SchoolSizes.sm - 4,
                    right: SchoolSizes.md,
                    top: SchoolSizes.md,
                    bottom: SchoolSizes.md),
                child: events.length == 0
                    ? Text('No routine found for tuesday.')
                    : Wrap(
                        children: events.asMap().entries.map((entry) {
                          int index = entry.key;
                          DayEvent event = entry.value;
                          DayEvent? nextEvent = index < events.length - 1
                              ? events[index + 1]
                              : null;

                          return _buildTimelineEvent(event, index,
                              previousEvent: nextEvent);
                        }).toList(),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineEvent(DayEvent event, int index,
      {DayEvent? previousEvent}) {
    final itemType = getItemType(event.period);
    final bool isContinuous =
        previousEvent != null && previousEvent.startTime == event.endTime;
    final textWidth = _getTextWidth('12:00 AM     ');

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTimeIndicators(event, isContinuous, textWidth),
          _buildEventCircle(itemType, event, isContinuous),
          SizedBox(width: SchoolSizes.md),
          _buildEventContent(event, itemType, index),
        ],
      ),
    );
  }

  Widget _buildEventContent(
      DayEvent event, TimelineItemType itemType, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: SchoolSizes.md),
        decoration: BoxDecoration(
          color: getContainerColor(itemType),
          borderRadius: BorderRadius.circular(SchoolSizes.cardRadiusMd),
        ),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: SchoolSizes.sm,
              decoration: BoxDecoration(
                color: getCircleColor(itemType),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(SchoolSizes.cardRadiusMd),
                  bottomLeft: Radius.circular(SchoolSizes.cardRadiusMd),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildEventDetails(event, itemType),
                    _buildActionButtons(index, event),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(int index, DayEvent event) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              onDelete(index); // Delete the event by calling the callback
            },
            child: Icon(Icons.delete, size: 24, color: SchoolColors.activeRed)),
        SizedBox(
          width: SchoolSizes.md,
        ),
        InkWell(
            onTap: () {
              // Simulating an edit. You would usually show a dialog or a form here.
              DayEvent updatedEvent =
                  event.copyWith(startTime: 'Updated Start Time');
              onEdit(index,
                  updatedEvent); // Edit the event by calling the callback
            },
            child: Icon(Icons.edit, size: 24, color: SchoolColors.activeBlue)),
      ],
    );
  }

  double _getTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(
          text: text, style: const TextStyle(fontWeight: FontWeight.w600)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.width;
  }

  Widget _buildTimeIndicators(
      DayEvent event, bool isContinuous, double textWidth) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: textWidth,
          alignment: Alignment.topCenter,
          child: Text(event.startTime,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
        if (!isContinuous && event.period != 'Start')
          Container(
            width: textWidth,
            alignment: Alignment.topCenter,
            child: Text(event.endTime,
                style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
      ],
    );
  }

  Widget _buildEventCircle(
      TimelineItemType itemType, DayEvent event, bool isContinuous) {
    return Column(
      children: [
        // if (!isContinuous)
        CircleAvatar(
          backgroundColor: getCircleColor(itemType),
          radius: 5,
        ),
        Expanded(
          child: Container(
            width: 2,
            color: getCircleColor(itemType),
          ),
        ),
        if (!isContinuous)
          CircleAvatar(
            backgroundColor: getCircleColor(itemType),
            radius: 5,
          ),
      ],
    );
  }

  Widget _buildEventDetails(DayEvent event, TimelineItemType itemType) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${event.startTime} - ${event.endTime}",
                style: Theme.of(Get.context!)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 13)),
            SizedBox(height: SchoolSizes.sm - 4),
            Text(
              event.subject ??
                  event.period, // Use the null-coalescing operator (??)
              style: Theme.of(Get.context!).textTheme.bodyLarge,
              overflow: TextOverflow.ellipsis, maxLines: 1,
            ),
            SizedBox(height: 2),
            if (itemType == TimelineItemType.classEvent &&
                event.teacher != null)
              Row(
                children: [
                  Icon(isStudent ? Icons.person : Icons.class_,
                      size: 16, color: SchoolDynamicColors.iconColor),
                  const SizedBox(width: 4),
                  Text(
                      isStudent
                          ? event.teacher ?? ''
                          : 'Class ${event.period} Section',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: Theme.of(Get.context!).textTheme.labelMedium),
                ],
              ),
          ],
        ),
      ],
    );
  }

  Color getCircleColor(TimelineItemType itemType) {
    return {
          TimelineItemType.classEvent: SchoolDynamicColors.activeBlue,
          TimelineItemType.breakEvent: SchoolDynamicColors.activeOrange,
          TimelineItemType.departure: SchoolDynamicColors.activeRed,
          TimelineItemType.start: SchoolDynamicColors.activeGreen,
          TimelineItemType.assembly: SchoolDynamicColors.activeOrange,
        }[itemType] ??
        Colors.black;
  }

  Color getContainerColor(TimelineItemType itemType) {
    return getCircleColor(itemType).withOpacity(0.1);
  }

  String getItemText(TimelineItemType itemType) {
    return {
          TimelineItemType.classEvent: 'Class Event',
          TimelineItemType.breakEvent: 'Break',
          TimelineItemType.departure: 'Departure',
          TimelineItemType.start: 'Start',
          TimelineItemType.assembly: 'Assembly',
        }[itemType] ??
        '';
  }

  TimelineItemType getItemType(String eventType) {
    return {
          'Class': TimelineItemType.classEvent,
          'Break': TimelineItemType.breakEvent,
          'Departure': TimelineItemType.departure,
          'Start': TimelineItemType.start,
          'Assembly': TimelineItemType.assembly,
        }[eventType] ??
        TimelineItemType.classEvent;
  }
}

enum TimelineItemType { classEvent, breakEvent, departure, start, assembly }
