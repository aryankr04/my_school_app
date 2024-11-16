import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RoutineEntryScreen extends StatefulWidget {
  @override
  _RoutineEntryScreenState createState() => _RoutineEntryScreenState();
}

class _RoutineEntryScreenState extends State<RoutineEntryScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedDay = 'Monday';
  int _periodNumber = 1;
  String _subject = '';
  String _teacher = '';
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  List<Map<String, dynamic>> _periods = [];

  final List<String> _days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];

  // Format TimeOfDay to String
  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat.jm().format(dt);
  }

  // Add period to list
  void _addPeriod() {
    if (_formKey.currentState!.validate() && _startTime != null && _endTime != null) {
      setState(() {
        _periods.add({
          'period': _periodNumber,
          'subject': _subject,
          'teacher': _teacher,
          'start_time': formatTime(_startTime!),
          'end_time': formatTime(_endTime!),
        });
      });
      // Reset form fields
      _formKey.currentState!.reset();
      _startTime = null;
      _endTime = null;
    }
  }

  // Save routine to Firebase (function placeholder)
  void _saveRoutine() {
    // Code to save _periods to Firestore for the selected day
    print("Routine for $_selectedDay saved: $_periods");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Routine'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: _selectedDay,
              onChanged: (newDay) {
                setState(() => _selectedDay = newDay!);
              },
              items: _days.map((day) => DropdownMenuItem(value: day, child: Text(day))).toList(),
              decoration: InputDecoration(labelText: 'Select Day'),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Period Number'),
                    keyboardType: TextInputType.number,
                    onChanged: (val) => _periodNumber = int.parse(val),
                    validator: (val) => val!.isEmpty ? 'Enter period number' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Subject'),
                    onChanged: (val) => _subject = val,
                    validator: (val) => val!.isEmpty ? 'Enter subject' : null,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: 'Teacher'),
                    onChanged: (val) => _teacher = val,
                    validator: (val) => val!.isEmpty ? 'Enter teacher name' : null,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) setState(() => _startTime = picked);
                        },
                        child: Text(_startTime == null ? 'Start Time' : formatTime(_startTime!)),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (picked != null) setState(() => _endTime = picked);
                        },
                        child: Text(_endTime == null ? 'End Time' : formatTime(_endTime!)),
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: _addPeriod,
                    child: Text('Add Period'),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _periods.length,
                itemBuilder: (context, index) {
                  final period = _periods[index];
                  return Card(
                    child: ListTile(
                      title: Text('${period['subject']} - Period ${period['period']}'),
                      subtitle: Text('Teacher: ${period['teacher']}'),
                      trailing: Text('${period['start_time']} - ${period['end_time']}'),
                      onLongPress: () {
                        setState(() => _periods.removeAt(index));
                      },
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _saveRoutine,
              child: Text('Save Routine'),
            ),
          ],
        ),
      ),
    );
  }
}
