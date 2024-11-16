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
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
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
  static const List<String> favoriteSubjects = [
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
  static const List<String> favoriteActivities = [
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
    'School Transport',
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
  static const List<String> educationDegrees = [
    // Basic and Intermediate Education
    "10th Grade / Secondary School Certificate (SSC)",
    "12th Grade / Higher Secondary Certificate (HSC) / Intermediate",

    // General Education Levels
    "High School Diploma",
    "General Educational Development (GED)",
    "Vocational Training",

    // Undergraduate Degrees
    "Bachelor of Technology (B.Tech)",
    "Bachelor of Medicine, Bachelor of Surgery (MBBS)",
    "Bachelor of Business Administration (BBA)",
    "Bachelor of Computer Applications (BCA)",
    "Bachelor of Science (B.Sc)",
    "Bachelor of Arts (BA)",
    "Bachelor of Commerce (B.Com)",
    "Bachelor of Pharmacy (B.Pharm)",
    "Bachelor of Education (B.Ed)",
    "Bachelor of Fine Arts (BFA)",
    "Bachelor of Architecture (B.Arch)",
    "Bachelor of Law (LLB)",
    "Bachelor of Dental Surgery (BDS)",
    "Bachelor of Veterinary Science (B.V.Sc)",
    "Bachelor of Nursing (B.Sc Nursing)",
    "Bachelor of Design (B.Des)",
    "Bachelor of Hotel Management (BHM)",
    "Bachelor of Social Work (BSW)",
    "Bachelor of Physiotherapy (BPT)",
    "Bachelor of Management Studies (BMS)",

    // Postgraduate Degrees
    "Master of Business Administration (MBA)",
    "Master of Technology (M.Tech)",
    "Master of Science (M.Sc)",
    "Master of Computer Applications (MCA)",
    "Master of Arts (MA)",
    "Master of Commerce (M.Com)",
    "Master of Education (M.Ed)",
    "Master of Social Work (MSW)",
    "Master of Law (LLM)",
    "Master of Fine Arts (MFA)",
    "Master of Design (M.Des)",
    "Master of Pharmacy (M.Pharm)",
    "Master of Public Health (MPH)",
    "Master of Hotel Management (MHM)",

    // Doctoral Degrees
    "Doctor of Philosophy (Ph.D.)",
    "Doctor of Medicine (MD)",
    "Doctor of Dental Surgery (DDS)",
    "Doctor of Veterinary Medicine (DVM)",
    "Doctor of Education (Ed.D)",
    "Doctor of Science (D.Sc)",

    // Professional Degrees
    "Chartered Accountancy (CA)",
    "Certified Public Accountant (CPA)",
    "Company Secretary (CS)",
    "Certified Financial Analyst (CFA)",
    "Project Management Professional (PMP)",

    // Diplomas and Certifications
    "Diploma in Engineering",
    "Diploma in Computer Science",
    "Diploma in Business Management",
    "Certificate in Data Science",
    "Certificate in Digital Marketing",
    "Certificate in Project Management",
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

  static const List<Map<String, List<String>>> schoolStaffSkills = [
    {
      "Principal": [
        "Leadership",
        "Decision Making",
        "Communication",
        "Conflict Resolution",
        "Strategic Planning",
      ],
    },
    {
      "Vice Principal/Assistant Principal": [
        "Administration",
        "Disciplinary Management",
        "Team Collaboration",
        "Problem Solving",
        "Organizational Skills",
      ],
    },
    {
      "Director": [
        "Policy Development",
        "Strategic Vision",
        "Budgeting",
        "School Operations",
        "Stakeholder Communication",
      ],
    },
    {
      "School Administrator": [
        "Operational Management",
        "Record Keeping",
        "Event Coordination",
        "Parent Communication",
        "Scheduling",
      ],
    },
    {
      "Teacher": [
        "Subject Knowledge",
        "Classroom Management",
        "Lesson Planning",
        "Student Assessment",
        "Communication",
      ],
    },
    {
      "Special Education Teacher": [
        "Individualized Education Plans",
        "Behavior Management",
        "Patience",
        "Adaptability",
        "Collaboration",
      ],
    },
    {
      "Department Head": [
        "Leadership",
        "Curriculum Development",
        "Mentorship",
        "Team Building",
        "Performance Review",
      ],
    },
    {
      "Guidance Counselor": [
        "Counseling",
        "Career Guidance",
        "Emotional Support",
        "Interpersonal Skills",
        "Crisis Management",
      ],
    },
    {
      "School Nurse": [
        "First Aid",
        "Medical Knowledge",
        "Patient Care",
        "Health Education",
        "Record Keeping",
      ],
    },
    {
      "Sports Coach": [
        "Physical Training",
        "Team Leadership",
        "Motivational Skills",
        "Sports Strategy",
        "Disciplinary Skills",
      ],
    },
    {
      "Librarian": [
        "Information Management",
        "Research Skills",
        "Literacy Promotion",
        "Organizational Skills",
        "Technology Skills",
      ],
    },
    {
      "School Secretary": [
        "Clerical Skills",
        "Scheduling",
        "Communication",
        "Multitasking",
        "Time Management",
      ],
    },
    {
      "IT Support/Technician": [
        "Technical Troubleshooting",
        "Network Management",
        "Hardware Maintenance",
        "Software Installation",
        "Cybersecurity Awareness",
      ],
    },
    {
      "Maintenance Staff": [
        "Facility Maintenance",
        "Basic Repair Skills",
        "Cleanliness Standards",
        "Safety Awareness",
        "Reliability",
      ],
    },
    {
      "Security Guard": [
        "Surveillance",
        "Emergency Response",
        "Situational Awareness",
        "Patience",
        "Physical Fitness",
      ],
    },
    {
      "Driver": [
        "Defensive Driving",
        "Safety Awareness",
        "Time Management",
        "Vehicle Maintenance",
        "Communication",
      ],
    },
  ];

  static const List<String> schoolRoles = [
    // Leadership and Administration
    "Principal",
    "Vice Principal/Assistant Principal",
    "Director",
    "School Administrator",

    // Academic and Teaching Staff
    "Teacher",
    "Special Education Teacher",
    "Department Head",
    "Guidance Counselor",

    // Student Support Services
    "Guidance Counselor",
    "School Nurse",
    "Sports Coach",
    "Librarian",

    // Operations and Technical Support
    "School Secretary",
    "IT Support/Technician",
    "Maintenance Staff",
    "Security Guard",

    // Transportation
    "Driver",
  ];
// Leadership and Administration
  static const List<String> leadershipAndAdministration = [
    "Principal",
    "Vice Principal/Assistant Principal",
    "Director",
    "School Administrator",
  ];

  // Academic and Teaching Staff
  static const List<String> academicAndTeachingStaff = [
    "Teacher",
    "Special Education Teacher",
    "Department Head",
    "Guidance Counselor",
  ];

  // Student Support Services
  static const List<String> studentSupportServices = [
    "Guidance Counselor",
    "School Nurse",
    "Sports Coach",
    "Librarian",
  ];

  // Operations and Technical Support
  static const List<String> operationsAndTechnicalSupport = [
    "School Secretary",
    "IT Support/Technician",
    "Maintenance Staff",
    "Security Guard",
    "Driver",
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
  static const List<String> nationality = [
    "Indian",
    "Afghan",
    "Albanian",
    "Algerian",
    "American",
    "Andorran",
    "Angolan",
    "Argentinian",
    "Armenian",
    "Australian",
    "Austrian",
    "Azerbaijani",
    "Bahamian",
    "Bahraini",
    "Bangladeshi",
    "Barbadian",
    "Belarusian",
    "Belgian",
    "Belizean",
    "Beninese",
    "Bhutanese",
    "Bolivian",
    "Bosnian",
    "Botswanan",
    "Brazilian",
    "British",
    "Bruneian",
    "Bulgarian",
    "Burkinabe",
    "Burmese",
    "Burundian",
    "Cambodian",
    "Cameroonian",
    "Canadian",
    "Cape Verdean",
    "Central African",
    "Chadian",
    "Chilean",
    "Chinese",
    "Colombian",
    "Comoran",
    "Congolese",
    "Costa Rican",
    "Croatian",
    "Cuban",
    "Cypriot",
    "Czech",
    "Danish",
    "Djiboutian",
    "Dominican",
    "Dutch",
    "East Timorese",
    "Ecuadorian",
    "Egyptian",
    "Emirati",
    "Equatorial Guinean",
    "Eritrean",
    "Estonian",
    "Ethiopian",
    "Fijian",
    "Finnish",
    "French",
    "Gabonese",
    "Gambian",
    "Georgian",
    "German",
    "Ghanaian",
    "Greek",
    "Grenadian",
    "Guatemalan",
    "Guinean",
    "Guyanese",
    "Haitian",
    "Honduran",
    "Hungarian",
    "Icelandic",
    "Indonesian",
    "Iranian",
    "Iraqi",
    "Irish",
    "Israeli",
    "Italian",
    "Ivorian",
    "Jamaican",
    "Japanese",
    "Jordanian",
    "Kazakh",
    "Kenyan",
    "Kiribati",
    "Kuwaiti",
    "Kyrgyz",
    "Laotian",
    "Latvian",
    "Lebanese",
    "Liberian",
    "Libyan",
    "Liechtensteiner",
    "Lithuanian",
    "Luxembourger",
    "Macedonian",
    "Malagasy",
    "Malawian",
    "Malaysian",
    "Maldivian",
    "Malian",
    "Maltese",
    "Marshallese",
    "Mauritanian",
    "Mauritian",
    "Mexican",
    "Micronesian",
    "Moldovan",
    "Monacan",
    "Mongolian",
    "Montenegrin",
    "Moroccan",
    "Mozambican",
    "Namibian",
    "Nauruan",
    "Nepalese",
    "New Zealander",
    "Nicaraguan",
    "Nigerian",
    "Nigerien",
    "North Korean",
    "Norwegian",
    "Omani",
    "Pakistani",
    "Palauan",
    "Palestinian",
    "Panamanian",
    "Papua New Guinean",
    "Paraguayan",
    "Peruvian",
    "Philippine",
    "Polish",
    "Portuguese",
    "Qatari",
    "Romanian",
    "Russian",
    "Rwandan",
    "Saint Lucian",
    "Salvadoran",
    "Samoan",
    "San Marinese",
    "Saudi Arabian",
    "Senegalese",
    "Serbian",
    "Seychellois",
    "Sierra Leonean",
    "Singaporean",
    "Slovak",
    "Slovenian",
    "Solomon Islander",
    "Somali",
    "South African",
    "South Korean",
    "Spanish",
    "Sri Lankan",
    "Sudanese",
    "Surinamese",
    "Swazi",
    "Swedish",
    "Swiss",
    "Syrian",
    "Taiwanese",
    "Tajik",
    "Tanzanian",
    "Thai",
    "Togolese",
    "Tongan",
    "Trinidadian",
    "Tunisian",
    "Turkish",
    "Turkmen",
    "Tuvaluan",
    "Ugandan",
    "Ukrainian",
    "Uruguayan",
    "Uzbek",
    "Vanuatuan",
    "Venezuelan",
    "Vietnamese",
    "Yemeni",
    "Zambian",
    "Zimbabwean",
  ];
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
