import '../engine/chhankitek_engine.dart';
import '../engine/epoch.dart';
import '../models/lunar_day.dart';
import 'options.dart';

class KhmerLunar {
  static const ChhankitekEngine _engine = ChhankitekEngine();
  static final Map<int, List<LunarDay>> _yearCache = <int, List<LunarDay>>{};

  static int get minSupportedYear => kMinSupportedYear;
  static int get maxSupportedYear => kMaxSupportedYear;

  static LunarDay day(
    DateTime date, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    return _engine.day(date, options: options);
  }

  /// Returns true when the given date is an Uposatha day (ថ្ងៃសីល).
  static bool isSilDay(
    DateTime date, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    return day(date, options: options).isUposatha;
  }

  /// Returns true on the day before a full/new moon observance.
  /// Quarter observances are excluded.
  static bool isKorDay(
    DateTime date, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    final today = day(date, options: options);
    return today.lunarDay == 14 ||
        today.lunarDay == today.lunarMonth.lengthDays - 1;
  }

  static List<LunarDay> month(
    int yearValue,
    int month, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    if (month < 1 || month > 12) {
      throw RangeError.range(month, 1, 12, 'month', 'Month must be 1-12.');
    }

    return KhmerLunar.year(
      yearValue,
      options: options,
    ).where((entry) => entry.date.month == month).toList(growable: false);
  }

  static List<LunarDay> year(
    int year, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    final cached = _yearCache[year];
    if (cached != null) {
      return cached;
    }

    final computed = List<LunarDay>.unmodifiable(
      _engine.year(year, options: options),
    );
    _yearCache[year] = computed;
    return computed;
  }

  static void clearYearCache() => _yearCache.clear();
}
