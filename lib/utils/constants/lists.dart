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
  static const List<String> schoolHouses = [
    "Red House",
    "Blue House",
    "Green House",
    "Yellow House",
    "Alpha House",
    "Beta House",
    "Gamma House",
    "Delta House",
    "Eagle House",
    "Lion House",
    "Tiger House",
    "Falcon House",
    "Phoenix House",
    "Dragon House",
    "Victory House",
    "Unity House",
    "Courage House",
    "Wisdom House",
    "Valor House",
    "Harmony House",
    "Integrity House",
    "Perseverance House",
    "Liberty House",
    "Justice House",
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
    '10',
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
  ];
// Languages Spoken
  static const List<String> languagesSpoken = [
    'English',
    'Hindi',
    'Spanish',
    'French',
    'German',
    'Mandarin',
    'Other',
  ];

// Favorite Subjects
  static  const List<String> favoriteSubjects = [
    'Mathematics',
    'Science',
    'English Literature',
    'History',
    'Art',
    'Physical Education',
  ];

// Favorite Sports
  static const List<String> favoriteSports = [
    'Soccer',
    'Basketball',
    'Cricket',
    'Tennis',
    'Swimming',
    'Gymnastics',
  ];

// Favorite Activities
  static  const List<String> favoriteActivities = [
    'Reading',
    'Writing',
    'Playing an instrument',
    'Drawing or Painting',
    'Hiking or Outdoor Activities',
  ];

// Career Aspirations
  static const List<String> careerAspirations = [
    'Doctor',
    'Engineer',
    'Teacher',
    'Scientist',
    'Artist',
    'Athlete',
    'Businessperson',
    'Other',
  ];



 static const List<String> schoolTransportModes = [
    'School Bus',
    'Private Car',
    'Bicycle',
    'Walking',
    'Van/Carpool',
    'Public Bus',
    'Auto-rickshaw',
    'Motorcycle/Scooter',
    'Metro/Subway',
    'Taxi/Cab',
    'Parent Drop-off',
    // Add more modes if needed
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
  //Visio Options
  static const List<String> visionConditionList = [
    'No vision correction',
    'Wears glasses',
    'Wears contact lenses',
    'Uses reading glasses',
    // Add more options as needed
  ];
  // Medical Conditions
  static const List<String> medicalConditions = [
    'None',
    'Asthma',
    'Diabetes',
    'Epilepsy',
    'ADHD',
    'Autism Spectrum Disorder',
    'Heart Conditions',
    'Other Chronic Conditions',
  ];

  static const List<String> yesNoList = ['Yes', 'No'];
  // Religion
  static const List<String> religions = [
    'Hinduism',
    'Islam',
    'Christianity',
    'Buddhism',
    'Sikhism',
    'Jainism',
    'Judaism',
    'Atheism',
    'Other',
  ];
 static const List<String> indianStatesAndUTs = [
   "Andaman and Nicobar Islands",
   "Andhra Pradesh",
   "Arunachal Pradesh",
   "Assam",
   "Bihar",
   "Chandigarh",
   "Chhattisgarh",
   "Dadra and Nagar Haveli and Daman and Diu",
   "Delhi",
   "Goa",
   "Gujarat",
   "Haryana",
   "Himachal Pradesh",
   "Jammu and Kashmir",
   "Jharkhand",
   "Karnataka",
   "Kerala",
   "Ladakh",
   "Lakshadweep",
   "Madhya Pradesh",
   "Maharashtra",
   "Manipur",
   "Meghalaya",
   "Mizoram",
   "Nagaland",
   "Odisha",
   "Puducherry",
   "Punjab",
   "Rajasthan",
   "Sikkim",
   "Tamil Nadu",
   "Telangana",
   "Tripura",
   "Uttar Pradesh",
   "Uttarakhand",
   "West Bengal"
 ];


  static const List<String> categoryList = ['General', 'OBC', 'ST/SC', 'EWS'];
  static const List<String> genderList = [
    'Male',
    'Female',
    'Prefer not to say'
  ];
  // Blood Group
  static const List<String> bloodGroupList = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
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
 static const List<String> hobbies = [
    'Reading',
    'Writing',
    'Painting',
    'Drawing',
    'Photography',
    'Gardening',
    'Cooking',
    'Baking',
    'Traveling',
    'Hiking',
    'Cycling',
    'Swimming',
    'Fishing',
    'Dancing',
    'Singing',
    'Playing musical instruments',
    'Knitting',
    'Sewing',
    'Woodworking',
    'Coding',
    'Gaming',
    'Yoga',
    'Meditation',
    'Volunteering',
    'Bird watching',
    'Collecting (stamps, coins, etc.)',
    'Scrapbooking',
    'Pottery',
    'Running',
    'Skating',
    // Add more hobbies if needed
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
