class School {
  final String schoolId;
  final String profileImageUrl;
  final String schoolName;
  final DateTime dateOfEstablishment;
  final DateTime date;
  final String address;
  final String country;
  final String state;
  final String city;
  final String mobileNo;
  final String email;
  final String schoolingSystem;
  final String schoolBoard;
  final String schoolCode;
  final String schoolType;
  final String affiliation;
  final List<String> extracurricularActivities;
  final List<String> classes;
  final int numberOfDirectors;
  final int numberOfPrincipal;
  final int numberOfManagements;
  final int numberOfTeachers;
  final int numberOfStudents;
  final int numberOfStaffs;
  final int numberOfDrivers;

  School({
    required this.schoolId,
    required this.profileImageUrl,
    required this.schoolName,
    required this.dateOfEstablishment,
    required this.address,
    required this.mobileNo,
    required this.email,
    required this.schoolingSystem,
    required this.schoolBoard,
    required this.schoolCode,
    required this.schoolType,
    required this.affiliation,
    required this.extracurricularActivities,
    required this.classes,
    required this.numberOfDirectors,
    required this.numberOfPrincipal,
    required this.numberOfManagements,
    required this.numberOfTeachers,
    required this.numberOfStudents,
    required this.numberOfStaffs,
    required this.numberOfDrivers,
    required this.date,
    required this.country,
    required this.state,
    required this.city,
  });

  factory School.fromJson(Map<String, dynamic> json) {
    return School(
      schoolId: json['schoolId'] ?? '',
      profileImageUrl: json['profileImageUrl'] ?? '',
      schoolName: json['schoolName'] ?? '',
      dateOfEstablishment: DateTime.parse(json['dateOfEstablishment'] ?? ''),
      address: json['address'] ?? '',
      mobileNo: json['mobileNo'] ?? '',
      email: json['email'] ?? '',
      schoolingSystem: json['schoolingSystem'] ?? '',
      schoolBoard: json['schoolBoard'] ?? '',
      schoolCode: json['schoolCode'] ?? '',
      schoolType: json['schoolType'] ?? '',
      affiliation: json['affiliation'] ?? '',
      extracurricularActivities: List<String>.from(json['extracurricularActivities'] ?? []),
      classes: List<String>.from(json['classes'] ?? []),
      numberOfDirectors: json['numberOfDirectors'] ?? 0,
      numberOfPrincipal: json['numberOfPrincipal'] ?? 0,
      numberOfManagements: json['numberOfManagements'] ?? 0,
      numberOfTeachers: json['numberOfTeachers'] ?? 0,
      numberOfStudents: json['numberOfStudents'] ?? 0,
      numberOfStaffs: json['numberOfStaffs'] ?? 0,
      numberOfDrivers: json['numberOfDrivers'] ?? 0,
      date: DateTime.parse(json['date'] ?? ''),
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolId': schoolId,
      'profileImageUrl': profileImageUrl,
      'schoolName': schoolName,
      'dateOfEstablishment': dateOfEstablishment.toIso8601String(),
      'address': address,
      'mobileNo': mobileNo,
      'email': email,
      'schoolingSystem': schoolingSystem,
      'schoolBoard': schoolBoard,
      'schoolCode': schoolCode,
      'schoolType': schoolType,
      'affiliation': affiliation,
      'extracurricularActivities': extracurricularActivities,
      'classes': classes,
      'numberOfDirectors': numberOfDirectors,
      'numberOfPrincipal': numberOfPrincipal,
      'numberOfManagements': numberOfManagements,
      'numberOfTeachers': numberOfTeachers,
      'numberOfStudents': numberOfStudents,
      'numberOfStaffs': numberOfStaffs,
      'numberOfDrivers': numberOfDrivers,
      'date': date.toIso8601String(),
      'country': country,
      'state': state,
      'city': city,
    };
  }
}
