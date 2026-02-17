import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';
import 'package:test/test.dart';

void main() {
  group('known dates', () {
    test('new moon window near reference date', () {
      final day = KhmerLunar.day(DateTime(2000, 1, 6));
      expect(day.isNewMoon, isTrue);
      expect(day.isFullMoon, isFalse);
      expect(day.isUposatha, isTrue);
    });

    test('full moon window near mid-cycle date', () {
      final day = KhmerLunar.day(DateTime(2000, 1, 21));
      expect(day.isFullMoon, isTrue);
      expect(day.isNewMoon, isFalse);
      expect(day.isUposatha, isTrue);
    });

    test('phase and month metadata are populated', () {
      final day = KhmerLunar.day(DateTime(2026, 2, 16));
      expect(day.lunarDay, inInclusiveRange(1, 30));
      expect(day.khmerMonth, isNotEmpty);
      expect(day.lunarMonth.index, inInclusiveRange(1, 12));
      expect(day.phase, anyOf(LunarPhase.waxing, LunarPhase.waning));
    });

    test('isSilDay follows strict Khmer sil pattern', () {
      expect(KhmerLunar.isSilDay(DateTime(2026, 4, 17)), isFalse);
      expect(KhmerLunar.isSilDay(DateTime(2000, 1, 21)), isTrue);
    });

    test('isKorDay returns true one day before Uposatha', () {
      expect(KhmerLunar.isKorDay(DateTime(2000, 1, 5)), isTrue);
      expect(KhmerLunar.isKorDay(DateTime(2000, 1, 4)), isFalse);
      expect(KhmerLunar.isKorDay(DateTime(2000, 1, 6)), isFalse);
    });

    test('14 roch at month-end is treated as sil day', () {
      final date = DateTime(2026, 4, 16);
      expect(KhmerLunar.isSilDay(date), isTrue);
      expect(KhmerLunar.isKorDay(date), isFalse);
    });

    test('1 kert is not sil day in strict mode', () {
      final date = DateTime(2026, 4, 17);
      expect(KhmerLunar.isSilDay(date), isFalse);
    });

    test('15 kert includes full moon wording in Khmer formatted text', () {
      final date = DateTime(2026, 1, 3);
      final text = Chhankitek.toKhmerLunarDateFormat(date).toString();
      expect(text, contains('១៥កើត ពេញបូណ៌មី'));
    });
  });
}
