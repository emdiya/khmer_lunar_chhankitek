import '../api/options.dart';
import '../engine/constant.dart';
import '../models/lunar_day.dart';
import 'date_format.dart';
import 'khmer_digits.dart';

String formatLunarDate(
  LunarDay day, {
  KhmerLunarOptions options = const KhmerLunarOptions(),
}) {
  final dateText = formatIsoDate(day.date);
  final beText = options.useKhmerDigits
      ? toKhmerDigits(day.beYear)
      : day.beYear.toString();
  return '$dateText ${day.khmerMonth} BE $beText';
}

String formatKhmerGregorianDate(DateTime date) {
  final khmerMonth = Constant.khmerSolarMonths[date.month];
  return 'ថ្ងៃទី${toKhmerDigits(date.day)} ខែ$khmerMonth '
      'ឆ្នាំ${toKhmerDigits(date.year)}';
}
