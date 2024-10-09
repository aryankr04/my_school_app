import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/common/widgets/dropdown_form_feild.dart';
import 'package:my_school_app/common/widgets/elevated_button.dart';
import 'package:my_school_app/common/widgets/text_form_feild.dart';
import 'package:my_school_app/utils/constants/lists.dart';
import 'package:my_school_app/utils/constants/sizes.dart';
import 'package:my_school_app/utils/helpers/date_and_time.dart';
import 'package:my_school_app/common/widgets/date_picker.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

class Leave {
  String id;
  String leaveType;
  String fromDate;
  String toDate;
  String reason;
  String status;
  int requestNumber;
  String requestedOn;
  String uid;
  String schoolId; // New field
  String className; // New field
  String sectionName; // New field

  Leave({
    required this.id,
    required this.leaveType,
    required this.fromDate,
    required this.toDate,
    required this.reason,
    required this.status,
    required this.requestNumber,
    required this.requestedOn,
    required this.uid,
    required this.schoolId, // Include schoolId in constructor
    required this.className, // Include className in constructor
    required this.sectionName, // Include sectionName in constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'leaveType': leaveType,
      'fromDate': fromDate,
      'toDate': toDate,
      'reason': reason,
      'status': status,
      'requestNumber': requestNumber,
      'requestedOn': requestedOn,
      'uid': uid,
      'schoolId': schoolId, // Include schoolId in the map
      'className': className, // Include className in the map
      'sectionName': sectionName, // Include sectionName in the map
    };
  }

  factory Leave.fromMap(Object? map, String id) {
    final Map<String, dynamic> data = map as Map<String, dynamic>;

    return Leave(
      id: id,
      leaveType: data['leaveType'] as String,
      fromDate: data['fromDate'] as String,
      toDate: data['toDate'] as String,
      reason: data['reason'] as String,
      status: data['status'] as String,
      requestNumber: data['requestNumber'] as int,
      requestedOn: data['requestedOn'] as String,
      uid: data['uid'] as String,
      schoolId: data['schoolId'] as String,
      className: data['className'] as String,
      sectionName: data['sectionName'] as String,
    );
  }
}

class LeaveController extends GetxController {
  // State variables
  RxString leaveType = ''.obs;
  RxString fromDate = DateTime.now().toString().obs;
  RxString toDate = DateTime.now().toString().obs;
  TextEditingController reason = TextEditingController();

  Future<int> getNextRequestNumber(String uid) async {
    final leavesCollection = FirebaseFirestore.instance.collection('leaves');

    final querySnapshot =
        await leavesCollection.where('uid', isEqualTo: uid).get();

    // Get the maximum requestNumber among the documents
    int maxRequestNumber = 0;
    for (final doc in querySnapshot.docs) {
      final requestNumber = doc.data()['requestNumber'];
      if (requestNumber is int && requestNumber > maxRequestNumber) {
        maxRequestNumber = requestNumber;
      }
    }

    // Increment the maximum requestNumber to get the next requestNumber
    final nextRequestNumber = maxRequestNumber + 1;

    return nextRequestNumber;
  }

  Future<void> storeLeaveData() async {
    try {
      SchoolHelperFunctions.showLoadingOverlay();
      int requestNumber = await getNextRequestNumber('STU0000000001');
      print(requestNumber);
      Leave leave = Leave(
        leaveType: leaveType.value,
        fromDate: fromDate.value,
        toDate: toDate.value,
        reason: reason.text.trim(),
        status: 'Waiting',
        requestNumber: requestNumber,
        id: '', // Initialize with an empty string
        requestedOn: SchoolDateAndTimeFunction.getCurrentDate(),
        uid: 'STU0000000001',
        schoolId: 'SCH0000000001',
        className: '1',
        sectionName: 'A',
      );
      CollectionReference leaves =
          FirebaseFirestore.instance.collection('leaves');
      DocumentReference docRef = leaves.doc();
      String documentId = docRef.id;
      leave.id = documentId;
      await docRef.set(leave.toMap());
      print('Leave data stored successfully with ID: $documentId');
      Get.back();
      SchoolHelperFunctions.showSuccessSnackBar(
          'Request for Leave is sent successfully');
    } catch (e) {
      print('Error storing leave data: $e');
      Get.back();
      SchoolHelperFunctions.showErrorSnackBar('Error storing leave data: $e');
    }
  }
}

class ApplyForLeave extends StatefulWidget {
  const ApplyForLeave({super.key});

  @override
  State<ApplyForLeave> createState() => _ApplyForLeaveState();
}

class _ApplyForLeaveState extends State<ApplyForLeave> {
  final LeaveController leaveController = Get.put(LeaveController());



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(SchoolSizes.lg),
          child: Column(
            children: [
              //SizedBox(height: SchoolSizes.md,),
              // Align(
              //     alignment: Alignment.centerLeft,
              //     child: Text(
              //       'Apply for a Leave',
              //       style: Theme.of(context).textTheme.headlineSmall,
              //     )),
              // SizedBox(
              //   height: SchoolSizes.lg,
              // ),
              SchoolDropdownFormField(
                items: SchoolLists.leaveList,
                labelText: 'Select Leave Type',
                onSelected: (selectedItem) {
                  leaveController.leaveType.value = selectedItem;
                },
              ),
              const SizedBox(
                height: SchoolSizes.lg,
              ),
              DatePickerField(
                initialDate: null,
                firstDate: DateTime.now(),
                labelText: 'From (Start Date)',
                lastDate: DateTime(DateTime.now().year + 1),
                onDateChanged: (date) {
                  leaveController.fromDate.value = SchoolDateAndTimeFunction.getFormattedDate(date);
                  print(date);
                },
              ),
              const SizedBox(
                height: SchoolSizes.lg,
              ),
              DatePickerField(
                initialDate: null,
                firstDate: DateTime.now(),
                labelText: 'From (Start Date)',
                lastDate: DateTime(DateTime.now().year + 1),
                onDateChanged: (date) {
                  print(SchoolDateAndTimeFunction.getFormattedDate(date));
                  leaveController.toDate.value = SchoolDateAndTimeFunction.getFormattedDate(date);
                },
              ),
              const SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolTextFormField(
                labelText: 'Reason For Leave',
                maxLines: 6,
                controller: leaveController.reason,
              ),
              const SizedBox(
                height: SchoolSizes.lg,
              ),
              SchoolElevatedButton(
                text: 'Apply',
                onPressed: () {
                  // Call the function to apply leave from the controller
                  leaveController.storeLeaveData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
