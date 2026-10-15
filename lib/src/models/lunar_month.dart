class LunarMonth {
  const LunarMonth({
    required this.index,
    required this.name,
    required this.isLeapMonth,
    required this.lengthDays,
  });

  /// 1-based month identity; repeated Asadh months use 13 and 14.
  final int index;
  final String name;

  /// True for either Asadh month in a year with an intercalary month.
  final bool isLeapMonth;
  final int lengthDays;
}
