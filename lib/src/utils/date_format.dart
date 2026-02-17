String twoDigits(int value) => value.toString().padLeft(2, '0');

String formatIsoDate(DateTime date) {
  return '${date.year}-${twoDigits(date.month)}-${twoDigits(date.day)}';
}

String formatIsoDateTime(DateTime date) {
  return '${formatIsoDate(date)} '
      '${twoDigits(date.hour)}:${twoDigits(date.minute)}:${twoDigits(date.second)}';
}
