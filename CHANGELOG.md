## 1.0.2

### Fixed

- Unified structured lunar dates and Khmer formatting around the traditional
  Chhankitek calculation, replacing approximate moon-age/month rules.
- Corrected lunar month, Buddhist Era, and full/new moon observance results;
  `isUposatha` now agrees with `isSilDay`.
- Removed next-day lookups from Kor detection so the final supported date works.
- Applied the supported-year range to Khmer formatted conversion too.
- Used UTC civil-date arithmetic and ignored input time consistently.
- Cached lunar year calculations and Visakha Bochea dates for formatting.
- Corrected previous-year and solar quadrant lookups in New Year calculations.
- Corrected README output and example date labels.

### Changed

- Calendar corrections change previously returned dates and observance flags.
- Documented repeated Asadh month indices 13/14 and civil-date conventions.

### Tests

- Added published 2026 calendar fixtures, Buddhist Era transition checks,
  API consistency, supported boundaries, and full-range lunar continuity checks.

## 1.0.1

- Refined `KhmerLunar.isKorDay` to only mark days before major sil observances
  (full/new moon), excluding quarter sil (8th-day) transitions.
- Added a regression test for `2026-03-10` to ensure `7 roch` before a quarter
  sil day is not returned as `ថ្ងៃកោរ`.

## 1.0.0

- Initial public release.
- Added Khmer lunar engine APIs: `KhmerLunar.day`, `KhmerLunar.month`, `KhmerLunar.year`.
- Added Buddhist observance helpers: `KhmerLunar.isSilDay`, `KhmerLunar.isKorDay`.
- Added Khmer formatted lunar date API: `Chhankitek.toKhmerLunarDateFormat`.
- Added Khmer New Year calculation API: `KhmerNewYearCal`.
- Added Khmer formatting utilities, including `formatKhmerGregorianDate` and Khmer digits conversion.
- Added tests for known dates, formatting, and year generation.
