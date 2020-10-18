import 'package:intl/intl.dart';

String getDateString(DateTime date) {
  try {
    return DateFormat('MM/dd').format(date);
  } catch (e) {
    return "";
  }
}
