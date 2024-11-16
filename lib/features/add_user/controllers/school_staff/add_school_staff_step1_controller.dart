import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/helpers/helper_functions.dart';

import '../../../../../../data/services/firebase_for_school.dart';
import '../../../../common/widgets/multi_selection_widget.dart';
import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/lists.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../user/management/noticeboard/add_notice_new.dart';

class SchoolStaffStep1FormController extends GetxController {
  FirebaseForSchool firebaseFunction = FirebaseForSchool();

  final GlobalKey<FormState> step1FormKey = GlobalKey<FormState>();

  TextEditingController schoolController = TextEditingController();
  RxList<Map<String, dynamic>> schoolList = <Map<String, dynamic>>[].obs;

  TextEditingController nameController = TextEditingController();

  Rx<DateTime?> dateOfBirth = Rx<DateTime?>(null);

  Rx<String> selectedGender = Rx<String>('');
  Rx<String> selectedNationality = Rx<String>('');
  Rx<String> selectedReligion = Rx<String>('');
  Rx<String> selectedCategory = Rx<String>('');
  Rx<String> selectedBloodGroup = Rx<String>('');
  RxString selectedHeightFt = RxString('');
  RxString selectedHeightInch = RxString('');
  Rx<String> selectedMaritalStatus = Rx<String>('');

  RxList<String> selectedLanguages = <String>[].obs;
  TextEditingController languagesController = TextEditingController();

  @override
  void onClose() {
    languagesController.dispose();
    super.onClose();
  }

  Future<void> fetchSchools(String query) async {
    try {
      final schools = await firebaseFunction.fetchSchools(query);
      schoolList.assignAll(schools);
    } catch (e) {
      print('Error fetching schools: $e');
    }
  }

  Future<void> showLanguagesSelectionDialog() async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          title: const Text('Select Languages'),
          content: Container(
            width: Get.width,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MultiSelectionWidget(
                    showSelectAll: false,
                    options: SchoolLists.languagesSpoken,
                    onSelectionChanged: (selectedItems) {
                      selectedLanguages.assignAll(selectedItems);
                    },
                    selectedItems: selectedLanguages,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  // Make the button take up the available width
                  child: InkWell(
                    onTap: () {
                      languagesController.text = selectedLanguages.join(', ');
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: SchoolSizes.md),
                      decoration: BoxDecoration(
                        color: SchoolDynamicColors.activeBlue,
                        borderRadius:
                            BorderRadius.circular(SchoolSizes.cardRadiusXs),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'OK',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  bool isFormValid() {
    return step1FormKey.currentState?.validate() ?? false;
  }
}
