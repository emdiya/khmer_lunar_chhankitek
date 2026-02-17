import '../engine/constant.dart';
import '../errors/exceptions.dart';
import '../models/khmer_lunar_date.dart';
import '../utils/chhankitek_utils.dart';
import 'khmer_new_year_cal.dart';

class Chhankitek {
  Chhankitek._();

  static KhmerLunarDate toKhmerLunarDateFormat(DateTime target) {
    final lunarDate = _findLunarDate(target);
    final khmerLunarDay = _getKhmerLunarDay(lunarDate.day);
    var lunarDay =
        '${ChhankitekUtils.convertIntegerToKhmerNumber(khmerLunarDay.moonCount)}'
        '${khmerLunarDay.moonStatus == 0 ? 'កើត' : 'រោច'}';
    final isFullMoonWaxing =
        khmerLunarDay.moonCount == 15 && khmerLunarDay.moonStatus == 0;
    if (isFullMoonWaxing) {
      lunarDay = '$lunarDay ពេញបូណ៌មី';
    }
    final beYear = _getBeYear(target);
    final lunarZodiac = _getAnimalYear(target);
    final lunarEra = _getJolakSakarajYear(target) % 10;

    final lunarMonth = Constant.lunarMonthsFormat[lunarDate.month];
    if (lunarMonth == null) {
      throw KhmerMonthException('Invalid month index: ${lunarDate.month}');
    }

    return KhmerLunarDate(
      dayOfWeek: ChhankitekUtils.getDayOfWeekInKhmer(target) ?? '',
      lunarDay: lunarDay,
      lunarMonth: lunarMonth,
      lunarZodiac: Constant.animalYear[lunarZodiac] ?? '',
      lunarEra: Constant.eraYear[lunarEra] ?? '',
      lunarYear: ChhankitekUtils.convertIntegerToKhmerNumber(beYear),
    );
  }

  static int _getBodithey(int beYear) {
    final ahk = _getAharkun(beYear);
    final avml = ((11 * ahk + 25) ~/ 692);
    final m = avml + ahk + 29;
    return m % 30;
  }

  static int _getAvoman(int beYear) {
    final ahk = _getAharkun(beYear);
    return ((11 * ahk) + 25) % 692;
  }

  static int _getAharkun(int beYear) {
    final t = (beYear * 292207) + 499;
    return (t ~/ 800) + 4;
  }

  static int _kromthupul(int beYear) {
    final ah = _getAharkunMod(beYear);
    return 800 - ah;
  }

  static int _isKhmerSolarLeap(int beYear) {
    final krom = _kromthupul(beYear);
    if (krom <= 207) {
      return 1;
    }
    return 0;
  }

  static int _getAharkunMod(int beYear) {
    final t = (beYear * 292207) + 499;
    return t % 800;
  }

  static int _getBoditheyLeap(int adYear) {
    var result = 0;

    final avoman = _getAvoman(adYear);
    final bodithey = _getBodithey(adYear);

    var boditheyLeap = 0;
    if (bodithey >= 25 || bodithey <= 5) {
      boditheyLeap = 1;
    }

    var avomanLeap = 0;
    if (_isKhmerSolarLeap(adYear) == 1) {
      if (avoman <= 126) {
        avomanLeap = 1;
      }
    } else {
      if (avoman <= 137) {
        if (_getAvoman(adYear + 1) == 0) {
          avomanLeap = 0;
        } else {
          avomanLeap = 1;
        }
      }
    }

    if (bodithey == 25) {
      final nextBodithey = _getBodithey(adYear + 1);
      if (nextBodithey == 5) {
        boditheyLeap = 0;
      }
    }

    if (bodithey == 24) {
      final nextBodithey = _getBodithey(adYear + 1);
      if (nextBodithey == 6) {
        boditheyLeap = 1;
      }
    }

    if (boditheyLeap == 1 && avomanLeap == 1) {
      result = 3;
    } else if (boditheyLeap == 1) {
      result = 1;
    } else if (avomanLeap == 1) {
      result = 2;
    }

    return result;
  }

