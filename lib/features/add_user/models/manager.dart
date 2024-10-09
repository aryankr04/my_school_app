class Manager {
  final String schoolId;
  final String uid;
  final String managerName;
  final DateTime dateOfBirth;
  final String mobileNumber;
  final String address;
  final String email;
  final String qualification;
  final String profileImageUrl;

  Manager({
    required this.schoolId,
    required this.uid,
    required this.managerName,
    required this.dateOfBirth,
    required this.mobileNumber,
    required this.address,
    required this.email,
    required this.qualification,
    required this.profileImageUrl,
  });

  factory Manager.fromJson(Map<String, dynamic> json) {
    return Manager(
      schoolId: json['schoolId'],
      uid: json['uid'],
      managerName: json['managerName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      email: json['email'],
      qualification: json['qualification'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolId': schoolId,
      'managerName': uid,
      'name': managerName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'mobileNumber': mobileNumber,
      'address': address,
      'email': email,
      'qualification': qualification,
      'profileImageUrl': profileImageUrl,
    };
  }
}
