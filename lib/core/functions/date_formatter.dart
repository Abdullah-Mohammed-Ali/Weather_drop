import 'package:intl/intl.dart';

String dateFormatted(int date) {
  var dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
  var formatted = DateFormat("hh:00 a").format(dateTime);

  return formatted.toString();
}
