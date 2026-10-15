import '../engine/constant.dart';
import '../errors/exceptions.dart';

class KhmerNewYearCal {
  KhmerNewYearCal(this.jsYear)
    : info = _getInfo(jsYear),
      khmerNewYear = _buildKhmerNewYear(jsYear);

  final YearInfo info;
  final int jsYear;
  final KhmerNewYear khmerNewYear;

  static KhmerNewYear _buildKhmerNewYear(int jsYear) {
    final info = _getInfo(jsYear);
    final cal = KhmerNewYearCal._internal(jsYear, info);
    return KhmerNewYear(
      harkun: info.harkun,
      kromathopol: info.kromathopol,
      avaman: info.avaman,
      bodithey: info.bodithey,
      has366day: cal._getHas366Day(jsYear),
      isAthikameas: cal._getIsAthikameas(jsYear),
      isChantreathimeas: cal._getIsChantreathimeas(jsYear),
      jesthHas30: cal._jesthHas30(jsYear),
      dayLerngSak: cal._getDayLerngSak(),
      lunarDateLerngSak: cal._getLunarDateLerngSak(),
      newYearsDaySotins: cal._getNewYearDaySotins(),
      timeOfNewYear: cal._getNewYearTime(),
    );
  }

  KhmerNewYearCal._internal(this.jsYear, this.info)
    : khmerNewYear = const KhmerNewYear.empty();

  static YearInfo _getInfo(int jsYear) {
    final h = 292207 * jsYear + 373;
    final harkun = (h ~/ 800) + 1;
    final kromathopol = 800 - (h % 800);

    final a = (11 * harkun) + 650;
    final avaman = a % 692;
    final bodithey = (harkun + (a ~/ 692)) % 30;
    return YearInfo(
      harkun: harkun,
      kromathopol: kromathopol,
      avaman: avaman,
      bodithey: bodithey,
    );
  }

  bool _getHas366Day(int jsYear) {
    final infoOfYear = _getInfo(jsYear);
    return infoOfYear.kromathopol <= 207;
  }

  bool _getIsAthikameas(int jsYear) {
    final infoOfYear = _getInfo(jsYear);
    final infoOfNextYear = _getInfo(jsYear + 1);
    return (!(infoOfYear.bodithey == 25 && infoOfNextYear.bodithey == 5) &&
        (infoOfYear.bodithey > 24 ||
            infoOfYear.bodithey < 6 ||
            (infoOfYear.bodithey == 24 && infoOfNextYear.bodithey == 6)));
  }

  bool _getIsChantreathimeas(int jsYear) {
    final infoOfYear = _getInfo(jsYear);
    final infoOfNextYear = _getInfo(jsYear + 1);
    final infoOfPreviousYear = _getInfo(jsYear - 1);
    final has366Day = _getHas366Day(jsYear);
    return ((has366Day && infoOfYear.avaman < 127) ||
        (!(infoOfYear.avaman == 137 && infoOfNextYear.avaman == 0) &&
            ((!has366Day && infoOfYear.avaman < 138) ||
                (infoOfPreviousYear.avaman == 137 && infoOfYear.avaman == 0))));
  }

  bool _jesthHas30(int jsYear) {
    var tmp = _getIsChantreathimeas(jsYear);
    if (_getIsAthikameas(jsYear) && _getIsChantreathimeas(jsYear)) {
      tmp = false;
    }
    if (!_getIsChantreathimeas(jsYear) &&
        _getIsAthikameas(jsYear - 1) &&
        _getIsChantreathimeas(jsYear - 1)) {
      tmp = true;
    }
    return tmp;
  }

  int _getDayLerngSak() {
    return (info.harkun - 2) % 7;
  }

  LunarDateLerngSak _getLunarDateLerngSak() {
    var bodithey = info.bodithey;
    if (_getIsAthikameas(jsYear - 1) && _getIsChantreathimeas(jsYear - 1)) {
      bodithey = (bodithey + 1) % 30;
    }
    return LunarDateLerngSak(
      day: bodithey >= 6 ? (bodithey - 1) : bodithey,
      month: bodithey >= 6
          ? Constant.lunarMonths['ចេត្រ']!
          : Constant.lunarMonths['ពិសាខ']!,
    );
  }

