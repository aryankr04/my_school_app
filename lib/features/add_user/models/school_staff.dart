class SchoolStaff {
  // Identification and Personal Information
  final String uid;
  final String name;
  final DateTime dob;
  final String gender;
  final String nationality;
  final String religion;
  final String category;
  final String bloodGroup;
  final double height;
  final String maritalStatus;
  final String profileDescription;

  // Contact Information
  final String address;
  final String pincode;
  final String email;
  final String phoneNumber;
  final String emergencyContact;

  // Employment Details
  final DateTime dateOfJoining;
  final bool isActive;
  final String accountStatus;
  final String modeOfTransport;

  // Educational and Professional Background
  final String educationalQualification;
  final String universityOrCollege;
  final int experience;
  final List<String> certifications;

  // Account and Authentication
  final String password;
  final DateTime lastLogin;
  final DateTime createdAt;

  // Social Metrics
  final int following;
  final int followers;
  final int posts;

  // Languages
  final List<String> languagesSpoken;

  // Profile Picture
  final String profilePictureUrl;

  // Attendance Tracking
  final int presentDays;
  final int absentDays;

  // Performance Metrics
  final double performanceRating;
  final int points; // Total points for performance metrics

  // Role(s) in the School
  final List<String> roles;

  // Specific Role Details (Optional)
  final PrincipalDetails? principalDetails;
  final VicePrincipalDetails? vicePrincipalDetails;
  final TeacherDetails? teacherDetails;
  final DepartmentHeadDetails? departmentHeadDetails;
  final GuidanceCounselorDetails? guidanceCounselorDetails;
  final SchoolAdministratorDetails? schoolAdministratorDetails;
  final LibrarianDetails? librarianDetails;
  final SchoolNurseDetails? schoolNurseDetails;
  final SportsCoachDetails? sportsCoachDetails;
  final SpecialEducationTeacherDetails? specialEducationTeacherDetails;
  final ITSupportDetails? itSupportDetails;
  final SchoolSecretaryDetails? schoolSecretaryDetails;
  final DirectorDetails? directorDetails;
  final MaintenanceStaffDetails? maintenanceStaffDetails;
  final DriverDetails? driverDetails;
  final SecurityGuardDetails? securityGuardDetails;

  // Constructor
  SchoolStaff({
    // Identification and Personal Information
    required this.uid,
    required this.name,
    required this.dob,
    required this.gender,
    required this.nationality,
    required this.religion,
    required this.category,
    required this.bloodGroup,
    required this.height,
    required this.maritalStatus,
    required this.profileDescription,

    // Contact Information
    required this.address,
    required this.pincode,
    required this.email,
    required this.phoneNumber,
    required this.emergencyContact,

    // Employment Details
    required this.dateOfJoining,
    required this.isActive,
    required this.accountStatus,
    required this.modeOfTransport,

    // Educational and Professional Background
    required this.educationalQualification,
    required this.universityOrCollege,
    required this.experience,
    required this.certifications,

    // Account and Authentication
    required this.password,
    required this.lastLogin,
    required this.createdAt,

    // Social Metrics
    required this.following,
    required this.followers,
    required this.posts,

    // Languages
    required this.languagesSpoken,

    // Profile Picture
    required this.profilePictureUrl,

    // Attendance Tracking
    required this.presentDays,
    required this.absentDays,

    // Performance Metrics
    required this.performanceRating,
    required this.points,

    // Role(s) in the School
    required this.roles,

    // Specific Role Details (Optional)
    this.principalDetails,
    this.vicePrincipalDetails,
    this.teacherDetails,
    this.departmentHeadDetails,
    this.guidanceCounselorDetails,
    this.schoolAdministratorDetails,
    this.librarianDetails,
    this.schoolNurseDetails,
    this.sportsCoachDetails,
    this.specialEducationTeacherDetails,
    this.itSupportDetails,
    this.schoolSecretaryDetails,
    this.directorDetails,
    this.maintenanceStaffDetails,
    this.driverDetails,
    this.securityGuardDetails,
  });
}
class PrincipalDetails {
  final String leadershipTraining; // Specific training related to leadership

  PrincipalDetails({
    required this.leadershipTraining,
  });
}

class VicePrincipalDetails {
  final String areaOfExpertise; // Vice principal's specialization area

  VicePrincipalDetails({
    required this.areaOfExpertise,
  });
}

class TeacherDetails {
  final List<String> subjects; // Subjects taught by the teacher
  final String department; // Teacher's department

  TeacherDetails({
    required this.subjects,
    required this.department,
  });
}

class DepartmentHeadDetails {
  final String department;
  final int yearsAsHead; // Years as department head

  DepartmentHeadDetails({
    required this.department,
    required this.yearsAsHead,
  });
}

class GuidanceCounselorDetails {
  final List<String> areasOfSpecialization; // Counseling expertise areas
  final int numberOfCasesHandled; // Total cases handled by counselor

  GuidanceCounselorDetails({
    required this.areasOfSpecialization,
    required this.numberOfCasesHandled,
  });
}

class SchoolAdministratorDetails {
  final String departmentManaged; // Department overseen by the administrator

  SchoolAdministratorDetails({
    required this.departmentManaged,
  });
}

class LibrarianDetails {
  final List<String> genresSpecialized; // Genres or areas specialized in

  LibrarianDetails({
    required this.genresSpecialized,
  });
}

class SchoolNurseDetails {
  final String medicalQualification; // Nurse’s specific qualification

  SchoolNurseDetails({
    required this.medicalQualification,
  });
}

class SportsCoachDetails {
  final List<String> sportsCoached; // Sports coached by the individual

  SportsCoachDetails({
    required this.sportsCoached,
  });
}

class SpecialEducationTeacherDetails {
  final String areaOfSpecialEducation; // Area of special education expertise
  final List<String> disabilitiesSupported; // Disabilities the teacher is trained to support

  SpecialEducationTeacherDetails({
    required this.areaOfSpecialEducation,
    required this.disabilitiesSupported,
  });
}

class ITSupportDetails {
  final List<String> technicalSkills; // Skills specific to IT support

  ITSupportDetails({
    required this.technicalSkills,
  });
}

class SchoolSecretaryDetails {
  final List<String> departmentsAssisted; // Departments assisted by the secretary

  SchoolSecretaryDetails({
    required this.departmentsAssisted,
  });
}

class DirectorDetails {
  final List<String> schoolsManaged; // List of schools managed by the director
  final int yearsInManagement; // Years in school management roles

  DirectorDetails({
    required this.schoolsManaged,
    required this.yearsInManagement,
  });
}

class MaintenanceStaffDetails {
  final List<String> responsibilities; // Specific tasks and areas handled by staff

  MaintenanceStaffDetails({
    required this.responsibilities,
  });
}

class DriverDetails {
  final String licenseNumber; // Driver's license number
  final List<String> routesAssigned; // Routes assigned to the driver

  DriverDetails({
    required this.licenseNumber,
    required this.routesAssigned,
  });
}

class SecurityGuardDetails {
  final String assignedArea; // Area of the school the guard is responsible for

  SecurityGuardDetails({
    required this.assignedArea,
  });
}