  static int _getProtetinLeap(int beYear) {
    final b = _getBoditheyLeap(beYear);
    if (b == 3) {
      return 1;
    }
    if (b == 2 || b == 1) {
      return b;
    }
    if (_getBoditheyLeap(beYear - 1) == 3) {
      return 2;
    }
    return 0;
  }

  static int _getNumberOfDayInKhmerMonth(int beMonth, int beYear) {
    if (beMonth == Constant.lunarMonths['ជេស្ឋ'] && _isKhmerLeapDay(beYear)) {
      return 30;
    }
    if (beMonth == Constant.lunarMonths['បឋមាសាឍ'] ||
        beMonth == Constant.lunarMonths['ទុតិយាសាឍ']) {
      return 30;
    }
    return beMonth.isEven ? 29 : 30;
  }

  static bool _isKhmerLeapDay(int beYear) {
    return _getProtetinLeap(beYear) == 2;
  }

  static bool _isKhmerLeapMonth(int beYear) {
    return _getProtetinLeap(beYear) == 1;
  }

  static bool _isGregorianLeap(int adYear) {
    return adYear % 4 == 0 && adYear % 100 != 0 || adYear % 400 == 0;
  }

  static DateTime _getVisakhaBochea(int gregorianYear) {
    var date = DateTime(gregorianYear, 1, 1);
    final dayCount = _isGregorianLeap(gregorianYear) ? 366 : 365;
    for (var i = 0; i < dayCount; i++) {
      final lunarDate = _findLunarDate(date);
      if (Constant.lunarMonths['ពិសាខ'] == lunarDate.month && lunarDate.day == 14) {
        return date;
      }
      date = date.add(const Duration(days: 1));
    }
    throw VisakhabocheaException('Cannot find Visakhabochea day.');
  }

  static _LunarDate _findLunarDate(DateTime target) {
    var epochDate = DateTime(1900, 1, 1);
    var khmerMonth = Constant.lunarMonths['បុស្ស']!;
    var khmerDay = 0;

    while (_daysBetween(epochDate, target) >
        _getNumberOfDayInKhmerMonth(khmerMonth, _getMaybeBEYear(epochDate))) {
      final daysInCurrentMonth =
          _getNumberOfDayInKhmerMonth(khmerMonth, _getMaybeBEYear(epochDate));
      epochDate = epochDate.add(Duration(days: daysInCurrentMonth));
      khmerMonth = _nextMonthOf(khmerMonth, _getMaybeBEYear(epochDate));
    }

    khmerDay += _daysBetween(epochDate, target);

    final totalDaysOfMonth =
        _getNumberOfDayInKhmerMonth(khmerMonth, _getMaybeBEYear(target));
    if (totalDaysOfMonth <= khmerDay) {
      khmerDay = khmerDay % totalDaysOfMonth;
      khmerMonth = _nextMonthOf(khmerMonth, _getMaybeBEYear(epochDate));
    }

    final moved = epochDate.add(Duration(days: _daysBetween(epochDate, target)));
    return _LunarDate(day: khmerDay, month: khmerMonth, epochMoved: moved);
  }

  static int _getJolakSakarajYear(DateTime date) {
    final gregorianYear = date.year;
    final newYearDateTime = _getKhmerNewYearDateTime(gregorianYear);
    if (date.isBefore(newYearDateTime)) {
      return gregorianYear + 543 - 1182;
    }
    return gregorianYear + 544 - 1182;
  }

  static int _getAnimalYear(DateTime date) {
    final gregorianYear = date.year;
    final newYearDateTime = _getKhmerNewYearDateTime(gregorianYear);
    if (date.isBefore(newYearDateTime)) {
      return (gregorianYear + 543 + 4) % 12;
    }
    return (gregorianYear + 544 + 4) % 12;
  }

