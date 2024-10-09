import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:my_school_app/common/widgets/elevated_button.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../student/result/create_result_format.dart';

class MyResult extends StatefulWidget {
  const MyResult({Key? key}) : super(key: key);

  @override
  State<MyResult> createState() => _MyResultState();
}

class _MyResultState extends State<MyResult> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  late RxList<SubjectFormat> subjectsFormat = <SubjectFormat>[].obs;
  late RxList<StudentResult> studentResults = <StudentResult>[].obs;

  @override
  void initState() {
    super.initState();
    fetchStudentsAndSubjects();
    fetchStudents();
  }

  Future<void> fetchStudentsAndSubjects() async {
    subjectsFormat.assignAll(await fetchExamFormatsFromFirebase(
        'SCH0000000001', '1', 'Half Yearly'));
  }

  Future<List<SubjectFormat>> fetchExamFormatsFromFirebase(
      String schoolId, String className, String examName) async {
    try {
      // Get a reference to the Firestore collection
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('examFormats')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .where('examName', isEqualTo: examName)
          .get();

      // Check if any documents were found
      if (querySnapshot.docs.isNotEmpty) {
        // Extract data from the first document (assuming there's only one)
        DocumentSnapshot documentSnapshot = querySnapshot.docs.first;

        // Parse the data from the document
        List<dynamic> subjectFormatsData =
            (documentSnapshot.data() as Map<String, dynamic>)['subjectFormats'];
        List<SubjectFormat> subjectFormats =
            subjectFormatsData.map((subjectFormatData) {
          return SubjectFormat(
            subjectName: subjectFormatData['subjectName'] as String,
            marks: subjectFormatData['marks'] as String,
            parameters: (subjectFormatData['parameters'] as List<dynamic>)
                .map((parameterData) {
              return Parameter(
                parameterName: parameterData['parameterName'] as String,
                marks: parameterData['marks'] as String,
              );
            }).toList(),
          );
        }).toList();

        return subjectFormats;
      } else {
        print('No SubjectFormats documents found.');
        return [];
      }
    } catch (e) {
      print('Failed to fetch SubjectFormats data from Firebase: $e');
      return [];
    }
  }

  Future<void> fetchStudents() async {
    try {
      List<Student> students =
          await getStudentsOfClass('SCH0000000001', '1', 'A');
      studentResults.value = students.map((student) {
        double totalMarks=0;
        Map<String, SubjectResult> subjectResults = {};
        for (var subject in subjectsFormat) {
          Map<String, dynamic> additionalParameters = {};
          for (var parameter in subject.parameters) {
            additionalParameters[parameter.parameterName] = parameter.marks;
            totalMarks += double.parse(parameter.marks);
          }
          subjectResults[subject.subjectName] =
              SubjectResult(additionalParameters);
        }
        return StudentResult(
            student.name, subjectResults, student.rollNo, student.id,totalMarks.toString());
      }).toList();

      // Print all student results
      // studentResults.forEach((studentResult) {
      //   print('Student: ${studentResult.studentName}');
      //   studentResult.subjects.forEach((subjectName, subjectResult) {
      //     print('Subject: $subjectName');
      //     subjectResult.additionalParameters.forEach((parameterName, parameterValue) {
      //       print('$parameterName: $parameterValue');
      //     });
      //   });
      //   print('\n');
      // });
    } catch (e) {
      print('Error fetching students: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Result'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() => DataTable(
                      columnSpacing: 24,
                      dividerThickness: 0,
                      columns: _buildDataColumns(),
                      rows: _buildDataRows(),
                    )),
              ),
              SizedBox(height: SchoolSizes.lg),
              SchoolElevatedButton(
                  text: 'Create Result',
                  onPressed: () {
                    uploadStudentResultsToFirebase();
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<void> uploadStudentResultsToFirebase() async {
    try {
      SchoolHelperFunctions.showLoadingOverlay();
      // Iterate through each student result
      for (var studentResult in studentResults) {
        // Check if the document exists for this student
        QuerySnapshot querySnapshot = await _firestore
            .collection('studentResults')
            .where('rollNo', isEqualTo: studentResult.rollNo)
            .where('uid', isEqualTo: studentResult.id)
            .where('examName', isEqualTo: 'Half Yearly')
            .limit(1)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          // Document exists, update the existing document
          DocumentSnapshot documentSnapshot = querySnapshot.docs.first;
          await documentSnapshot.reference.update({
            'subjects': _prepareSubjectsData(studentResult),
          });
        } else {
          // Document doesn't exist, create a new document
          Map<String, dynamic> data = {
            'studentName': studentResult.studentName,
            'rollNo': studentResult.rollNo,
            'uid': studentResult.id,
            'subjects': _prepareSubjectsData(studentResult),
            'examName': 'Half Yearly',
            'class': '1',
            'totalMarks':studentResult.total
          };
          await _firestore.collection('studentResults').add(data);
        }
      }
      Get.back();
      print('Student results uploaded successfully.');
    } catch (e) {
      print('Error uploading student results: $e');
      Get.back();
    }
  }

  Map<String, dynamic> _prepareSubjectsData(StudentResult studentResult) {
    Map<String, dynamic> subjectsData = {};

    for (var subjectName in studentResult.subjects.keys) {
      Map<String, dynamic> subjectData = {
        'subjectName': subjectName,
        'parameters': {}
      };

      for (var parameterName
          in studentResult.subjects[subjectName]!.additionalParameters.keys) {
        subjectData['parameters'][parameterName] = studentResult
            .subjects[subjectName]!.additionalParameters[parameterName];
      }

      subjectsData[subjectName] = subjectData;
    }

    return subjectsData;
  }

  List<DataColumn> _buildDataColumns() {
    List<DataColumn> columns = [
      DataColumn(
          label: Text('Roll No',
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 15))),
      DataColumn(
          label: Text('Student Name',
              style: Theme.of(Get.context!)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontSize: 15))),
    ];
    for (var subject in subjectsFormat) {
      for (var parameter in subject.parameters) {
        columns.add(DataColumn(
          label: Column(
            children: [
              Text(
                subject.subjectName,
                style: Theme.of(Get.context!)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontSize: 15),
              ),
              Text('${parameter.parameterName} (${parameter.marks})',
                  style: Theme.of(Get.context!)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontSize: 15)),
            ],
          ),
        ));
      }
    }
    columns.add(DataColumn(
        label: Text('Total',
            style: Theme.of(Get.context!)
                .textTheme
                .titleLarge
                ?.copyWith(fontSize: 15))),);
    return columns;
  }

  List<DataRow> _buildDataRows() {
    return studentResults.map((studentResult) {
      return DataRow(
        cells: <DataCell>[
          DataCell(Center(child: Text(studentResult.rollNo))),
          DataCell(Text(studentResult.studentName)),
          ...subjectsFormat.expand((subject) {
            return subject.parameters.map((parameter) {
              final value = studentResult.subjects[subject.subjectName]
                      ?.additionalParameters[parameter.parameterName] ??
                  '0';
              return DataCell(
                Center(
                  child: InkWell(
                    onTap: () {
                      _showEditDialog(
                          subject.subjectName,
                          parameter.parameterName,
                          parameter.marks,
                          value,
                          studentResult.studentName);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        width: 80,
                        child: Text('$value')),
                  ),
                ),
              );
            });
          }).toList(),
          DataCell(Text(studentResult.total)),

        ],
      );
    }).toList();
  }

  Future<List<Student>> getStudentsOfClass(
      String schoolId, String className, String sectionName) async {
    try {
      QuerySnapshot querySnapshot = await _firestore
          .collection('students')
          .where('schoolId', isEqualTo: schoolId)
          .where('className', isEqualTo: className)
          .where('sectionName', isEqualTo: sectionName)
          .get();
      List<Student> students = querySnapshot.docs.map((doc) {
        return Student(
            name: doc['studentName'], id: doc['uid'], rollNo: doc['rollNo']);
      }).toList();
      return students;
    } catch (e) {
      print('Error fetching students: $e');
      return [];
    }
  }

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _showEditDialog(String subjectName, String parameterName,
      String fullMarks, String initialValue, String studentName) async {
    String newValue = initialValue;
    final TextEditingController controller =
    TextEditingController(text: initialValue);
    final FocusNode focusNode = FocusNode();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Student- $studentName',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text('Subject- $subjectName $parameterName',
                    style: Theme.of(context).textTheme.headlineSmall),
              ],
            ),
          ),
          content: Form(
            key: _formKey,
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: controller,
              focusNode: focusNode,
              autofocus: true,
              onChanged: (value) {
                newValue = value;
              },
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter valid marks.';
                }
                double parsedValue = double.parse(value);
                if (parsedValue == null) {
                  return 'Please enter a valid number.';
                }
                if (parsedValue < 0 || parsedValue > double.parse(fullMarks)) {
                  return 'Please enter marks within the range 0 - ${double.parse(fullMarks)}.';
                }
                return null; // Return null if the validation is successful
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final studentResult = studentResults.firstWhere(
                        (result) => result.studentName == studentName,
                  );
                  if (studentResult != null) {
                    // Update the marks for the parameter
                    studentResult.subjects[subjectName]
                        ?.additionalParameters[parameterName] = newValue;
                    // Recalculate the total marks
                    double totalMarks = 0;
                    studentResult.subjects.forEach((subjectName, subjectResult) {
                      subjectResult?.additionalParameters.forEach((parameterName, parameterValue) {
                        totalMarks += double.parse(parameterValue.toString());
                      });
                    });
                    // Update the total marks
                    studentResult.total = totalMarks.toString();
                    // Trigger a reactivity update
                    studentResults.refresh();
                    studentResults.forEach((element) {
                      print(
                          element.subjects[0]?.additionalParameters['Theory']);
                    });
                  }
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );

    // Set cursor to the end of the text after the dialog is opened
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
  }

}

class Student {
  final String name;
  final String id;
  final String rollNo;

  Student({required this.name, required this.id, required this.rollNo});
}
