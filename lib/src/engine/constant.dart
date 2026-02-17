class Constant {
  Constant._();

  static const Map<String, String> numbers = <String, String>{
    '0': '០',
    '1': '១',
    '2': '២',
    '3': '៣',
    '4': '៤',
    '5': '៥',
    '6': '៦',
    '7': '៧',
    '8': '៨',
    '9': '៩',
  };

  static const Map<String, String> dayOfWeek = <String, String>{
    'SUNDAY': 'អាទិត្យ',
    'MONDAY': 'ច័ន្ទ',
    'TUESDAY': 'អង្គារ',
    'WEDNESDAY': 'ពុធ',
    'THURSDAY': 'ព្រហស្បតិ៍',
    'FRIDAY': 'សុក្រ',
    'SATURDAY': 'សៅរ៍',
  };

  static const Map<String, int> lunarMonths = <String, int>{
    'មិគសិរ': 0,
    'បុស្ស': 1,
    'មាឃ': 2,
    'ផល្គុន': 3,
    'ចេត្រ': 4,
    'ពិសាខ': 5,
    'ជេស្ឋ': 6,
    'អាសាឍ': 7,
    'ស្រាពណ៍': 8,
    'ភទ្របទ': 9,
    'អស្សុជ': 10,
    'កក្ដិក': 11,
    'បឋមាសាឍ': 12,
    'ទុតិយាសាឍ': 13,
  };

  static const Map<int, String> lunarMonthsFormat = <int, String>{
    0: 'មិគសិរ',
    1: 'បុស្ស',
    2: 'មាឃ',
    3: 'ផល្គុន',
    4: 'ចេត្រ',
    5: 'ពិសាខ',
    6: 'ជេស្ឋ',
    7: 'អាសាឍ',
    8: 'ស្រាពណ៍',
    9: 'ភទ្របទ',
    10: 'អស្សុជ',
    11: 'កក្ដិក',
    12: 'បឋមាសាឍ',
    13: 'ទុតិយាសាឍ',
  };

  static const Map<String, int> solarMonths = <String, int>{
    'JAN': 0,
    'FEB': 1,
    'MAR': 2,
    'APR': 3,
    'MAY': 4,
    'JUN': 5,
    'JUL': 6,
    'AUG': 7,
    'SEP': 8,
    'OCT': 9,
    'NOV': 10,
    'DEC': 11,
  };

  static const Map<int, String> khmerSolarMonths = <int, String>{
    1: 'មករា',
    2: 'កុម្ភៈ',
    3: 'មីនា',
    4: 'មេសា',
    5: 'ឧសភា',
    6: 'មិថុនា',
    7: 'កក្កដា',
    8: 'សីហា',
    9: 'កញ្ញា',
    10: 'តុលា',
    11: 'វិច្ឆិកា',
    12: 'ធ្នូ',
  };

  static const Map<int, String> animalYear = <int, String>{
    0: 'ជូត',
    1: 'ឆ្លូវ',
    2: 'ខាល',
    3: 'ថោះ',
    4: 'រោង',
    5: 'ម្សាញ់',
    6: 'មមីរ',
    7: 'មមែ',
    8: 'វក',
    9: 'រកា',
    10: 'ច',
    11: 'កុរ',
  };

  static const Map<int, String> eraYear = <int, String>{
    0: 'សំរឹទ្ធិស័ក',
    1: 'ឯកស័ក',
    2: 'ទោស័ក',
    3: 'ត្រីស័ក',
    4: 'ចត្វាស័ក',
    5: 'បញ្ចស័ក',
    6: 'ឆស័ក',
    7: 'សប្ដស័ក',
    8: 'អដ្ឋស័ក',
    9: 'នព្វស័ក',
  };

  static const Map<String, int> moonStatus = <String, int>{'កើត': 0, 'រោច': 1};
}
