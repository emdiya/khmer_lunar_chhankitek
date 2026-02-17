class InvalidYearRangeException implements Exception {
  InvalidYearRangeException(this.year, this.min, this.max);

  final int year;
  final int min;
  final int max;

  @override
  String toString() {
    return 'InvalidYearRangeException: year $year is outside supported range $min-$max.';
  }
}

class KhmerMonthException implements Exception {
  KhmerMonthException(this.message);

  final String message;

  @override
  String toString() => 'KhmerMonthException: $message';
}

class VisakhabocheaException implements Exception {
  VisakhabocheaException(this.message);

  final String message;

  @override
  String toString() => 'VisakhabocheaException: $message';
}

class SotinException implements Exception {
  SotinException(this.message);

  final String message;

  @override
  String toString() => 'SotinException: $message';
}
