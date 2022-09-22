abstract class ScreenRequirements {
  Map<String, dynamic> get _values;
}

class LeagueSeasonRequirements implements ScreenRequirements {
  LeagueSeasonRequirements({required Map<String, dynamic> values}) : _values = values;

  static String get titleKey => 'title';
  static String get leagueKey => 'leagueId';
  static String get seasonKey => 'season';

  @override
  Map<String, dynamic> _values;

  String get title => _values[titleKey];
  String get leagueId => _values[leagueKey];
  String get season => _values[seasonKey];
}