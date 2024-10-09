class Driver {
  final String schoolId;
  final String uid;
  final String driverName;
  final DateTime dateOfBirth;
  final String gender;
  final String mobileNumber;
  final String address;
  final String qualification;
  final String selectedVehicle;
  final String licenceNumber;
  final String profileImageUrl;

  Driver({
    required this.schoolId,
    required this.uid,
    required this.driverName,
    required this.dateOfBirth,
    required this.gender,
    required this.mobileNumber,
    required this.address,
    required this.qualification,
    required this.selectedVehicle,
    required this.licenceNumber,
    required this.profileImageUrl,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      schoolId: json['schoolId'],
      uid: json['uid'],
      driverName: json['driverName'],
      dateOfBirth: DateTime.parse(json['dateOfBirth']),
      gender: json['gender'],
      mobileNumber: json['mobileNumber'],
      address: json['address'],
      qualification: json['qualification'],
      selectedVehicle: json['selectedVehicle'],
      licenceNumber: json['licenceNumber'],
      profileImageUrl: json['profileImageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolId': schoolId,
      'uid': uid,
      'driverName': driverName,
      'dateOfBirth': dateOfBirth.toIso8601String(),
      'gender': gender,
      'mobileNumber': mobileNumber,
      'address': address,
      'qualification': qualification,
      'selectedVehicle': selectedVehicle,
      'licenceNumber': licenceNumber,
      'profileImageUrl': profileImageUrl,
    };
  }
}
