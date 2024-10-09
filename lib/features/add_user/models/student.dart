class Student {
  final String uid;
  final String schoolId;
  final String studentName;
  final String className;
  final String sectionName;
  final String rollNo;
  final String dob;
  final String fatherName;
  final String motherName;

  final String heightFt;
  final String heightInch;
  final String weight;
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

  final String transportation;
  final String vehicleNo;
  final String favSubject;
  final String favTeacher;
  final String favSports;
  final String otherActivities;

  final String username;
  final String password;

  Student({
    required this.uid,
    required this.schoolId,
    required this.studentName,
    required this.className,
    required this.sectionName,
    required this.rollNo,
    required this.dob,
    required this.fatherName,
    required this.motherName,
    required this.heightFt,
    required this.heightInch,
    required this.weight,
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
    required this.transportation,
    required this.vehicleNo,
    required this.favSubject,
    required this.favTeacher,
    required this.favSports,
    required this.otherActivities,
    required this.username,
    required this.password,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      uid: json['uid'],
      schoolId: json['schoolId'],
      studentName: json['studentName'],
      className: json['className'],
      sectionName: json['sectionName'],
      rollNo: json['rollNo'],
      dob: json['dob'],
      fatherName: json['fatherName'],
      motherName: json['motherName'],
      heightFt: json['heightFt'],
      heightInch: json['heightInch'],
      weight: json['weight'],
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
      transportation: json['transportaion'],
      vehicleNo: json['vehicleNo'],
      favSubject: json['favSubject'],
      favTeacher: json['favTeacher'],
      favSports: json['favSports'],
      otherActivities: json['otherActivities'],
      username: json['username'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'schoolId': schoolId,
      'studentName': studentName,
      'className': className,
      'sectionName': sectionName,
      'rollNo': rollNo,
      'dob': dob,
      'fatherName': fatherName,
      'motherName': motherName,
      'heightFt': heightFt,
      'heightInch': heightInch,
      'weight': weight,
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
      'transportation': transportation,
      'vehicleNo': vehicleNo,
      'favSubject': favSubject,
      'favTeacher': favTeacher,
      'favSports': favSports,
      'otherActivities': otherActivities,
      'username': username,
      'password': password,
    };
  }
}
