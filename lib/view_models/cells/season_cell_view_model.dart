import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

class SeasonCellViewModel implements BaseCellRepresentable {
  const SeasonCellViewModel({required LeagueSeason season}) : _season = season;

  final LeagueSeason _season;

  @override
  String get title => _season.year.toString();

  @override
  String get id => _season.year.toString();

  bool get showEvents => _season.hasEvents;
  bool get showLineups => _season.hasLineups;
  bool get showPlayersStatistics => _season.hasPlayersStatistics;
  bool get showFixturesStatistics => _season.hasFixturesStatistics;
}