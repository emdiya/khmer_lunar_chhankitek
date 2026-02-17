class KhmerLunarDate {
  const KhmerLunarDate({
    required this.dayOfWeek,
    required this.lunarDay,
    required this.lunarMonth,
    required this.lunarZodiac,
    required this.lunarEra,
    required this.lunarYear,
  });

  final String dayOfWeek;
  final String lunarDay;
  final String lunarMonth;
  final String lunarZodiac;
  final String lunarEra;
  final String lunarYear;

  @override
  String toString() {
    return 'ថ្ងៃ$dayOfWeek $lunarDay ខែ$lunarMonth ឆ្នាំ$lunarZodiac $lunarEra ព.ស.$lunarYear';
  }
}
