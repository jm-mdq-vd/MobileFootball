import 'package:json_annotation/json_annotation.dart';
import '../../interfaces/deserializable.dart';

part 'coverage.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class FixturesCoverage implements Deserializable {
  final bool events;
  final bool lineups;
  final bool statisticsFixtures;
  final bool statisticsPlayers;

  FixturesCoverage({
    required this.events,
    required this.lineups,
    required this.statisticsFixtures,
    required this.statisticsPlayers,
  });

  factory FixturesCoverage.fromJson(Map<String, dynamic> json) => _$FixturesCoverageFromJson(json);

  @override
  FixturesCoverage Function(Map<String, dynamic> object) get deserialize => FixturesCoverage.fromJson;
}

@JsonSerializable()
class Coverage implements Deserializable {
  final FixturesCoverage fixtures;
  final bool standings;
  final bool players;
  final bool predictions;
  final bool odds;

  Coverage({
    required this.fixtures,
    required this.standings,
    required this.players,
    required this.predictions,
    required this.odds,
  });

  factory Coverage.fromJson(Map<String, dynamic> json) => _$CoverageFromJson(json);

  @override
  Coverage Function(Map<String, dynamic> object) get deserialize => Coverage.fromJson;
}