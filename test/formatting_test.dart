import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';
import 'package:test/test.dart';

void main() {
  group('formatting', () {
    test('khmer digits conversion', () {
      expect(toKhmerDigits('2026'), '២០២៦');
    });

    test('date formatting helpers', () {
      expect(formatIsoDate(DateTime(2026, 2, 6)), '2026-02-06');
      expect(
        formatIsoDateTime(DateTime(2026, 2, 6, 7, 8, 9)),
        '2026-02-06 07:08:09',
      );
    });

    test('lunar formatter supports khmer digits option', () {
      final day = KhmerLunar.day(DateTime(2026, 2, 16));
      final text = formatLunarDate(
        day,
        options: const KhmerLunarOptions(useKhmerDigits: true),
      );
      expect(text, contains('BE'));
      expect(text, contains('២'));
    });
  });
}
