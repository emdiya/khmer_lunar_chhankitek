import 'lunar_month.dart';
import 'lunar_phase.dart';

class LunarDay {
  const LunarDay({
    required this.date,
    required this.lunarDay,
    required this.phase,
    required this.lunarMonth,
    required this.isUposatha,
    required this.isFullMoon,
    required this.isNewMoon,
    required this.beYear,
  });

  final DateTime date;
  final int lunarDay;
  final LunarPhase phase;
  final LunarMonth lunarMonth;
  final bool isUposatha;
  final bool isFullMoon;
  final bool isNewMoon;
  final int beYear;

  String get khmerMonth => lunarMonth.name;
}
