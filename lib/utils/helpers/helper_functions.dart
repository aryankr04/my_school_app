
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_school_app/utils/constants/dynamic_colors.dart';

class SchoolHelperFunctions {
  static Color? getColor(String value) {
    /// Define your product specific colors here and it will match the attribute colors and show specific 🟠🟡🟢🔵🟣🟤

    if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Green') {
      return Colors.green;
    } else if (value == 'Red') {
      return Colors.red;
    } else if (value == 'Blue') {
      return Colors.blue;
    } else if (value == 'Pink') {
      return Colors.pink;
    } else if (value == 'Grey') {
      return Colors.grey;
    } else if (value == 'Purple') {
      return Colors.purple;
    } else if (value == 'Black') {
      return Colors.black;
    } else if (value == 'White') {
      return Colors.white;
    } else if (value == 'Yellow') {
      return Colors.yellow;
    } else if (value == 'Orange') {
      return Colors.deepOrange;
    } else if (value == 'Brown') {
      return Colors.brown;
    } else if (value == 'Teal') {
      return Colors.teal;
    } else if (value == 'Indigo') {
      return Colors.indigo;
    } else {
      return null;
    }
  }

  static void showSnackBar(String message, {Color? backgroundColor}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(

        backgroundColor: backgroundColor ?? SchoolDynamicColors.activeBlue,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
        duration: const Duration(milliseconds: 2500),
      ),
    );
  }

  static void showSuccessSnackBar(String message) {
    showSnackBar(message, backgroundColor: SchoolDynamicColors.activeGreen);
  }

  static void showErrorSnackBar(String errorMessage) {
    print(errorMessage);
    showSnackBar('Error: $errorMessage', backgroundColor: SchoolDynamicColors.activeRed);
  }

  static void showAlertSnackBar(String message) {
    showSnackBar(message, backgroundColor: SchoolDynamicColors.activeOrange);
  }

  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
  static void showLoadingSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
       const SnackBar(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 16),
            Text('Loading...'),
          ],
        ),
        duration: Duration(seconds: 10), // Adjust the duration as needed
      ),
    );
  }


  static void showLoadingOverlay() {
    if (!(Get.isDialogOpen ?? false)) {
      showDialog(
        context: Get.context!,
        builder: (_) => WillPopScope(
          onWillPop: () async => false, // Prevent dialog dismissal
          child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(),
                    const SizedBox(height: 16.0),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        barrierDismissible: false,
      );
    }
  }

  // Hide loading overlay
  static void hideLoadingOverlay() {
    if (Get.isDialogOpen ?? false) {
      Get.back();
    }
  }
  static String extractValueInBrackets(String input) {
    RegExp regex = RegExp(r'\((.*?)\)');
    RegExpMatch? match = regex.firstMatch(input);

    if (match != null && match.groupCount >= 1) {
      return match.group(1) ?? '';
    }

    return '';
  }

  static void hideSnackBar(BuildContext context) {
    Get.back();
  }
  static void navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => screen),
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }
  static String formatDate(int day, int month, int year) {
    DateTime date = DateTime(year, month, day);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }


  static String getTodayDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }


  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(
          i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }


}
