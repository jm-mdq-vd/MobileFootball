import 'package:json_annotation/json_annotation.dart';

import 'team_standing.dart';
import '../../interfaces/deserializable.dart';

part 'standing.g.dart';

@JsonSerializable()
class LeagueStanding {
  LeagueStanding({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.season,
    required this.standings,
  });

  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final int season;
  final List<List<TeamStanding>> standings;

  factory LeagueStanding.fromJson(Map<String, dynamic> json) => _$LeagueStandingFromJson(json);
}

@JsonSerializable()
class Standing {
  Standing({
    required this.league,
  });

  final LeagueStanding league;

  factory Standing.fromJson(Map<String, dynamic> json) => _$StandingFromJson(json);
}