class Teacher {
  // Basic Information
  final String uid;
  final String fullName;
  final DateTime dateOfBirth;
  final String gender;
  final DateTime dateOfJoining;
  final String designation; // e.g., Senior Teacher, Assistant Teacher
  final String department; // e.g., Science, Mathematics
  final String profilePictureUrl;

  // Contact Information
  final String address;
  final String phoneNumber;
  final String alternatePhoneNumber;
  final String email;

  // Educational Qualifications
  final String highestDegree; // e.g., M.Sc., B.Ed.
  final String specialization; // e.g., Physics, Mathematics
  final String university;
  final int graduationYear;
  final List<String> certifications; // e.g., Teaching Certification

  // Professional Experience
  final int totalYearsExperience;
  final String previousInstitution; // Name of previous school/institute

  // Subjects and Classes Taught
  final List<String> subjects; // e.g., Physics, Chemistry
  final List<String> classes; // e.g., A, B

  // Skills and Expertise
  final List<String> skills; // e.g., Classroom Management, Lesson Planning
  final List<String> extracurricularRoles; // e.g., Debate Club Mentor, Sports Coach

  // Additional Information
  final bool isClassTeacher;
  final String schoolId;
  final String role;
  final bool isTransportRequired;
  final String modeOfTransportation; // e.g., Bus, Car
  final String vehicleNo;
  final bool isActive;
  final String accountStatus; // e.g., Active, Suspended
  final DateTime lastLogin;
  final DateTime createdAt;

  // Social Information
  final List<String> followers;
  final List<String> following;
  final int noOfPosts;

  // Performance Metrics
  final int totalPoints;
  final int schoolRank;
  final int allIndiaRank;
  final int totalPresent;
  final int totalAbsent;
  final int totalSalaryDue;

  Teacher({
    required this.uid,
    required this.fullName,
    required this.dateOfBirth,
    required this.gender,
    required this.dateOfJoining,
    required this.designation,
    required this.department,
    this.profilePictureUrl = '',

    required this.address,
    required this.phoneNumber,
    this.alternatePhoneNumber = '',
    required this.email,

    required this.highestDegree,
    required this.specialization,
    required this.university,
    required this.graduationYear,
    this.certifications = const [],

    required this.totalYearsExperience,
    this.previousInstitution = '',

    required this.subjects,
    required this.classes,

    this.skills = const [],
    this.extracurricularRoles = const [],

    required this.isClassTeacher,
    required this.schoolId,
    required this.role,
    required this.isTransportRequired,
    required this.modeOfTransportation,
    required this.vehicleNo,
    required this.isActive,
    required this.accountStatus,
    required this.lastLogin,
    required this.createdAt,

    this.followers = const [],
    this.following = const [],
    this.noOfPosts = 0,
    this.totalPoints = 0,
    this.schoolRank = 0,
    this.allIndiaRank = 0,
    this.totalPresent = 0,
    this.totalAbsent = 0,
    this.totalSalaryDue = 0,
  });

  // Convert a Teacher object to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'dateOfJoining': dateOfJoining.toIso8601String(),
      'designation': designation,
      'department': department,
      'profilePictureUrl': profilePictureUrl,

      'address': address,
      'phoneNumber': phoneNumber,
      'alternatePhoneNumber': alternatePhoneNumber,
      'email': email,

      'highestDegree': highestDegree,
      'specialization': specialization,
      'university': university,
      'graduationYear': graduationYear,
      'certifications': certifications,

      'totalYearsExperience': totalYearsExperience,
      'previousInstitution': previousInstitution,

      'subjects': subjects,
      'classes': classes,

      'skills': skills,
      'extracurricularRoles': extracurricularRoles,

