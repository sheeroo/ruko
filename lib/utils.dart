import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  String format(String format) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(this);
  }
}
