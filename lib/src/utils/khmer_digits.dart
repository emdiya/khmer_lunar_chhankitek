const List<String> _khmerDigits = <String>[
  '០',
  '១',
  '២',
  '៣',
  '៤',
  '៥',
  '៦',
  '៧',
  '៨',
  '៩',
];

String toKhmerDigits(Object input) {
  final text = input.toString();
  final buffer = StringBuffer();

  for (final codePoint in text.runes) {
    final char = String.fromCharCode(codePoint);
    final digit = int.tryParse(char);
    if (digit == null) {
      buffer.write(char);
    } else {
      buffer.write(_khmerDigits[digit]);
    }
  }

  return buffer.toString();
}
