// class User {
//   final String id;
//   final String name;
//   final String role;
//   final ContactInfo contactInfo;
//
//
//   User({
//     required this.id,
//     required this.name,
//     required this.role,
//     required this.contactInfo,
//   });
// }
//
//
// class ContactInfo {
//   final String email;
//   final String phoneNumber;
//   final Address address;
//
//
//   ContactInfo({
//     required this.email,
//     required this.phoneNumber,
//     required this.address,
//   });
// }
//
//
// class Address {
//   final String street;
//   final String city;
//   final String district;
//   final String state;
//
//
//   Address(this.street, this.city, this.district, this.state);
// }
//
//
// class Student {
//   final String name;
//   final String rollNumber;
//   final DateTime dateOfBirth;
//   final ContactInfo contactInfo;
//   final List<String> enrolledClasses;
//   final TransportationDetails transportation;
//   final String gender;
//   final String religion;
//   final double height;
//   final double weight;
//   final String bloodGroup;
//   final List<ExamSession> examSessions;
//
//
//   Student(
//       {required this.name,
//         required this.rollNumber,
//         required this.dateOfBirth,
//         required this.contactInfo,
//         required this.enrolledClasses,
//         required this.transportation,
//         required this.gender,
//         required this.religion,
//         required this.height,
//         required this.weight,
//         required this.bloodGroup,
//         required this.examSessions});
// }
//
//
// class Teacher {
//   final String id;
//   final String name;
//   final String employeeId;
//   final List<String> subjectsTaught;
//   final ContactInfo contactInfo;
//   final TransportationDetails transportation;
//
//
//   Teacher({
//     required this.id,
//     required this.name,
//     required this.employeeId,
//     required this.subjectsTaught,
//     required this.contactInfo,
//     required this.transportation,
//   });
// }
//
//
// class Administrator {
//   final String id;
//   final String name;
//   final ContactInfo contactInfo;
//
//
//   Administrator({
//     required this.id,
//     required this.name,
//     required this.contactInfo,
//   });
// }
//
//
// class Driver {
//   final String name;
//   final String licenseNumber;
//   final String contactNumber;
//
//
//   Driver({
//     required this.name,
//     required this.licenseNumber,
//     required this.contactNumber,
//   });
// }
//
//
// class Staff {
//   final String name;
//   final String position;
//   final String contactNumber;
//
//
//   Staff({
//     required this.name,
//     required this.position,
//     required this.contactNumber,
//   });
// }
//
//
// class Class {
//   final String id;
//   final String name;
//   final List<String> students;
//   final List<Subject> subjects;
//   final List<Section> sections;
//
//
//   Class({
//     required this.id,
//     required this.name,
//     required this.students,
//     required this.subjects,
//     required this.sections,
//   });
// }
//
//
// class Subject {
//   final String id;
//   final String name;
//   final String description;
//   final String teacherId; // ID of the teacher responsible for this subject
//
//
//   Subject({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.teacherId,
//   });
// }
//
//
// class Section {
//   final String id;
//   final String name;
//   final String classId;
//   final List<String> students;
//   final List<String> teachers;
//   final List<Schedule> schedule;
//
//
//   Section({
//     required this.id,
//     required this.name,
//     required this.classId,
//     required this.students,
//     required this.teachers,
//     required this.schedule,
//   });
// }
//
//
// class Assignment {
//   final String id;
//   final String teacherId;
//   final String classId;
//   final String sectionId;
//   final String assignment;
//   final DateTime dueDate;
//
//
//   Assignment({
//     required this.id,
//     required this.teacherId,
//     required this.classId,
//     required this.sectionId,
//     required this.assignment,
//     required this.dueDate,
//   });
// }
//
//
// class Attendance {
//   final DateTime date;
//   final String classId;
//   final String sectionId;
//   final List<AttendanceEntry> entries;
//
//
//   Attendance({
//     required this.date,
//     required this.classId,
//     required this.sectionId,
//     required this.entries,
//   });
// }
//
//
// class AttendanceEntry {
//   final String studentId;
//   final AttendanceStatus status;
//
//
//   AttendanceEntry({
//     required this.studentId,
//     required this.status,
//   });
// }
//
//
// enum AttendanceStatus { present, absent }
//
//
// class Notice {
//   final String id;
//   final String title;
//   final String content;
//   final DateTime date;
//
//
//   Notice({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.date,
//   });
// }
//
//
// class Syllabus {
//   final String classId;
//   final Map<String, String> subjectSyllabus;
//
//
//   Syllabus({
//     required this.classId,
//     required this.subjectSyllabus,
//   });
// }
//
//
// class Schedule {
//   final String dayOfWeek;
//   final List<Period> periods;
//
//
//   Schedule({
//     required this.dayOfWeek,
//     required this.periods,
//   });
// }
//
//
// class Period {
//   final String subjectId;
//   final String teacherId;
//
//
//   Period({
//     required this.subjectId,
//     required this.teacherId,
//   });
// }
//
//
// class FeePayment {
//   final double amount;
//   final DateTime date;
//   final PaymentStatus status;
//
//
//   FeePayment({
//     required this.amount,
//     required this.date,
//     required this.status,
//   });
// }
//
//
// enum PaymentStatus { paid, unpaid }
//
//
// class Message {
//   final String id;
//   final String senderId;
//   final String receiverId;
//   final String content;
//   final DateTime timestamp;
//
//
//   Message({
//     required this.id,
//     required this.senderId,
//     required this.receiverId,
//     required this.content,
//     required this.timestamp,
//   });
// }
//
//
// class Role {
//   final String userId;
//   final String role;
//
//
//   Role({
//     required this.userId,
//     required this.role,
//   });
// }
//
//
// class ClassMaterial {
//   final String classId;
//   final Map<String, SubjectMaterial> subjectMaterials;
//
//
//   ClassMaterial({
//     required this.classId,
//     required this.subjectMaterials,
//   });
// }
//
//
// class SubjectMaterial {
//   final String title;
//   final String fileUrl;
//
//
//   SubjectMaterial({
//     required this.title,
//     required this.fileUrl,
//   });
// }
//
//
// class Exam {
//   final String id;
//   final String classId;
//   final String subjectId;
//   final DateTime date;
//   final int maxMarks;
//
//
//   Exam({
//     required this.id,
//     required this.classId,
//     required this.subjectId,
//     required this.date,
//     required this.maxMarks,
//   });
// }
//
//
// class ExamResult {
//   final Exam exam;
//   final int obtainedMarks;
//   final String grade;
//
//
//   ExamResult({
//     required this.exam,
//     required this.obtainedMarks,
//     required this.grade,
//   });
// }
//
//
// class ExamSession {
//   final String sessionId;
//   final List<ExamResult> examResults;
//
//
//   ExamSession({
//     required this.sessionId,
//     required this.examResults,
//   });
// }
//
//
// class Grade {
//   final String studentId;
//   final String examinationId;
//   final int obtainedMarks;
//   final String grade;
//
//
//   Grade({
//     required this.studentId,
//     required this.examinationId,
//     required this.obtainedMarks,
//     required this.grade,
//   });
// }
//
//
// class Event {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime date;
//
//
//   Event({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.date,
//   });
// }
//
//
// class Book {
//   final String id;
//   final String title;
//   final String author;
//   final int publicationYear;
//   final int availableCopies;
//
//
//   Book({
//     required this.id,
//     required this.title,
//     required this.author,
//     required this.publicationYear,
//     required this.availableCopies,
//   });
// }
//
//
// class Bill {
//   final String id;
//   final double amount;
//   final DateTime dueDate;
//   final String status;
//
//
//   Bill({
//     required this.id,
//     required this.amount,
//     required this.dueDate,
//     required this.status,
//   });
// }
//
//
// class Notification {
//   final String id;
//   final String title;
//   final String content;
//   final DateTime date;
//
//
//   Notification({
//     required this.id,
//     required this.title,
//     required this.content,
//     required this.date,
//   });
// }
//
//
// class SearchData {
//   final String classId;
//   final String className;
//
//
//   SearchData({
//     required this.classId,
//     required this.className,
//   });
// }
//
//
// class Backup {
//   final String id;
//   final DateTime timestamp;
//   final String fileUrl;
//
//
//   Backup({
//     required this.id,
//     required this.timestamp,
//     required this.fileUrl,
//   });
// }
//
//
// class VehicleInfo {
//   final String name;
//   final String timing;
//   final String driverName;
//   final String route;
//   final String vehicleLicense;
//   final String contactNumber;
//   final String vehicleColor;
//   final int capacity;
//
//
//   VehicleInfo({
//     required this.name,
//     required this.timing,
//     required this.driverName,
//     required this.route,
//     required this.vehicleLicense,
//     required this.contactNumber,
//     required this.vehicleColor,
//     required this.capacity,
//   });
// }
//
//
// enum TransportationMode { foot, schoolTransport, bicycle, bike }
//
//
// class TransportationDetails {
//   final TransportationMode mode; // e.g., "foot" or "school_transport"
//   final VehicleInfo? vehicleInfo;
//   final Driver? driver;
//
//
//   TransportationDetails({
//     required this.mode,
//     this.vehicleInfo,
//     this.driver,
//   });
// }
//
