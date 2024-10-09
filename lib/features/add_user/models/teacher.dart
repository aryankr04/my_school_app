class Teacher {
  final String uid;
  final String schoolId;
  final String imageUrl;
  final String teacherName;
  final DateTime dateOfBirth;
  final String gender;
  final String mobileNo;
  final String address;
  final String email;
  final String qualification;
  final List<String> subjectsTaught;
  final bool isClassTeacher;

  Teacher({
    required this.uid,
    required this.schoolId,
    required this.imageUrl,
    required this.teacherName,
    required this.dateOfBirth,
    required this.gender,
    required this.mobileNo,
    required this.address,
    required this.email,
    required this.qualification,
    required this.subjectsTaught,
    required this.isClassTeacher,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      uid: json['uid'],
      schoolId: json['schoolId'],
      imageUrl: json['imageUrl'],
      teacherName: json['teacherName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      mobileNo: json['mobileNo'],
      address: json['address'],
      email: json['email'],
      qualification: json['qualification'],
      subjectsTaught: List<String>.from(json['subjectsTaught']),
      isClassTeacher: json['isClassTeacher'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'schoolId': schoolId,
      'imageUrl': imageUrl,
      'teacherName': teacherName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'mobileNo': mobileNo,
      'address': address,
      'email': email,
      'qualification': qualification,
      'subjectsTaught': subjectsTaught,
      'isClassTeacher': isClassTeacher,
    };
  }
}
