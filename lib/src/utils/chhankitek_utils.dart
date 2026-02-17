import '../engine/constant.dart';

class ChhankitekUtils {
  ChhankitekUtils._();

  static Map<A, B> asMap<A, B>(List<Object?> keysAndValues) {
    if (keysAndValues.length.isOdd) {
      throw ArgumentError('keysAndValues length must be even.');
    }

    final map = <A, B>{};
    for (var i = 0; i < keysAndValues.length; i += 2) {
      map[keysAndValues[i] as A] = keysAndValues[i + 1] as B;
    }
    return map;
  }

  static Map<int, B> indexAsKeyMap<B>(List<Object?> values) {
    final map = <int, B>{};
    for (var i = 0; i < values.length; i++) {
      map[i] = values[i] as B;
    }
    return map;
  }

  static Map<A, int> indexAsValueMap<A>(List<Object?> keys) {
    final map = <A, int>{};
    for (var i = 0; i < keys.length; i++) {
      map[keys[i] as A] = i;
    }
    return map;
  }

  static String convertIntegerToKhmerNumber(int number) {
    final text = number.toString();
    final buffer = StringBuffer();

    for (final rune in text.runes) {
      final char = String.fromCharCode(rune);
      buffer.write(Constant.numbers[char] ?? char);
    }

    return buffer.toString();
  }

  static String? getDayOfWeekInKhmer(DateTime dateTime) {
    const englishDaysByWeekday = <int, String>{
      DateTime.monday: 'MONDAY',
      DateTime.tuesday: 'TUESDAY',
      DateTime.wednesday: 'WEDNESDAY',
      DateTime.thursday: 'THURSDAY',
      DateTime.friday: 'FRIDAY',
      DateTime.saturday: 'SATURDAY',
      DateTime.sunday: 'SUNDAY',
    };

    final dayKey = englishDaysByWeekday[dateTime.weekday];
    if (dayKey == null) {
      return null;
    }
    return Constant.dayOfWeek[dayKey];
  }
}
