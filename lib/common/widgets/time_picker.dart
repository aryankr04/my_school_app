import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'text_form_feild.dart';

class TimePickerField extends StatefulWidget {
  final String labelText;
  final String? initialTime;
  final ValueChanged<TimeOfDay>? onTimeChanged;
  final InputDecoration? decoration;

  TimePickerField({
    required this.initialTime,
    required this.onTimeChanged,
    required this.labelText,
    this.decoration,
  });

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  late TextEditingController _timeController;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedTime = widget.initialTime != null
        ? _parseTime(widget.initialTime!)
        : TimeOfDay.now();
    _timeController = TextEditingController(
      text: formatTimeOfDay(_selectedTime),
    );
  }

  TimeOfDay _parseTime(String timeString) {
    // Remove any leading or trailing whitespace
    timeString = timeString.trim();

    // Split the time string into hours, minutes, and AM/PM designation
    List<String> parts = timeString.split(' ');

    // Extract hours and minutes from the first part
    List<String> timeParts = parts[0].split(':');
    int hour = int.tryParse(timeParts[0]) ?? 0;

    String amPm = timeString.substring(timeString.length - 2);

    print(amPm);

    // Correctly parse minutes
    int minute =
        int.tryParse(timeParts[1].replaceAll(RegExp(r'[^\d]'), '')) ?? 0;

    // Adjust hour for PM time
    if (amPm == 'PM') {
      hour += 12;
    }

    // Return the parsed TimeOfDay object
    return TimeOfDay(hour: hour, minute: minute);
  }

  @override
  Widget build(BuildContext context) {
    return SchoolTextFormField(
      decoration: widget.decoration,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return widget.labelText + ' is required';
        }
        return null;
      },
      controller: _timeController,
      readOnly: true,
      prefixIcon: Icons.access_time,
      labelText: widget.labelText,
      onTap: () => _selectTime(context),
    );
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (pickedTime != null && pickedTime != _selectedTime) {
      setState(() {
        _selectedTime = pickedTime;
        _timeController.text = _selectedTime.format(context);
      });
      if (widget.onTimeChanged != null) {
        widget.onTimeChanged!(_selectedTime);
      }
    }
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final time = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final formattedTime = DateFormat.jm().format(time);
    return formattedTime;
  }
}
