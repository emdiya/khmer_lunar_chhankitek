class BeYearRule {
  const BeYearRule();

  int apply(DateTime date) {
    final newYearStart = DateTime(date.year, 4, 14);
    if (date.isBefore(newYearStart)) {
      return date.year + 542;
    }
    return date.year + 543;
  }
}
