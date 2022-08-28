import 'package:json_annotation/json_annotation.dart';

import 'team.dart';
import '../league/league.dart';
import '../../interfaces/deserializable.dart';

part 'team_statistics.g.dart';

@JsonSerializable()
class MatchesStatistics implements Deserializable {
  MatchesStatistics({
    required this.home,
    required this.away,
    required this.total,
  });

  final int home;
  final int away;
  final int total;

  factory MatchesStatistics.fromJson(Map<String, dynamic> json) => _$MatchesStatisticsFromJson(json);

  @override
  MatchesStatistics Function(Map<String, dynamic> object) get deserialize => MatchesStatistics.fromJson;
}

@JsonSerializable()
class TeamStatisticsFixtures implements Deserializable {
  TeamStatisticsFixtures({
    required this.played,
    required this.wins,
    required this.draws,
    required this.loses,
  });

  final MatchesStatistics played;
  final MatchesStatistics wins;
  final MatchesStatistics draws;
  final MatchesStatistics loses;

  factory TeamStatisticsFixtures.fromJson(Map<String, dynamic> json) => _$TeamStatisticsFixturesFromJson(json);

  @override
  TeamStatisticsFixtures Function(Map<String, dynamic> object) get deserialize => TeamStatisticsFixtures.fromJson;
}

@JsonSerializable()
class TeamStatistics implements Deserializable {
  TeamStatistics({
    required this.league,
    required this.basicTeamInfo,
    required this.fixtures,
  });

  final League league;
  @JsonKey(name: 'team')
  final BasicTeamInfo basicTeamInfo;
  final TeamStatisticsFixtures fixtures;

  factory TeamStatistics.fromJson(Map<String, dynamic> json) => _$TeamStatisticsFromJson(json);

  @override
  TeamStatistics Function(Map<String, dynamic> object) get deserialize => TeamStatistics.fromJson;
}