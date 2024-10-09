import 'package:cloud_firestore/cloud_firestore.dart';

class SchoolLists {
  static const List<String> usersList = [
    'Student'
    'Teacher'
    'principal'
    'Director'
    'Management'
    'Staff'
    'Driver'
    'Admin'
  ];
  static const List<String> eventType = [
    'Start',
    'Class',
    'Break',
    'Assembly',
    'Departure',
  ];

  static const List<String> dayList = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
  ];
  static const List<String> classList = [
    'LKG',
    'UKG',
    'Nursery',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];

  static const List<String> heightFtList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  static const List<String> heightInchList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12'
  ];

  static const List<String> sectionList = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L'
  ];
  static const List<String> examList = [
    'FA1',
    'Half Yearly',
    'FA2',
    'Final Exam'
  ];
  static const List<String> leaveList = [
    'Sick Leave',
    'Half Day Leave',
    'One Day Leave',
    'Medical Leave',
    'Marriage Leave',
    'Vacation Leave',
  ];
  static const List<String> subjectList = [
    'Science',
    'Maths',
    'Social Science',
    'Computer',
    'Hindi',
    // 'English',
    // 'Commerce',
    // 'General Knowledge',
    // 'Physics',
    // 'Chemistry',
    // 'Biology',
    // 'Geography',
    // "Economics",
    // 'Political Science',
    // 'History',
    // 'English Grammar'
  ];

  static const List<String> religionList = [
    'Hindu',
    'Muslim',
    'Christian',
    'Buddhist',
    'Jain',
  ];
  static const List<String> casteList = [
    'General',
    'OBC',
    'ST/SC',
  ];
  static const List<String> genderList = ['Male', 'Female', 'Other'];
  static const List<String> bloodGroupList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'O+',
    'O-',
    'AB+',
    'AB-'
  ];
  static const List<String> transportationList = [
    'By Foot',
    'By Cycle',
    'By School transportation'
  ];

  static const List<String> positionList = ['Security Guard', 'Peon', 'Other'];
  static const List<String> schoolBoardList = [
    'CBSE',
    'ICSE',
    'IB',
    'NIOS',
    'CIE',
    'State Board'
  ];
  static const List<String> schoolTypeList = [
    'Private',
    'Government Aided Private School',
    'Government'
  ];
  static const List<String> schoolingSystemList = [
    'Play School',
    'Kindergarten (LKG - UKG)',
    'Primary School (LKG - 5th Class) ',
    'Middle School (LKG - 8th Class)',
    'Secondary School (LKG - 10th Class)',
    'Senior Secondary (LKG - 12th Class)',
    'Undergraduate'
  ];

  static const List<String> extraCurricularActivitiesList = [
    'Arts and Creativity',
    'Sports',
    'Technology and Robotics',
    'Language and Literature',
    'Entrepreneurship',
    'Cultural and Language Clubs'
  ];
  //
  static Future<List<String>> fetchSchoolNames() async {
    try {
      // Get a reference to the Firestore database
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      // Get the documents within the 'Schools' collection
      QuerySnapshot querySnapshot = await firestore.collection('Schools').get();

      // Extract the names of all schools
      List<String> names = querySnapshot.docs
          .map((doc) =>
              (doc.data() as Map<String, dynamic>)['schoolName'] as String)
          .toList();

      // Return the list
      return names;
    } catch (e) {
      print('Error getting school names: $e');
      // Rethrow the exception to indicate the failure
      throw e;
    }
  }
}
