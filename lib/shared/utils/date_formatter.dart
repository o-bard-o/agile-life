import 'package:intl/intl.dart';

class AppDateFormatter {
  static final DateFormat _monthDay = DateFormat('M월 d일');
  static final DateFormat _fullDate = DateFormat('yyyy년 M월 d일');

  static String monthDay(DateTime date) => _monthDay.format(date);

  static String fullDate(DateTime date) => _fullDate.format(date);

  static String range(DateTime start, DateTime end) {
    return '${monthDay(start)} - ${monthDay(end)}';
  }
}
