import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';

void main() {
  // Part 1: Today
  final now = DateTime.now();
  final today = KhmerLunar.day(now);
  final todayMonthDays = KhmerLunar.month(today.date.year, today.date.month);
  final todayKhmerDate = Chhankitek.toKhmerLunarDateFormat(now);

  print('=== Today ===');
  print(todayKhmerDate.toString());
  print(formatKhmerGregorianDate(now));
  print('Uposatha: ${today.isUposatha}');
  print('Days this month: ${todayMonthDays.length}');
  final todayIsSil = KhmerLunar.isSilDay(now);
  final todayIsKor = KhmerLunar.isKorDay(now);
  print('ថ្ងៃសីល: $todayIsSil');
  print('ថ្ងៃកោរ: $todayIsKor');
  print(
    '${formatKhmerGregorianDate(now)} ជា'
    '${todayIsSil ? 'ថ្ងៃសីល' : (todayIsKor ? 'ថ្ងៃកោរ' : 'ថ្ងៃធម្មតា')}',
  );

  // Part 2: Specific day
  final specificDate = DateTime(2026, 5, 31);
  final specificDay = KhmerLunar.day(specificDate);
  final specificMonthDays = KhmerLunar.month(
    specificDay.date.year,
    specificDay.date.month,
  );
  final specificKhmerDate = Chhankitek.toKhmerLunarDateFormat(specificDate);

  print('=== Specific Day (2026-05-31) ===');
  print(specificKhmerDate.toString());
  print(formatKhmerGregorianDate(specificDate));
  print('Uposatha: ${specificDay.isUposatha}');
  print('Days this month: ${specificMonthDays.length}');
  final specificIsSil = KhmerLunar.isSilDay(specificDate);
  final specificIsKor = KhmerLunar.isKorDay(specificDate);
  print('ថ្ងៃសីល: $specificIsSil');
  print('ថ្ងៃកោរ: $specificIsKor');
  print(
    '${formatKhmerGregorianDate(specificDate)} ជា'
    '${specificIsSil ? 'ថ្ងៃសីល' : (specificIsKor ? 'ថ្ងៃកោរ' : 'ថ្ងៃធម្មតា')}',
  );
}
