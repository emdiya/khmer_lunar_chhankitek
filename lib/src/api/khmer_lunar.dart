import '../engine/chhankitek_engine.dart';
import '../engine/epoch.dart';
import '../models/lunar_day.dart';
import '../models/lunar_phase.dart';
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
    final normalized = DateTime(date.year, date.month, date.day);
    final today = day(normalized, options: options);
    final moonCount = ((today.lunarDay - 1) % 15) + 1;
    if (today.phase == LunarPhase.waxing) {
      return moonCount == 8 || moonCount == 15;
    }

    if (moonCount == 8 || moonCount == 15) {
      return true;
    }

    if (moonCount == 14) {
      final tomorrow = day(
        normalized.add(const Duration(days: 1)),
        options: options,
      );
      final tomorrowMoonCount = ((tomorrow.lunarDay - 1) % 15) + 1;
      return tomorrow.phase == LunarPhase.waxing && tomorrowMoonCount == 1;
    }

    return false;
  }

  /// Returns true when the given date is the day before major sil day (ថ្ងៃកោរ).
  ///
  /// Major sil days are full/new moon observances (15th day, or 14 roch when
  /// it rolls over to 1 kert next day). Quarter sil days (8th day) are excluded.
  static bool isKorDay(
    DateTime date, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    final normalized = DateTime(date.year, date.month, date.day);
    if (isSilDay(normalized, options: options)) {
      return false;
    }
    final tomorrow = normalized.add(const Duration(days: 1));
    return _isMajorSilDay(tomorrow, options: options);
  }

  static bool _isMajorSilDay(
    DateTime date, {
    KhmerLunarOptions options = const KhmerLunarOptions(),
  }) {
    final normalized = DateTime(date.year, date.month, date.day);
    final today = day(normalized, options: options);
    final moonCount = ((today.lunarDay - 1) % 15) + 1;

    if (moonCount == 15) {
      return true;
    }

    if (moonCount == 14) {
      final tomorrow = day(
        normalized.add(const Duration(days: 1)),
        options: options,
      );
      final tomorrowMoonCount = ((tomorrow.lunarDay - 1) % 15) + 1;
      return tomorrow.phase == LunarPhase.waxing && tomorrowMoonCount == 1;
    }

    return false;
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