  static DateTime _getKhmerNewYearDateTime(int gregorianYear) {
    final jsYear = (gregorianYear + 544) - 1182;
    final info = KhmerNewYearCal(jsYear).khmerNewYear;

    final numberNewYearDay =
        info.newYearsDaySotins.isNotEmpty && info.newYearsDaySotins.first.angsar == 0
        ? 4
        : 3;

    final epochLerngSak = DateTime(
      gregorianYear,
      4,
      17,
      info.timeOfNewYear.hour,
      info.timeOfNewYear.minute,
    );
    final lunarDate = _findLunarDate(epochLerngSak);
    final diffFromEpoch =
        (((lunarDate.month - 4) * 30) + lunarDate.day) -
        (((info.lunarDateLerngSak.month - 4) * 30) + info.lunarDateLerngSak.day);
    return epochLerngSak.subtract(
      Duration(days: diffFromEpoch + numberNewYearDay - 1),
    );
  }

  static int _getBeYear(DateTime date) {
    final tmp = date.year;
    if (date.isAfter(_getVisakhaBochea(tmp))) {
      return tmp + 544;
    }
    return tmp + 543;
  }

  static _LunarDay _getKhmerLunarDay(int day) {
    final count = (day % 15) + 1;
    final moonStatus = day > 14
        ? Constant.moonStatus['រោច']!
        : Constant.moonStatus['កើត']!;
    return _LunarDay(moonCount: count, moonStatus: moonStatus);
  }

  static int _nextMonthOf(int khmerMonth, int beYear) {
    if (khmerMonth == Constant.lunarMonths['មិគសិរ']) return Constant.lunarMonths['បុស្ស']!;
    if (khmerMonth == Constant.lunarMonths['បុស្ស']) return Constant.lunarMonths['មាឃ']!;
    if (khmerMonth == Constant.lunarMonths['មាឃ']) return Constant.lunarMonths['ផល្គុន']!;
    if (khmerMonth == Constant.lunarMonths['ផល្គុន']) return Constant.lunarMonths['ចេត្រ']!;
    if (khmerMonth == Constant.lunarMonths['ចេត្រ']) return Constant.lunarMonths['ពិសាខ']!;
    if (khmerMonth == Constant.lunarMonths['ពិសាខ']) return Constant.lunarMonths['ជេស្ឋ']!;
    if (khmerMonth == Constant.lunarMonths['ជេស្ឋ']) {
      if (_isKhmerLeapMonth(beYear)) {
        return Constant.lunarMonths['បឋមាសាឍ']!;
      }
      return Constant.lunarMonths['អាសាឍ']!;
    }
    if (khmerMonth == Constant.lunarMonths['អាសាឍ']) return Constant.lunarMonths['ស្រាពណ៍']!;
    if (khmerMonth == Constant.lunarMonths['ស្រាពណ៍']) return Constant.lunarMonths['ភទ្របទ']!;
    if (khmerMonth == Constant.lunarMonths['ភទ្របទ']) return Constant.lunarMonths['អស្សុជ']!;
    if (khmerMonth == Constant.lunarMonths['អស្សុជ']) return Constant.lunarMonths['កក្ដិក']!;
    if (khmerMonth == Constant.lunarMonths['កក្ដិក']) return Constant.lunarMonths['មិគសិរ']!;
    if (khmerMonth == Constant.lunarMonths['បឋមាសាឍ']) return Constant.lunarMonths['ទុតិយាសាឍ']!;
    if (khmerMonth == Constant.lunarMonths['ទុតិយាសាឍ']) return Constant.lunarMonths['ស្រាពណ៍']!;
    throw KhmerMonthException('Invalid month');
  }

  static int _getMaybeBEYear(DateTime date) {
    if (date.month <= (Constant.solarMonths['APR']! + 1)) {
      return date.year + 543;
    }
    return date.year + 544;
  }

  static int _daysBetween(DateTime start, DateTime end) {
    return end.difference(start).inDays;
  }
}

class _LunarDate {
  const _LunarDate({
    required this.day,
    required this.month,
    required this.epochMoved,
  });

  final int day;
  final int month;
  final DateTime epochMoved;
}

class _LunarDay {
  const _LunarDay({required this.moonCount, required this.moonStatus});

  final int moonCount;
  final int moonStatus;
}