  SunInfo _getSunInfo(int sotin) {
    final infoOfPreviousYear = _getInfo(jsYear - 1);
    final sunAverageAsLibda = _getSunAverageAsLibda(sotin, infoOfPreviousYear);
    final leftOver = _getLeftOver(sunAverageAsLibda);
    final kaen = leftOver ~/ (30 * 60);
    final lastLeftOver = _getLastLeftOver(kaen, leftOver);

    late final int khan;
    late final int pouichalip;
    if (lastLeftOver.angsar >= 15) {
      khan = (2 * lastLeftOver.reasey) + 1;
      pouichalip = (60 * (lastLeftOver.angsar - 15)) + lastLeftOver.libda;
    } else {
      khan = 2 * lastLeftOver.reasey;
      pouichalip = (60 * lastLeftOver.angsar) + lastLeftOver.libda;
    }

    final phol = _getPhol(khan, pouichalip);
    final pholAsLibda =
        (30 * 60 * phol.reasey) + (60 * phol.angsar) + phol.libda;
    final sunInaugurationAsLibda = kaen <= 5
        ? sunAverageAsLibda - pholAsLibda
        : sunAverageAsLibda + pholAsLibda;
    return SunInfo(
      sunAverageAsLibda: sunAverageAsLibda,
      khan: khan,
      pouichalip: pouichalip,
      phol: phol,
      sunInaugurationAsLibda: sunInaugurationAsLibda,
    );
  }

  List<NewYearDaySotins> _getNewYearDaySotins() {
    final sotins = _getHas366Day(jsYear - 1)
        ? <int>[363, 364, 365, 366]
        : <int>[362, 363, 364, 365];
    final newYearDaySotins = <NewYearDaySotins>[];
    for (final i in sotins) {
      final sunInfo = _getSunInfo(i);
      final reasey = sunInfo.sunInaugurationAsLibda ~/ (30 * 60);
      final angsar = (sunInfo.sunInaugurationAsLibda % (30 * 60)) ~/ 60;
      final libda = sunInfo.sunInaugurationAsLibda % 60;
      newYearDaySotins.add(
        NewYearDaySotins(
          sotin: i,
          reasey: reasey,
          angsar: angsar,
          libda: libda,
        ),
      );
    }
    return newYearDaySotins;
  }

  int _getSunAverageAsLibda(int sotin, YearInfo info) {
    final r2 = (800 * sotin) + info.kromathopol;
    final reasey = r2 ~/ 24350;
    final r3 = r2 % 24350;
    final angsar = r3 ~/ 811;
    final r4 = r3 % 811;
    final l1 = r4 ~/ 14;
    final libda = l1 - 3;
    return (30 * 60 * reasey) + (60 * angsar) + libda;
  }

  int _getLeftOver(int sunAverageAsLibda) {
    const s1 = (30 * 60 * 2) + (60 * 20);
    var leftOver = sunAverageAsLibda - s1;
    if (sunAverageAsLibda < s1) {
      leftOver += (30 * 60 * 12);
    }
    return leftOver;
  }

  LastOver _getLastLeftOver(int kaen, int leftOver) {
    var rs = -1;
    final l1 = <int>{0, 1, 2};
    final l2 = <int>{3, 4, 5};
    final l3 = <int>{6, 7, 8};
    final l4 = <int>{9, 10, 11};
    if (l1.contains(kaen)) {
      rs = leftOver;
    } else if (l2.contains(kaen)) {
      rs = (30 * 60 * 6) - leftOver;
    } else if (l3.contains(kaen)) {
      rs = leftOver - (30 * 60 * 6);
    } else if (l4.contains(kaen)) {
      rs = ((30 * 60 * 11) + (60 * 29) + 60) - leftOver;
    }
    return LastOver(
      reasey: rs ~/ (30 * 60),
      angsar: (rs % (30 * 60)) ~/ 60,
      libda: rs % 60,
    );
  }

