import '../engine/internal_types.dart';

class UposathaInfo {
  const UposathaInfo({
    required this.isUposatha,
    required this.isFullMoon,
    required this.isNewMoon,
  });

  final bool isUposatha;
  final bool isFullMoon;
  final bool isNewMoon;
}

class UposathaRule {
  const UposathaRule();

  UposathaInfo apply(LunarMetrics metrics) {
    final lunarDay = metrics.lunarDay;
    final isNewMoon =
        metrics.isNewMoonWindow && (lunarDay == 30 || lunarDay <= 2);
    final isFullMoon =
        metrics.isFullMoonWindow && (lunarDay >= 14 && lunarDay <= 16);
    final isQuarter = lunarDay == 8 || lunarDay == 23;

    return UposathaInfo(
      isUposatha: isNewMoon || isFullMoon || isQuarter,
      isFullMoon: isFullMoon,
      isNewMoon: isNewMoon,
    );
  }
}
