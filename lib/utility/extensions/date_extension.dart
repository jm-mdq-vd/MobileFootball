extension DateUtils on DateTime {
  String get dayMonthYear => '${this.day}-${this.month}-${this.year}';
}