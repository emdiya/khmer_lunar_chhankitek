String normalizeKhmerText(String input) {
  return input
      .replaceAll('\u200B', '')
      .replaceAll('\u00A0', ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
}
