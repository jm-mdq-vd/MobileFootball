import 'package:equatable/equatable.dart';

enum FixturesKeys {
  events,
  lineups,
  fixturesStatistics,
  playersStatistics,
}

extension FixturesKeysX on FixturesKeys {
  String get key {
    switch (this) {
      case FixturesKeys.events:
        return 'events';
      case FixturesKeys.lineups:
        return 'lineups';
      case FixturesKeys.fixturesStatistics:
        return 'fixtures_statistics';
      case FixturesKeys.playersStatistics:
        return 'players_statistics';
    }
  }
}

class LeagueSeason extends Equatable {
  const LeagueSeason({
    required this.year,
    required this.startDate,
    required this.endDate,
    required this.fixtures,
    required this.isCurrent,
    required this.hasPredictions,
  });

  final int year;
  final String startDate;
  final String endDate;
  final bool isCurrent;
  final bool hasPredictions;

  final Map<String, bool> fixtures;

  bool get hasEvents => fixtures[FixturesKeys.events.key] ?? false;
  bool get hasLineups => fixtures[FixturesKeys.lineups.key] ?? false;
  bool get hasFixturesStatistics => fixtures[FixturesKeys.fixturesStatistics.key] ?? false;
  bool get hasPlayersStatistics => fixtures[FixturesKeys.playersStatistics.key] ?? false;

  @override
  List<Object> get props => [
    year,
    startDate,
    endDate,
    isCurrent,
    hasPredictions,
  ];
}