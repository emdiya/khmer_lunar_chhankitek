class LunarMonth {
  const LunarMonth({
    required this.index,
    required this.name,
    required this.isLeapMonth,
    required this.lengthDays,
  });

  final int index;
  final String name;
  final bool isLeapMonth;
  final int lengthDays;
}
