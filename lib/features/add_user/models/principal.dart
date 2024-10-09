class Principal {
  final String uid;
  final String imageUrl;
  final String principalName;
  final String schoolId;
  final DateTime dob;
  final String gender;
  final String mobileNumber;
  final String address;
  final String email;
  final String qualification;

  Principal({
    required this.uid,
    required this.imageUrl,
    required this.principalName,
    required this.schoolId,
    required this.dob,
    required this.gender,
    required this.mobileNumber,
    required this.address,
    required this.email,
    required this.qualification,
  });

  factory Principal.fromJson(Map<String, dynamic> json) {
    return Principal(
      uid: json['uid'],
      imageUrl: json['imageUrl'],
      principalName: json['principalName'],
      schoolId: json['schoolId'],
      dob: DateTime.parse(json['dob']),
      gender: json['gender'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      email: json['email'],
      qualification: json['qualification'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'imageUrl': imageUrl,
      'principalName': principalName,
      'schoolId': schoolId,
      'dob': dob.toIso8601String(),
      'gender': gender,
      'mobileNumber': mobileNumber,
      'address': address,
      'email': email,
      'qualification': qualification,
    };
  }
}
