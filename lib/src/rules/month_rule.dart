import '../engine/internal_types.dart';
import '../models/lunar_month.dart';

class KhmerMonthInfo {
  const KhmerMonthInfo({required this.lunarMonth});

  final LunarMonth lunarMonth;
}

class MonthRule {
  const MonthRule();

  static const List<String> _khmerMonthByLunation = <String>[
    'មិគសិរ',
    'បុស្ស',
    'មាឃ',
    'ផល្គុន',
    'ចេត្រ',
    'ពិសាខ',
    'ជេស្ឋ',
    'អាសាឍ',
    'ស្រាពណ៍',
    'ភទ្របទ',
    'អស្សុជ',
    'កត្តិក',
  ];
  static const int _referenceLunationForMigasir = 0;

  KhmerMonthInfo apply(LunarMetrics metrics) {
    final monthIndex =
        (metrics.lunation - _referenceLunationForMigasir) %
        _khmerMonthByLunation.length;
    final monthName =
        _khmerMonthByLunation[(monthIndex + _khmerMonthByLunation.length) %
            _khmerMonthByLunation.length];
    final normalizedIndex =
        ((monthIndex + _khmerMonthByLunation.length) %
            _khmerMonthByLunation.length) +
        1;
    final isLeapMonth = _isLeapMonth(metrics.lunation);
    final lengthDays = _monthLength(metrics.lunation);

    return KhmerMonthInfo(
      lunarMonth: LunarMonth(
        index: normalizedIndex,
        name: monthName,
        isLeapMonth: isLeapMonth,
        lengthDays: lengthDays,
      ),
    );
  }

  bool _isLeapMonth(int lunation) => lunation % 33 == 0;

  int _monthLength(int lunation) => lunation.isEven ? 30 : 29;
}
