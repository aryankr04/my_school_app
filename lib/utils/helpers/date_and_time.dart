import 'package:intl/intl.dart';

class SchoolDateAndTimeFunction {
  static String getCurrentDate() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(now);
  }

  static String getCurrentTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('h:mm a');
    return formatter.format(now);
  }

  static String getCurrentDateTime() {
    DateTime now = DateTime.now();
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    return formatter.format(now);
  }

  static String getDateFromDateTime(String dateTimeString) {
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    DateTime dateTime = formatter.parse(dateTimeString);
    DateFormat dateFormatter = DateFormat('dd-MM-yyyy');
    return dateFormatter.format(dateTime);
  }

  static String getTimeFromDateTime(String dateTimeString) {
    DateFormat formatter = DateFormat('dd-MM-yyyy HH:mm:ss');
    DateTime dateTime = formatter.parse(dateTimeString);
    DateFormat timeFormatter = DateFormat('HH:mm:ss');
    return timeFormatter.format(dateTime);
  }

  static String getFormattedDate(DateTime date,
      {String format = 'dd-MM-yyyy'}) {
    return DateFormat(format).format(date);
  }

  static String formatDate(int day, int month, int year) {
    DateTime date = DateTime(year, month, day);
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }

  static String getReadableDate(String dateString) {
    try {

      // Define the input date format
      DateFormat inputFormat = DateFormat('dd-MM-yyyy');
      DateTime dateTime = inputFormat.parse(dateString);

      // Define the output date format
      DateFormat outputFormat = DateFormat('d MMM yyyy');
      return outputFormat.format(dateTime);
    } catch (e) {
      print("Error parsing date: $e");
      return "Invalid Date";
    }
  }
}
