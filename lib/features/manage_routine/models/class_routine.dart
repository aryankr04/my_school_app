import 'package:cloud_firestore/cloud_firestore.dart';

class ClassRoutine {
  final String id;
  final String startsAt; // Changed time to startsAt
  final String endsAt; // Added endsAt
  final String subject;
  final String sectionId;
  final String classTeacherId;
  final String classTeacherName;
  final String eventType;
  final String day;
  final String className;
  final String sectionName;

  ClassRoutine({
    required this.id,
    required this.startsAt, // Changed time to startsAt
    required this.endsAt, // Added endsAt
    required this.subject,
    required this.sectionId,
    required this.classTeacherId,
    required this.classTeacherName,
    required this.eventType,
    required this.day,
    required this.className,
    required this.sectionName,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'startsAt': startsAt, // Changed time to startsAt
      'endsAt': endsAt, // Added endsAt
      'subject': subject,
      'sectionId': sectionId,
      'classTeacherId': classTeacherId,
      'classTeacherName': classTeacherName,
      'eventType': eventType,
      'day': day,
      'className': className,
      'sectionName': sectionName,
    };
  }

  factory ClassRoutine.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ClassRoutine(
      id: snapshot.id,
      startsAt: data['startsAt'], // Initialize startsAt from snapshot data
      endsAt: data['endsAt'], // Initialize endsAt from snapshot data
      subject: data['subject'],
      sectionId: data['sectionId'],
      classTeacherId: data['classTeacherId'],
      classTeacherName: data['classTeacherName'],
      eventType: data['eventType'],
      day: data['day'],
      className: data['className'],
      sectionName: data['sectionName'],
    );
  }
}