  Phol _getPhol(int khan, int pouichalip) {
    var multiplicity = 0;
    var chhaya = 0;
    const multiplicities = <int>[35, 32, 27, 22, 13, 5];
    const chhayas = <int>[0, 35, 67, 94, 116, 129];

    switch (khan) {
      case 0:
      case 1:
      case 2:
      case 3:
      case 4:
      case 5:
        multiplicity = multiplicities[khan];
        chhaya = chhayas[khan];
        break;
      default:
        chhaya = 134;
        break;
    }

    final q = (pouichalip * multiplicity) ~/ 900;
    return Phol(
      reasey: 0,
      angsar: (q + chhaya) ~/ 60,
      libda: (q + chhaya) % 60,
    );
  }

  NewYearTime _getNewYearTime() {
    final sotinNewYear = _getNewYearDaySotins()
        .where((o) => o.angsar == 0)
        .toList(growable: false);
    if (sotinNewYear.isNotEmpty) {
      final libda = sotinNewYear.first.libda;
      final minutes = (24 * 60) - (libda * 24);
      return NewYearTime(hour: minutes ~/ 60, minute: minutes % 60);
    }
    throw SotinException(
      'Wrong calculation on new years hour. No sotin with angsar = 0',
    );
  }
}

class YearInfo {
  const YearInfo({
    required this.harkun,
    required this.kromathopol,
    required this.avaman,
    required this.bodithey,
  });

  final int harkun;
  final int kromathopol;
  final int avaman;
  final int bodithey;
}

class LunarDateLerngSak {
  const LunarDateLerngSak({required this.day, required this.month});

  final int day;
  final int month;
}

class Phol {
  const Phol({required this.reasey, required this.angsar, required this.libda});

  final int reasey;
  final int angsar;
  final int libda;
}

class NewYearTime {
  const NewYearTime({required this.hour, required this.minute});

  final int hour;
  final int minute;
}

class NewYearDaySotins {
  const NewYearDaySotins({
    required this.sotin,
    required this.reasey,
    required this.angsar,
    required this.libda,
  });

  final int sotin;
  final int reasey;
  final int angsar;
  final int libda;
}

class SunInfo {
  const SunInfo({
    required this.sunAverageAsLibda,
    required this.khan,
    required this.pouichalip,
    required this.phol,
    required this.sunInaugurationAsLibda,
  });

  final int sunAverageAsLibda;
  final int khan;
  final int pouichalip;
  final Phol phol;
  final int sunInaugurationAsLibda;
}

class LastOver {
  const LastOver({
    required this.reasey,
    required this.angsar,
    required this.libda,
  });

  final int reasey;
  final int angsar;
  final int libda;
}

class KhmerNewYear {
  const KhmerNewYear({
    required this.harkun,
    required this.kromathopol,
    required this.avaman,
    required this.bodithey,
    required this.has366day,
    required this.isAthikameas,
    required this.isChantreathimeas,
    required this.jesthHas30,
    required this.dayLerngSak,
    required this.lunarDateLerngSak,
    required this.newYearsDaySotins,
    required this.timeOfNewYear,
  });

  const KhmerNewYear.empty()
    : harkun = 0,
      kromathopol = 0,
      avaman = 0,
      bodithey = 0,
      has366day = false,
      isAthikameas = false,
      isChantreathimeas = false,
      jesthHas30 = false,
      dayLerngSak = 0,
      lunarDateLerngSak = const LunarDateLerngSak(day: 0, month: 0),
      newYearsDaySotins = const <NewYearDaySotins>[],
      timeOfNewYear = const NewYearTime(hour: 0, minute: 0);

  final int harkun;
  final int kromathopol;
  final int avaman;
  final int bodithey;
  final bool has366day;
  final bool isAthikameas;
  final bool isChantreathimeas;
  final bool jesthHas30;
  final int dayLerngSak;
  final LunarDateLerngSak lunarDateLerngSak;
  final List<NewYearDaySotins> newYearsDaySotins;
  final NewYearTime timeOfNewYear;
}
