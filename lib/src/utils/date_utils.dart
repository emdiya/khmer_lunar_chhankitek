import '../engine/epoch.dart';

DateTime normalizeDate(DateTime date) =>
    DateTime(date.year, date.month, date.day);

int gregorianDaysInYear(int year) {
  final isLeap = (year % 400 == 0) || (year % 4 == 0 && year % 100 != 0);
  return isLeap ? kDaysInLeapYear : kDaysInCommonYear;
}

Iterable<DateTime> buildYearDateRange(int year) sync* {
  final start = DateTime(year, 1, 1);
  final days = gregorianDaysInYear(year);
  for (var i = 0; i < days; i++) {
    yield start.add(Duration(days: i));
  }
}
