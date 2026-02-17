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
  khmer_lunar_chhankitek: ^1.0.0
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
Uposatha: false
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
