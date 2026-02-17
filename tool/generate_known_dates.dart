import 'package:khmer_lunar_chhankitek/khmer_lunar_chhankitek.dart';

void main(List<String> args) {
  final year = args.isEmpty ? DateTime.now().year : int.parse(args.first);
  final days = KhmerLunar.year(year);

  for (final day in days.where((d) => d.isUposatha)) {
    print(
      '${formatIsoDate(day.date)},${day.khmerMonth},${day.isFullMoon},${day.isNewMoon}',
    );
  }
}
