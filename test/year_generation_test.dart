import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';
import 'package:test/test.dart';

void main() {
  group('year generation', () {
    test('returns 366 days for leap year', () {
      final days = KhmerLunar.year(2024);
      expect(days.length, 366);
    });

    test('returns 365 days for common year', () {
      final days = KhmerLunar.year(2025);
      expect(days.length, 365);
    });

    test('month() slices a single Gregorian month', () {
      final february = KhmerLunar.month(2024, 2);
      expect(february.length, 29);
      expect(february.every((day) => day.date.month == 2), isTrue);
    });

    test('year cache returns identical list instance', () {
      KhmerLunar.clearYearCache();
      final first = KhmerLunar.year(2025);
      final second = KhmerLunar.year(2025);
      expect(identical(first, second), isTrue);
    });
  });

  group('range validation', () {
    test('supports only 1900..2100', () {
      expect(
        () => KhmerLunar.year(1899),
        throwsA(isA<InvalidYearRangeException>()),
      );
      expect(
        () => KhmerLunar.year(2101),
        throwsA(isA<InvalidYearRangeException>()),
      );
      expect(() => KhmerLunar.day(DateTime(1900, 1, 1)), returnsNormally);
      expect(() => KhmerLunar.day(DateTime(2100, 12, 31)), returnsNormally);
    });
  });
}
