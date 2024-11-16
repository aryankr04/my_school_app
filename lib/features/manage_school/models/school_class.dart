import 'package:cloud_firestore/cloud_firestore.dart';

import '../../manage_routine/models/class_routine0.dart';

import '../../manage_routine/models/class_routine0.dart';

class SchoolClass {
  String id; // Class ID
  String schoolId; // School ID
  String className; // Class name (e.g., 5th Grade)
  String section; // Section (e.g., A, B, C)
  String roomNumber; // Room number where the class is held
  String classTeacherId; // Class teacher ID
  String classTeacherName; // Class teacher name
  List<TeacherIdName> teachers; // List of teacher IDs for additional subjects
  List<String> subjects; // List of subjects taught in the class
  List<StudentIdName> students; // List of student IDs in the class
  Routine? routine; // Routine for the class
  Map<String, AttendanceByDate> attendanceByDate; // Attendance by date

  SchoolClass({
    required this.id,
    required this.schoolId,
    required this.className,
    required this.section,
    required this.roomNumber,
    required this.classTeacherId,
    required this.classTeacherName,
    required this.teachers,
    required this.subjects,
    required this.students,
    this.routine,
    required this.attendanceByDate, // Initialize attendanceByDate
  });

  // Factory method to create an instance from a JSON map
  factory SchoolClass.fromJson(Map<String, dynamic> json) {
    return SchoolClass(
      id: json['id'],
      schoolId: json['schoolId'],
      className: json['className'],
      section: json['section'],
      roomNumber: json['roomNumber'],
      classTeacherId: json['classTeacherId'],
      classTeacherName: json['classTeacherName'],
      teachers: (json['teachers'] as List<dynamic>)
          .map((teacherJson) => TeacherIdName.fromJson(teacherJson))
          .toList(),
      subjects: List<String>.from(json['subjects'] ?? []),
      students: (json['students'] as List<dynamic>)
          .map((studentJson) => StudentIdName.fromJson(studentJson))
          .toList(),
      routine: json['routine'] != null
          ? Routine.fromMap(json['routine'], json['id'])
          : null,
      attendanceByDate: (json['attendanceByDate'] as Map<String, dynamic>?)
          ?.map((key, value) =>
          MapEntry(key, AttendanceByDate.fromJson(value))) ??
          {}, // Parse attendanceByDate
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'schoolId': schoolId,
      'className': className,
      'section': section,
      'roomNumber': roomNumber,
      'classTeacherId': classTeacherId,
      'classTeacherName': classTeacherName,
      'teachers': teachers.map((teacher) => teacher.toJson()).toList(),
      'subjects': subjects,
      'students': students.map((student) => student.toJson()).toList(),
      'routine': routine?.toMap(),
      'attendanceByDate': attendanceByDate.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class AttendanceByDate {
  DateTime date; // Date of attendance
  String teacherId; // Teacher ID who marked the attendance
  String teacherName; // Teacher name who marked the attendance
  Map<String, bool> attendanceRecords; // Student attendance records

  AttendanceByDate({
    required this.date,
    required this.teacherId,
    required this.teacherName,
    required this.attendanceRecords,
  });

  // Factory method to create an instance from a JSON map
  factory AttendanceByDate.fromJson(Map<String, dynamic> json) {
    return AttendanceByDate(
      date: (json['date'] as Timestamp).toDate(),
      teacherId: json['teacherId'],
      teacherName: json['teacherName'],
      attendanceRecords: Map<String, bool>.from(json['attendanceRecords']),
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'date': Timestamp.fromDate(date),
      'teacherId': teacherId,
      'teacherName': teacherName,
      'attendanceRecords': attendanceRecords,
    };
  }
}


class StudentIdName {
  String id; // Unique ID for the student
  String name; // Name of the student

  StudentIdName({
    required this.id,
    required this.name,
  });

  // Factory method to create an instance from a JSON map
  factory StudentIdName.fromJson(Map<String, dynamic> json) {
    return StudentIdName(
      id: json['id'],
      name: json['name'],
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}

class TeacherIdName {
  String id; // Unique ID for the teacher
  String name; // Name of the teacher

  TeacherIdName({
    required this.id,
    required this.name,
  });

  // Factory method to create an instance from a JSON map
  factory TeacherIdName.fromJson(Map<String, dynamic> json) {
    return TeacherIdName(
      id: json['id'],
      name: json['name'],
    );
  }

  // Method to convert the object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
