import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../../utils/helpers/helper_functions.dart';

class FirebaseForSchool {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<DocumentReference?> getSchoolReference(String schoolId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance
          .collection('schools')
          .where('schoolId', isEqualTo: schoolId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.reference;
      } else {
        SchoolHelperFunctions.showAlertSnackBar(
          'Selected school not found in the database.',
        );
        return null;
      }
    } catch (e) {
      print('Error fetching school reference: $e');
      return null;
    }
  }









  //Fetch Schools
  Future<List<Map<String, dynamic>>> fetchSchools(String query) async {
    try {
      final result = await FirebaseFirestore.instance
          .collection('schools')
          .where(
        'schoolName',
        isGreaterThanOrEqualTo: query,
        isLessThan: query + 'z', // Assuming your school names are strings
      )
          .get();

      final List<Map<String, dynamic>> tempList =
      result.docs.map((DocumentSnapshot<Map<String, dynamic>> e) {
        return {
          'schoolName': e['schoolName'] ?? '',
          'schoolId': e['schoolId'] ?? '', // Add 'schoolId' to the map
        };
      }).toList();

      return tempList;
    } catch (e) {
      print('Error fetching schools: $e');
      return [];
    }
  }



  Future<String?> generateNewIdWithPrefix(
      String prefix, String collection) async {
    try {
      final QuerySnapshot querySnapshot =
      await FirebaseFirestore.instance.collection(collection).get();

      if (querySnapshot.docs.isEmpty) {
        return '$prefix${'0000000001'}';
      }

      String latestId = querySnapshot.docs.last.id;
      int latestNumericPart =
          int.tryParse(latestId.substring(prefix.length)) ?? 0;
      int newNumericPart = latestNumericPart + 1;
      return '$prefix${newNumericPart.toString().padLeft(10, '0')}';
    } catch (e) {
      print('Error generating new ID with prefix: $e');
      return null;
    }
  }


}
