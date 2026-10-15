import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';
import 'package:test/test.dart';

void main() {
  // KB PRASAC Bank corporate calendar 2026, January/April/May pages:
  // https://www.kbprasacbank.com.kh/wp-content/uploads/2026/01/KB-PRASAC-Bank_Corporate-calendar-2026.pdf
  test('published 2026 reference dates and Buddhist Era transition', () {
    final fixtures = [
      (DateTime(2026, 1, 3), 15, 'បុស្ស', 2569),
      (DateTime(2026, 4, 16), 29, 'ចេត្រ', 2569),
      (DateTime(2026, 4, 17), 1, 'ពិសាខ', 2569),
      (DateTime(2026, 5, 1), 15, 'ពិសាខ', 2569),
      (DateTime(2026, 5, 2), 16, 'ពិសាខ', 2570),
    ];
    for (final (date, count, month, be) in fixtures) {
      final day = KhmerLunar.day(date);
      final formatted = Chhankitek.toKhmerLunarDateFormat(date);
      expect(day.lunarDay, count);
      expect(day.khmerMonth, month);
      expect(day.beYear, be);
      expect(formatted.lunarMonth, month);
      expect(formatted.lunarYear, toKhmerDigits(be));
    }
  });

  test('published 2026 New Year time', () {
    final info = KhmerNewYearCal(2026 + 544 - 1182).khmerNewYear;
    expect(info.timeOfNewYear.hour, 10);
    expect(info.timeOfNewYear.minute, 48);
  });

  test('civil dates ignore time and UTC flag', () {
    final dates = [
      DateTime(2026, 5, 1),
      DateTime(2026, 5, 1, 23, 59),
      DateTime.utc(2026, 5, 1, 23, 59),
    ];
    for (final date in dates) {
      expect(KhmerLunar.day(date).beYear, 2569);
      expect(
        Chhankitek.toKhmerLunarDateFormat(date).toString(),
        Chhankitek.toKhmerLunarDateFormat(dates.first).toString(),
      );
    }
  });

  test('all APIs handle supported endpoints and reject outside dates', () {
    for (final date in [DateTime(1900, 1, 1), DateTime(2100, 12, 31)]) {
      expect(() => KhmerLunar.isSilDay(date), returnsNormally);
      expect(() => KhmerLunar.isKorDay(date), returnsNormally);
      expect(() => Chhankitek.toKhmerLunarDateFormat(date), returnsNormally);
    }
    for (final date in [DateTime(1899, 12, 31), DateTime(2101, 1, 1)]) {
      expect(
        () => KhmerLunar.day(date),
        throwsA(isA<InvalidYearRangeException>()),
      );
      expect(
        () => Chhankitek.toKhmerLunarDateFormat(date),
        throwsA(isA<InvalidYearRangeException>()),
      );
    }
  });

  test(
    'continuous lunar days and consistent observances throughout supported range',
    () {
      LunarDay? previous;
      var sawLeapMonth = false;
      for (var year = 1900; year <= 2100; year++) {
        for (final day in KhmerLunar.year(year)) {
          expect(day.lunarDay, inInclusiveRange(1, day.lunarMonth.lengthDays));
          expect(
            day.phase,
            day.lunarDay <= 15 ? LunarPhase.waxing : LunarPhase.waning,
          );
          if (previous != null) {
            expect(
              KhmerLunar.isKorDay(previous.date),
              day.isFullMoon || day.isNewMoon,
            );
            expect(
              day.lunarDay,
              previous.lunarDay == previous.lunarMonth.lengthDays
                  ? 1
                  : previous.lunarDay + 1,
              reason: '${day.date}',
            );
            if (day.lunarDay != 1) {
              expect(day.lunarMonth.index, previous.lunarMonth.index);
              expect(day.lunarMonth.lengthDays, previous.lunarMonth.lengthDays);
            }
          }
          expect(KhmerLunar.isSilDay(day.date), day.isUposatha);
          expect(day.isFullMoon, day.lunarDay == 15);
          expect(day.isNewMoon, day.lunarDay == day.lunarMonth.lengthDays);
          if (day.lunarMonth.isLeapMonth) sawLeapMonth = true;
          previous = day;
        }
      }
      expect(sawLeapMonth, isTrue);
    },
  );
}
