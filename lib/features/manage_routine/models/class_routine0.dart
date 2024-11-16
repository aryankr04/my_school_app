class Routine {
  String id; // Added id field for the Routine document
  String classId;
  String className;
  String section;
  Map<String, List<DayEvent>> days; // Keys are days like "Monday", "Tuesday", etc.

  Routine({
    required this.id,
    required this.classId,
    required this.className,
    required this.section,
    required this.days,
  });

  // Factory method to create a Routine object from Firestore document data
  factory Routine.fromMap(Map<String, dynamic> data, String id) {
    Map<String, List<DayEvent>> days = {};

    data['days'].forEach((day, events) {
      days[day] = (events as List).map((event) => DayEvent.fromMap(event)).toList();
    });

    return Routine(
      id: id, // Assign the id of the document
      classId: data['classId'] ?? '',
      className: data['class'] ?? '',
      section: data['section'] ?? '',
      days: days,
    );
  }

  // Convert Routine to Firestore-friendly map
  Map<String, dynamic> toMap() {
    return {
      'classId': classId,
      'class': className,
      'section': section,
      'days': days.map((day, events) => MapEntry(day, events.map((event) => event.toMap()).toList())),
    };
  }
}

class DayEvent {
  String period; // "Start", "Assembly", "Break", "Departure" or "1", "2" etc. for class periods
  String? subject; // Only for class periods
  String? teacher; // Only for class periods
  String startTime;
  String endTime;

  DayEvent({
    required this.period,
    this.subject,
    this.teacher,
    required this.startTime,
    required this.endTime,
  });

  // Factory method to create DayEvent from map
  factory DayEvent.fromMap(Map<String, dynamic> data) {
    return DayEvent(
      period: data['period'] ?? '',
      subject: data['subject'],
      teacher: data['teacher'],
      startTime: data['start_time'] ?? '',
      endTime: data['end_time'] ?? '',
    );
  }

  // Convert DayEvent to Firestore-friendly map
  Map<String, dynamic> toMap() {
    return {
      'period': period,
      if (subject != null) 'subject': subject,
      if (teacher != null) 'teacher': teacher,
      'start_time': startTime,
      'end_time': endTime,
    };
  }

  // Add the copyWith method
  DayEvent copyWith({
    String? period,
    String? subject,
    String? teacher,
    String? startTime,
    String? endTime,
  }) {
    return DayEvent(
      period: period ?? this.period,
      subject: subject ?? this.subject,
      teacher: teacher ?? this.teacher,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
