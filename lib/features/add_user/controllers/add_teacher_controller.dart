// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../../../common/widgets/option_list.dart';
// import '../../../data/services/firebase_for_school.dart';
// import '../../../utils/constants/dynamic_colors.dart';
// import '../../../utils/constants/lists.dart';
// import '../../../utils/constants/sizes.dart';
// import '../../../utils/helpers/firebase_helper_function.dart';
// import '../../../utils/helpers/helper_functions.dart';
// import '../models/teacher.dart';
//
// class AddTeacherController extends GetxController {
//   FirebaseForSchool firebaseFunction = FirebaseForSchool();
//
//   final GlobalKey<FormState> addTeacherFormKey = GlobalKey<FormState>();
//
//   TextEditingController selectedSchoolController = TextEditingController();
//   final nameController = TextEditingController();
//   final mobileNoController = TextEditingController();
//   final addressController = TextEditingController();
//   final emailController = TextEditingController();
//   final qualificationController = TextEditingController();
//   final subjectsController = TextEditingController();
//   final RxList<String> selectedSubjects = <String>[].obs;
//   final RxList<String> tags = <String>[].obs;
//   RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;
//   final dateOfBirthController = Rx<DateTime?>(null);
//
//   final selectedGender = ''.obs;
//   Rx<File?> teacherImage = Rx<File?>(null);
//
//
//   bool isFormValid() {
//     return addTeacherFormKey.currentState?.validate() ?? false;
//   }
//
//   Future<void> addTeacherToFirebase() async {
//     try {
//       if (teacherImage.value == '') {
//         SchoolHelperFunctions.showAlertSnackBar(
//           'Please select an image and school.',
//         );
//         return;
//       }
//
//       if (selectedSchoolController.text == '') {
//         SchoolHelperFunctions.showErrorSnackBar(
//           'Please select a valid School',
//         );
//       }
//
//       // if (!isFormValid()) {
//       //   SchoolHelperFunctions.showErrorSnackBar(
//       //     'Please enter valid details.',
//       //   );
//       //   return;
//       // }
//
//       SchoolHelperFunctions.showLoadingOverlay();
//
//       FirebaseFirestore firestore = FirebaseFirestore.instance;
//
//       String imageUrl = await FirebaseHelperFunction.uploadImage(
//         imageFile: teacherImage.value!,
//         imageName: 'teacher_image',
//         folder: 'teacher_images',
//       );
//
//
//       String? teacherId =
//           await firebaseFunction.generateNewIdWithPrefix('TEA', 'teachers');
//
//       Teacher teacher = Teacher(
//         uid: teacherId!,
//         schoolId: selectedSchoolController.text,
//         imageUrl: imageUrl,
//         teacherName: nameController.text,
//         dateOfBirth: dateOfBirthController.value!,
//         gender: selectedGender.value,
//         mobileNo: mobileNoController.text,
//         address: addressController.text,
//         email: emailController.text,
//         qualification: qualificationController.text,
//         subjectsTaught: selectedSubjects,
//         isClassTeacher: false,
//       );
//
//       // Convert the Teacher instance to a JSON map
//       Map<String, dynamic> teacherData = teacher.toJson();
//
//       await firestore.collection('teachers').doc(teacherId).set(teacherData);
//
//       selectedSubjects.clear();
//       subjectsController.clear();
//       Get.back();
//       SchoolHelperFunctions.showSuccessSnackBar(
//         'Teacher data added successfully!',
//       );
//     } catch (e) {
//       print('Error adding teacher data: $e');
//       SchoolHelperFunctions.showErrorSnackBar(
//         'Error adding teacher data',
//       );
//       Get.back();
//     }
//   }
//
//   Future<void> fetchSchools(String query) async {
//     try {
//       final schools = await firebaseFunction.fetchSchools(query);
//       schoolList.assignAll(schools);
//     } catch (e) {
//       print('Error fetching schools: $e');
//     }
//   }
//
//   void showSubjectDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: SchoolDynamicColors.backgroundColorWhiteDarkGrey,
//           title: const Text('Select Subjects'),
//           content: SingleChildScrollView(
//             child: OptionList(
//               options: SchoolLists.extraCurricularActivitiesList,
//               onItemSelected: (selectedItem) {
//                 subjectsController.text = selectedItem!;
//               },
//             ),
//           ),
//           actions: [
//             ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                   fixedSize: const Size(double.infinity, 50)),
//               onPressed: () {
//                 // Add your filter logic here
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text(
//                 'Apply',
//                 style: TextStyle(fontSize: 13),
//               ),
//             ),
//             const SizedBox(
//               height: SchoolSizes.md,
//             ),
//             OutlinedButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(fontSize: 13),
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void onClose() {
//     // Dispose of text controllers
//     nameController.dispose();
//     mobileNoController.dispose();
//     addressController.dispose();
//     emailController.dispose();
//     qualificationController.dispose();
//     subjectsController.dispose();
//
//     // Dispose of Rx variables
//     selectedSubjects.close();
//     tags.close();
//     schoolList.close();
//     dateOfBirthController.close();
//     selectedGender.close();
//     teacherImage.close();
//
//     super.onClose();
//   }
// }
