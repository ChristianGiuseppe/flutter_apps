// ignore: file_names
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatAsDayMonthYearWithSlash() {
    return DateFormat('dd/mm/yyyy').format(this);
  }
}
