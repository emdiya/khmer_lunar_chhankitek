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
