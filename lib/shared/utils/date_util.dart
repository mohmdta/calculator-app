import 'package:intl/intl.dart';

String formatDateString(String dateStr) {
  try {
    DateFormat dateFormat = DateFormat("d MMMM yyyy");
    DateTime date = dateFormat.parse(dateStr);

    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));

    if (date.year == today.year && date.month == today.month && date.day == today.day) {
      return "Today";
    } else if (date.year == yesterday.year && date.month == yesterday.month && date.day == yesterday.day) {
      return "Yesterday";
    } else {
      return dateStr;
    }
  } catch (e) {
    print(e);
    return dateStr;
  }
}