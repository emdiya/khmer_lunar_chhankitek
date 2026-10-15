# Khmer Lunar Chhankitek

Khmer lunar date calculation, Khmer New Year helpers, and Khmer date formatting in pure Dart.

## Features

- Khmer lunar engine with day, month, and year APIs
- Khmer formatted lunar date via `Chhankitek.toKhmerLunarDateFormat(...)`
- Buddhist observance helpers: `KhmerLunar.isSilDay(...)`, `KhmerLunar.isKorDay(...)`
- Khmer New Year calculation via `KhmerNewYearCal`
- Khmer formatting helpers, including Gregorian date in Khmer style
- Pure Dart (works in Flutter, CLI, and server-side Dart)

## API Overview

- `KhmerLunar`
  - `day(DateTime)`
  - `month(int year, int month)`
  - `year(int year)`
  - `isSilDay(DateTime)`
  - `isKorDay(DateTime)`
- `Chhankitek`
  - `toKhmerLunarDateFormat(DateTime)`
- `KhmerNewYearCal`
  - `KhmerNewYearCal(jsYear).khmerNewYear`
- Formatting utilities
  - `toKhmerDigits(...)`
  - `formatKhmerGregorianDate(DateTime)`
  - `formatIsoDate(...)`, `formatIsoDateTime(...)`

## Installation

```yaml
dependencies:
  khmer_lunar_chhankitek: ^1.0.1
```

## Quick Start

```dart
import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';

void main() {
  final date = DateTime(2026, 4, 16);
  final day = KhmerLunar.day(date);
  final monthDays = KhmerLunar.month(date.year, date.month);
  final khmerDate = Chhankitek.toKhmerLunarDateFormat(date);

  print(khmerDate.toString());
  print(formatKhmerGregorianDate(date));
  print('Uposatha: ${day.isUposatha}');
  print('Days this month: ${monthDays.length}');

  final isSil = KhmerLunar.isSilDay(date);
  final isKor = KhmerLunar.isKorDay(date);
  print('ថ្ងៃសីល: $isSil');
  print('ថ្ងៃកោរ: $isKor');
  print(
    '${formatKhmerGregorianDate(date)} ជា'
    '${isSil ? 'ថ្ងៃសីល' : (isKor ? 'ថ្ងៃកោរ' : 'ថ្ងៃធម្មតា')}',
  );
}
```

Example output:

```text
ថ្ងៃព្រហស្បតិ៍ ១៤រោច ខែចេត្រ ឆ្នាំមមីរ អដ្ឋស័ក ព.ស.២៥៦៩
ថ្ងៃទី១៦ ខែមេសា ឆ្នាំ២០២៦
Uposatha: true
Days this month: 30
ថ្ងៃសីល: true
ថ្ងៃកោរ: false
ថ្ងៃទី១៦ ខែមេសា ឆ្នាំ២០២៦ ជាថ្ងៃសីល
```

## Khmer Formatted Lunar Date

```dart
import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';

void main() {
  final khmerDate = Chhankitek.toKhmerLunarDateFormat(DateTime(2026, 1, 3));
  print(khmerDate.toString());
}
```

Example output:

```text
ថ្ងៃសៅរ៍ ១៥កើត ពេញបូណ៌មី ខែបុស្ស ឆ្នាំម្សាញ់ សប្ដស័ក ព.ស.២៥៦៩
```

## Khmer New Year Calculation

```dart
import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';

void main() {
  final jsYear = (2026 + 544) - 1182;
  final ny = KhmerNewYearCal(jsYear).khmerNewYear;

  print('hour: ${ny.timeOfNewYear.hour}');
  print('minute: ${ny.timeOfNewYear.minute}');
  print('dayLerngSak: ${ny.dayLerngSak}');
}
```

Example output:

```text
hour: 10
minute: 48
dayLerngSak: 3
```

## Supported Range

- `KhmerLunar.day(...)` and `KhmerLunar.year(...)`: `1900` to `2100`
- Out-of-range values throw `InvalidYearRangeException`
- `KhmerLunar.month(...)` accepts `1..12`

## Testing

```bash
dart analyze
dart test
```

## Calendar conventions

All lunar APIs use the same traditional Chhankitek calculation. `isUposatha`
and `isSilDay` identify the 8th and 15th waxing days, the 8th waning day,
and the last waning day (14 or 15). Kor days precede full/new moon observances.
Buddhist Era changes on the day after the full moon of Pisakh.

Inputs are civil dates: their year, month, and day fields are used without
converting time zones; the time of day is ignored, including for the formatted
zodiac/era. Convert an instant into the intended local date before calling.
Internal date arithmetic uses UTC to avoid daylight-saving shifts.
`LunarDay.date` remains a local midnight date.

`LunarMonth.index` is 1-based: regular months use 1–12, first Asadh uses 13,
and second Asadh uses 14. Both repeated Asadh months have `isLeapMonth: true`.
`lunarDay` is 1–15 for waxing and 16–29/30 for waning.

The supported civil-date range is 1900–2100 for all lunar conversion and
observance APIs, including `Chhankitek.toKhmerLunarDateFormat`.
