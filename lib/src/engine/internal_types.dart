class LunarMetrics {
  const LunarMetrics({
    required this.julianDay,
    required this.lunation,
    required this.moonAgeDays,
    required this.lunarDay,
    required this.isWaxing,
    required this.isNewMoonWindow,
    required this.isFullMoonWindow,
  });

  final double julianDay;
  final int lunation;
  final double moonAgeDays;
  final int lunarDay;
  final bool isWaxing;
  final bool isNewMoonWindow;
  final bool isFullMoonWindow;
}
