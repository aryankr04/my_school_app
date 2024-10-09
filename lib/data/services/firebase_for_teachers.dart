import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseForTeacher{
  final FirebaseFirestore firestore = FirebaseFirestore.instance;


  //Fetch Teachers Id & Name without Class
  Future<List<Map<String, dynamic>>> fetchTeachersWithoutClass(String schoolId) async {
    try {
      final querySnapshot = await firestore
          .collection('teachers')
          .where('schoolId', isEqualTo: schoolId)
          .where('isClassTeacher', isEqualTo: false)

          .get();

      final List<Map<String, dynamic >> teachers = querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> e) {
        return {
          'teacherName': e['teacherName'] ?? '',
          'uid': e['uid']??'',
        };
      })
          .toList();

      return teachers;
    } catch (e) {
      print('Error fetching teachers: $e');
      return [];
    }
  }

  //Fetch Teachers Id & Name without Class
  Future<List<Map<String, dynamic>>> fetchTeachers(String schoolId) async {
    try {
      final querySnapshot = await firestore
          .collection('teachers')
          .where('schoolId', isEqualTo: schoolId)
          .get();

      final List<Map<String, dynamic >> teachers = querySnapshot.docs
          .map((DocumentSnapshot<Map<String, dynamic>> e) {
        return {
          'teacherName': e['teacherName'] ?? '',
          'uid': e['uid']??'',
        };
      })
          .toList();

      return teachers;
    } catch (e) {
      print('Error fetching teachers: $e');
      return [];
    }
  }
}