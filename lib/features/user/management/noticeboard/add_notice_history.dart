import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/helpers/helper_functions.dart';
import '../../student/noticeboard/notice.dart';

class AddNoticeHistory extends StatelessWidget {
  const AddNoticeHistory({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(SchoolSizes.lg),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('notices')
              .where('teacherId', isEqualTo: 'TEA0000000001')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final noticeDocs = snapshot.data!.docs;
              return ListView.builder(
                itemCount: noticeDocs.length,
                itemBuilder: (context, index) {
                  final notice =
                      noticeDocs[index].data() as Map<String, dynamic>?;
                  final title = notice?['title'] as String? ?? '';
                  final date = notice?['date'] as String? ?? '';
                  final time = notice?['time'] as String? ?? '';
                  final description = notice?['description'] as String? ?? '';
                  final teacherId = notice?['teacherId'] as String? ?? '';

                  final forUser = List<String>.from(
                      notice?['forUser'] as List<dynamic>? ?? []);
                  final forClass = List<String>.from(
                      notice?['forClass'] as List<dynamic>? ?? []);

                  return NoticeItem(
                    title: title,
                    date: date,
                    time: time,
                    description: description,
                    teacherName: teacherId,
                    teacherId: teacherId,
                    forUser: forUser,
                    forClass: forClass,
                    isWrite: true,
                    onDelete: () {
                      deleteNoticeFromFirebase(noticeDocs[index].id);
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> deleteNoticeFromFirebase(String docId) async {
    try {
      bool confirmDelete = await showDialog(
        context: Get.context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Deletion'),
            content: Text('Are you sure you want to delete this notice?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // No, do not delete
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Yes, delete
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );

      if (confirmDelete == true) {
        // Access Firestore instance
        SchoolHelperFunctions.showLoadingOverlay();
        FirebaseFirestore firestore = FirebaseFirestore.instance;

        // Get a reference to the document to be deleted
        DocumentReference docRef = firestore.collection('notices').doc(docId);

        // Delete the document
        await docRef.delete();

        Get.back();
        SchoolHelperFunctions.showSuccessSnackBar(
            'Notice deleted from Firebase successfully');
        print('Notice deleted from Firebase successfully');
      } else {
        print('Notice deletion canceled');
      }
    } catch (error) {
      print('Error deleting notice from Firebase: $error');
      // Handle the error appropriately, e.g., show an error message to the user
    }
  }
}
