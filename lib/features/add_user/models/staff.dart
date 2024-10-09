class Staff {
  final String uid;
  final String imageUrl;
  final String staffName;
  final String schoolId;
  final DateTime dob;
  final String gender;
  final String position;
  final String mobileNumber;
  final String address;
  final String qualification;

  Staff({
    required this.uid,
    required this.imageUrl,
    required this.staffName,
    required this.schoolId,
    required this.dob,
    required this.gender,
    required this.position,
    required this.mobileNumber,
    required this.address,
    required this.qualification,
  });

  factory Staff.fromJson(Map<String, dynamic> json) {
    return Staff(
      uid: json['uid'],
      imageUrl: json['imageUrl'],
      staffName: json['staffName'],
      schoolId: json['schoolId'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      position: json['position'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      qualification: json['qualification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'staffName': staffName,
      'schoolId': schoolId,
      'dob': dob.toIso8601String(),
      'gender': gender,
      'position': position,
      'mobileNumber': mobileNumber,
      'address': address,
      'qualification': qualification,
    };
  }
}
