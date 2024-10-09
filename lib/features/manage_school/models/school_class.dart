class SchoolClass {
  String id;
  String name;
  String teacherId; // Teacher ID
  String teacherName; // Teacher Name
  String section;
  List<String> subjects; // List of subjects taught in the class
  List<String> students; // List of student IDs in the class
  String roomNumber; // Room number where the class is held
  String timetable; // Timetable ID for the class

  SchoolClass({
    required this.id,
    required this.name,
    required this.teacherId,
    required this.teacherName,
    required this.section,
    required this.subjects,
    required this.students,
    required this.roomNumber,
    required this.timetable,
  });

  factory SchoolClass.fromJson(Map<String, dynamic> json) {
    return SchoolClass(
      id: json['id'],
      name: json['name'],
      teacherId: json['teacherId'],
      teacherName: json['teacherName'],
      section: json['section'],
      subjects: List<String>.from(json['subjects']),
      students: List<String>.from(json['students']),
      roomNumber: json['roomNumber'],
      timetable: json['timetable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'teacherId': teacherId,
      'teacherName': teacherName,
      'section': section,
      'subjects': subjects,
      'students': students,
      'roomNumber': roomNumber,
      'timetable': timetable,
    };
  }
}