import '../engine/traditional_calendar.dart';
import '../models/khmer_lunar_date.dart';

class Chhankitek {
  Chhankitek._();

  static KhmerLunarDate toKhmerLunarDateFormat(DateTime target) =>
      TraditionalCalendar.toKhmerLunarDateFormat(target);
}
