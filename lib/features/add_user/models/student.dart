class Student {
  final String uid;
  final String role;
  final String schoolId;
  final String studentName;
  final String firstName;
  final String lastName;
  final String admissionDate;
  final String admissionNo;
  final String className;
  final String sectionName;
  final String rollNo;
  final String dob;
  final String fatherName;
  final String fatherMobileNo;
  final String fatherOccupation;
  final String motherName;
  final String motherMobileNo;
  final String motherOccupation;
  final String nationality;
  final String heightFt;
  final String heightInch;
  final String weight;
  final String visionCondition;
  final String medicalCondition;
  final bool isPhysicalDisability;
  final String religion;
  final String category;
  final String gender;
  final String bloodGroup;
  final String mobileNo;
  final String email;
  final String aadhaarNo;
  final String address;
  final String state;
  final String district;
  final String city;
  final String pincode;
  final String modeOfTransportation;
  final String vehicleNo;
  final String houseOrTeam;
  final String favSubject;
  final String favTeacher;
  final String favSports;
  final String favFood;
  final List<String> hobbies;
  final String goal;
  final String username;
  final String password;
  final String profileImageUrl;
  final String birthCertificateImageUrl;
  final String transferCertificateImageUrl;
  final String aadhaarCardImageUrl;
  final bool isActive;
  final String accountStatus;
  final DateTime lastLogin;
  final DateTime createdAt;
  final List<String> followers;
  final List<String> following;
  final int noOfPosts;
  final int totalPoints;
  final int classRank;
  final int schoolRank;
  final int allIndiaRank;
  final int totalPresent;
  final int totalAbsent;
  final int totalDueFee;

  Student({
    required this.uid,
    required this.role,
    required this.schoolId,
    required this.studentName,
    required this.firstName,
    required this.lastName,
    required this.admissionDate,
    required this.admissionNo,
    required this.className,
    required this.sectionName,
    required this.rollNo,
    required this.dob,
    required this.fatherName,
    required this.fatherMobileNo,
    required this.fatherOccupation,
    required this.motherName,
    required this.motherMobileNo,
    required this.motherOccupation,
    required this.nationality,
    required this.heightFt,
    required this.heightInch,
    required this.weight,
    required this.visionCondition,
    required this.medicalCondition,
    required this.isPhysicalDisability,
    required this.religion,
    required this.category,
    required this.gender,
    required this.bloodGroup,
    required this.mobileNo,
    required this.email,
    required this.aadhaarNo,
    required this.address,
    required this.state,
    required this.district,
    required this.city,
    required this.pincode,
    required this.modeOfTransportation,
    required this.vehicleNo,
    required this.houseOrTeam,
    required this.favSubject,
    required this.favTeacher,
    required this.favSports,
    required this.favFood,
    required this.hobbies,
    required this.goal,
    required this.username,
    required this.password,
    required this.profileImageUrl,
    required this.birthCertificateImageUrl,
    required this.transferCertificateImageUrl,
    required this.aadhaarCardImageUrl,
    required this.isActive,
    required this.accountStatus,
    required this.lastLogin,
    required this.createdAt,
    required this.followers,
    required this.following,
    required this.noOfPosts,
    required this.totalPoints,
    required this.classRank,
    required this.schoolRank,
    required this.allIndiaRank,
    required this.totalPresent,
    required this.totalAbsent,
    required this.totalDueFee,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      uid: json['uid'],
      role: json['role'],
      schoolId: json['schoolId'],
      studentName: json['studentName'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      admissionDate: json['admissionDate'],
      admissionNo: json['admissionNo'],
      className: json['className'],
      sectionName: json['sectionName'],
      rollNo: json['rollNo'],
      dob: json['dob'],
      fatherName: json['fatherName'],
      fatherMobileNo: json['fatherMobileNo'],
      fatherOccupation: json['fatherOccupation'],
      motherName: json['motherName'],
      motherMobileNo: json['motherMobileNo'],
      motherOccupation: json['motherOccupation'],
      nationality: json['nationality'],
      heightFt: json['heightFt'],
      heightInch: json['heightInch'],
      weight: json['weight'],
      visionCondition: json['visionCondition'],
      medicalCondition: json['medicalCondition'],
      isPhysicalDisability: json['isPhysicalDisability'],
      religion: json['religion'],
      category: json['category'],
      gender: json['gender'],
      bloodGroup: json['bloodGroup'],
      mobileNo: json['mobileNo'],
      email: json['email'],
      aadhaarNo: json['aadhaarNo'],
      address: json['address'],
      state: json['state'],
      district: json['district'],
      city: json['city'],
      pincode: json['pincode'],
      modeOfTransportation: json['modeOfTransportation'],
      vehicleNo: json['vehicleNo'],
      houseOrTeam: json['houseOrTeam'],
      favSubject: json['favSubject'],
      favTeacher: json['favTeacher'],
      favSports: json['favSports'],
      favFood: json['favFood'],
      hobbies: List<String>.from(json['hobbies']),
      goal: json['goal'],
      username: json['username'],
      password: json['password'],
      profileImageUrl: json['profileImageUrl'],
      birthCertificateImageUrl: json['birthCertificateImageUrl'],
      transferCertificateImageUrl: json['transferCertificateImageUrl'],
      aadhaarCardImageUrl: json['aadhaarCardImageUrl'],
      isActive: json['isActive'],
      accountStatus: json['accountStatus'],
      lastLogin: DateTime.parse(json['lastLogin']),
      createdAt: DateTime.parse(json['createdAt']),
      followers: List<String>.from(json['followers']),
      following: List<String>.from(json['following']),
      noOfPosts: json['noOfPosts'],
      totalPoints: json['totalPoints'],
      classRank: json['classRank'],
      schoolRank: json['schoolRank'],
      allIndiaRank: json['allIndiaRank'],
      totalPresent: json['totalPresent'],
      totalAbsent: json['totalAbsent'],
      totalDueFee: json['totalDueFee'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'role': role,
      'schoolId': schoolId,
      'studentName': studentName,
      'firstName': firstName,
      'lastName': lastName,
      'admissionDate': admissionDate,
      'admissionNo': admissionNo,
      'className': className,
      'sectionName': sectionName,
      'rollNo': rollNo,
      'dob': dob,
      'fatherName': fatherName,
      'fatherMobileNo': fatherMobileNo,
      'fatherOccupation': fatherOccupation,
      'motherName': motherName,
      'motherMobileNo': motherMobileNo,
      'motherOccupation': motherOccupation,
      'nationality': nationality,
      'heightFt': heightFt,
      'heightInch': heightInch,
      'weight': weight,
      'visionCondition': visionCondition,
      'medicalCondition': medicalCondition,
      'isPhysicalDisability': isPhysicalDisability,
      'religion': religion,
      'category': category,
      'gender': gender,
      'bloodGroup': bloodGroup,
      'mobileNo': mobileNo,
      'email': email,
      'aadhaarNo': aadhaarNo,
      'address': address,
      'state': state,
      'district': district,
      'city': city,
      'pincode': pincode,
      'modeOfTransportation': modeOfTransportation,
      'vehicleNo': vehicleNo,
      'houseOrTeam': houseOrTeam,
      'favSubject': favSubject,
      'favTeacher': favTeacher,
      'favSports': favSports,
      'favFood': favFood,
      'hobbies': hobbies,
      'goal': goal,
      'username': username,
      'password': password,
      'profileImageUrl': profileImageUrl,
      'birthCertificateImageUrl': birthCertificateImageUrl,
      'transferCertificateImageUrl': transferCertificateImageUrl,
      'aadhaarCardImageUrl': aadhaarCardImageUrl,
      'isActive': isActive,
      'accountStatus': accountStatus,
      'lastLogin': lastLogin.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'followers': followers,
      'following': following,
      'noOfPosts': noOfPosts,
      'totalPoints': totalPoints,
      'classRank': classRank,
      'schoolRank': schoolRank,
      'allIndiaRank': allIndiaRank,
      'totalPresent': totalPresent,
      'totalAbsent': totalAbsent,
      'totalDueFee': totalDueFee,
    };
  }
}
