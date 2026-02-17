import '../api/options.dart';
import '../errors/exceptions.dart';
import '../models/lunar_day.dart';
import '../models/lunar_phase.dart';
import '../rules/be_year_rule.dart';
import '../rules/month_rule.dart';
import '../rules/uposatha_rule.dart';
import 'astronomy.dart';
import 'epoch.dart';

class ChhankitekEngine {
  const ChhankitekEngine();

  static const UposathaRule _uposathaRule = UposathaRule();
  static const MonthRule _monthRule = MonthRule();
  static const BeYearRule _beYearRule = BeYearRule();

  LunarDay day(
    DateTime date, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    final normalized = _dateOnly(date);
    _validateYear(normalized.year);
    final metrics = Astronomy.metricsForDate(normalized);
    final uposatha = _uposathaRule.apply(metrics);
    final monthInfo = _monthRule.apply(metrics);
    final beYear = _beYearRule.apply(normalized);
    final phase = metrics.isWaxing ? LunarPhase.waxing : LunarPhase.waning;

    return LunarDay(
      date: normalized,
      lunarDay: metrics.lunarDay,
      phase: phase,
      lunarMonth: monthInfo.lunarMonth,
      isUposatha: uposatha.isUposatha,
      isFullMoon: uposatha.isFullMoon,
      isNewMoon: uposatha.isNewMoon,
      beYear: beYear,
    );
  }

  List<LunarDay> year(
    int year, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    _validateYear(year);
    final start = DateTime(year, 1, 1);
    final daysInYear = Astronomy.isGregorianLeapYear(year)
        ? kDaysInLeapYear
        : kDaysInCommonYear;
    return List<LunarDay>.generate(
      daysInYear,
      (index) => day(start.add(Duration(days: index)), options: options),
    );
  }

  void _validateYear(int year) {
    if (year < kMinSupportedYear || year > kMaxSupportedYear) {
      throw InvalidYearRangeException(
        year,
        kMinSupportedYear,
        kMaxSupportedYear,
      );
    }
  }
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);
