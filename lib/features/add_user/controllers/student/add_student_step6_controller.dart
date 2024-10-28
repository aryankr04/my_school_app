import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_school_app/utils/constants/sizes.dart';

import '../../../../utils/constants/dynamic_colors.dart';
import '../../../../utils/constants/lists.dart';
import '../../../user/management/noticeboard/add_notice_new.dart';

class StudentStep6FormController extends GetxController {
  final GlobalKey<FormState> step6FormKey = GlobalKey<FormState>();

  RxString selectedFavoriteSubject = RxString('');
  RxString selectedFavoriteSport = RxString('');
  RxString selectedFavoriteTeacher = RxString('');

  TextEditingController goalController = TextEditingController();
  TextEditingController favoriteFoodController = TextEditingController();

  RxList<String> selectedHobbies = <String>[].obs;
  TextEditingController hobbyController = TextEditingController();

  @override
  void onClose() {
    goalController.dispose();
    favoriteFoodController.dispose();
    hobbyController.dispose();

    super.onClose();
  }

  bool isFormValid() {
    return step6FormKey.currentState?.validate() ?? false;
  }

  Future<void> showHobbySelectionDialog() async {
    await showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          backgroundColor: Colors.white,
          title: const Text('Select Hobbies'),
          content: Container(
            width: Get.width,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MultiSelectionWidget(
                    showSelectAll: false,
                    options: SchoolLists.hobbies,
                    onSelectionChanged: (selectedItems) {
                      selectedHobbies.assignAll(selectedItems);
                    },
                    selectedItems: selectedHobbies,
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
                      hobbyController.text = selectedHobbies.join(', ');
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: SchoolSizes.md),
                      decoration: BoxDecoration(
                        color: SchoolDynamicColors.activeBlue,
                        borderRadius:
                            BorderRadius.circular(SchoolSizes.cardRadiusXs),
                      ),
                      alignment:
                          Alignment.center, // Center text inside the button
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
}
