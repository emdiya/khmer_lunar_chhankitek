import '../api/options.dart';
import '../models/lunar_day.dart';
import 'traditional_calendar.dart';

class ChhankitekEngine {
  const ChhankitekEngine();

  LunarDay day(
    DateTime date, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) => TraditionalCalendar.day(date);

  List<LunarDay> year(
    int year, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    TraditionalCalendar.validateYear(year);
    final count = DateTime.utc(year + 1).difference(DateTime.utc(year)).inDays;
    return List.generate(
      count,
      (index) => day(DateTime.utc(year, 1, index + 1), options: options),
    );
  }
}