      'isClassTeacher': isClassTeacher,
      'schoolId': schoolId,
      'role': role,
      'isTransportRequired': isTransportRequired,
      'modeOfTransportation': modeOfTransportation,
      'vehicleNo': vehicleNo,
      'isActive': isActive,
      'accountStatus': accountStatus,
      'lastLogin': lastLogin.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),

      'followers': followers,
      'following': following,
      'noOfPosts': noOfPosts,
      'totalPoints': totalPoints,
      'schoolRank': schoolRank,
      'allIndiaRank': allIndiaRank,
      'totalPresent': totalPresent,
      'totalAbsent': totalAbsent,
      'totalSalaryDue': totalSalaryDue,
    };
  }

  // Create a Teacher object from a map (for Firestore retrieval)
  factory Teacher.fromMap(Map<String, dynamic> map) {
    return Teacher(
      uid: map['uid'],
      fullName: map['fullName'],
      dateOfBirth: DateTime.parse(map['dateOfBirth']),
      gender: map['gender'],
      dateOfJoining: DateTime.parse(map['dateOfJoining']),
      designation: map['designation'],
      department: map['department'],
      profilePictureUrl: map['profilePictureUrl'] ?? '',

      address: map['address'],
      phoneNumber: map['phoneNumber'],
      alternatePhoneNumber: map['alternatePhoneNumber'] ?? '',
      email: map['email'],

      highestDegree: map['highestDegree'],
      specialization: map['specialization'],
      university: map['university'],
      graduationYear: map['graduationYear'],
      certifications: List<String>.from(map['certifications'] ?? []),

      totalYearsExperience: map['totalYearsExperience'],
      previousInstitution: map['previousInstitution'] ?? '',

      subjects: List<String>.from(map['subjects']),
      classes: List<String>.from(map['classes']),

      skills: List<String>.from(map['skills'] ?? []),
      extracurricularRoles: List<String>.from(map['extracurricularRoles'] ?? []),

      isClassTeacher: map['isClassTeacher'] ?? false,
      schoolId: map['schoolId'],
      role: map['role'],
      isTransportRequired: map['isTransportRequired'] ?? false,
      modeOfTransportation: map['modeOfTransportation'] ?? '',
      vehicleNo: map['vehicleNo'] ?? '',
      isActive: map['isActive'] ?? true,
      accountStatus: map['accountStatus'] ?? 'Active',
      lastLogin: DateTime.parse(map['lastLogin']),
      createdAt: DateTime.parse(map['createdAt']),

      followers: List<String>.from(map['followers'] ?? []),
      following: List<String>.from(map['following'] ?? []),
      noOfPosts: map['noOfPosts'] ?? 0,
      totalPoints: map['totalPoints'] ?? 0,
      schoolRank: map['schoolRank'] ?? 0,
      allIndiaRank: map['allIndiaRank'] ?? 0,
      totalPresent: map['totalPresent'] ?? 0,
      totalAbsent: map['totalAbsent'] ?? 0,
      totalSalaryDue: map['totalSalaryDue'] ?? 0,
    );
  }
}


// class Teacher {
//   final String uid;
//   final String schoolId;
//   final String imageUrl;
//   final String teacherName;
//   final DateTime dateOfBirth;
//   final String gender;
//   final String mobileNo;
//   final String address;
//   final String email;
//   final String qualification;
//   final List<String> subjectsTaught;
//   final bool isClassTeacher;
//
//   Teacher({
//     required this.uid,
//     required this.schoolId,
//     required this.imageUrl,
//     required this.teacherName,
//     required this.dateOfBirth,
//     required this.gender,
//     required this.mobileNo,
//     required this.address,
//     required this.email,
//     required this.qualification,
//     required this.subjectsTaught,
//     required this.isClassTeacher,
//   });
//
//   factory Teacher.fromJson(Map<String, dynamic> json) {
//     return Teacher(
//       uid: json['uid'],
//       schoolId: json['schoolId'],
//       imageUrl: json['imageUrl'],
//       teacherName: json['teacherName'],
//       dateOfBirth: DateTime.parse(json['dateOfBirth']),
//       gender: json['gender'],
//       mobileNo: json['mobileNo'],
//       address: json['address'],
//       email: json['email'],
//       qualification: json['qualification'],
//       subjectsTaught: List<String>.from(json['subjectsTaught']),
//       isClassTeacher: json['isClassTeacher'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'uid': uid,
//       'schoolId': schoolId,
//       'imageUrl': imageUrl,
//       'teacherName': teacherName,
//       'dateOfBirth': dateOfBirth.toIso8601String(),
//       'gender': gender,
//       'mobileNo': mobileNo,
//       'address': address,
//       'email': email,
//       'qualification': qualification,
//       'subjectsTaught': subjectsTaught,
//       'isClassTeacher': isClassTeacher,
//     };
//   }
// }

