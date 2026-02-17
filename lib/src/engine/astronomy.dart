import 'dart:math' as math;

import 'epoch.dart';
import 'internal_types.dart';

/// Internal astronomy helpers used by the Chhankitek engine.
class Astronomy {
  static const double _newMoonToleranceDays = 1.1;
  static const double _fullMoonToleranceDays = 1.1;

  static bool isGregorianLeapYear(int year) {
    if (year % 400 == 0) return true;
    if (year % 100 == 0) return false;
    return year % 4 == 0;
  }

  static LunarMetrics metricsForDate(DateTime date) {
    final utc = DateTime.utc(date.year, date.month, date.day, 12);
    final jd = _julianDay(utc);
    final cycles = (jd - kReferenceNewMoonJd) / kSynodicMonth;
    final lunation = cycles.floor();

    final moonAge = _positiveModulo(jd - kReferenceNewMoonJd, kSynodicMonth);
    final lunarDay = math.min(moonAge.floor() + 1, 30);
    final isWaxing = moonAge < (kSynodicMonth / 2);

    final distanceToNewMoon = math.min(moonAge, kSynodicMonth - moonAge);
    final distanceToFullMoon = (moonAge - (kSynodicMonth / 2)).abs();

    return LunarMetrics(
      julianDay: jd,
      lunation: lunation,
      moonAgeDays: moonAge,
      lunarDay: lunarDay,
      isWaxing: isWaxing,
      isNewMoonWindow: distanceToNewMoon <= _newMoonToleranceDays,
      isFullMoonWindow: distanceToFullMoon <= _fullMoonToleranceDays,
    );
  }

  static double _positiveModulo(double value, double modulus) {
    final remainder = value % modulus;
    if (remainder < 0) {
      return remainder + modulus;
    }
    return remainder;
  }

  static double _julianDay(DateTime utc) {
    var year = utc.year;
    var month = utc.month;
    final day =
        utc.day +
        (utc.hour / 24.0) +
        (utc.minute / 1440.0) +
        (utc.second / 86400.0) +
        (utc.millisecond / 86400000.0) +
        (utc.microsecond / 86400000000.0);

    if (month <= 2) {
      year -= 1;
      month += 12;
    }

    final a = year ~/ 100;
    final b = 2 - a + (a ~/ 4);
    return (365.25 * (year + 4716)).floorToDouble() +
        (30.6001 * (month + 1)).floorToDouble() +
        day +
        b -
        1524.5;
  }
}
