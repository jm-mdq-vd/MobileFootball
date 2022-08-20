import 'package:json_annotation/json_annotation.dart';

import '../team/team.dart';
import '../../interfaces/deserializable.dart';

part 'team_standing.g.dart';

@JsonSerializable()
class Matches implements Deserializable {
  final int played;
  final int win;
  final int draw;
  final int lose;

  Matches({
    required this.played,
    required this.win,
    required this.draw,
    required this.lose,
  });

  factory Matches.fromJson(Map<String, dynamic> json) => _$MatchesFromJson(json);

  @override
  Matches Function(Map<String, dynamic> object) get deserialize => Matches.fromJson;
}

@JsonSerializable()
class TeamStanding implements Deserializable {
  final int rank;
  final int points;
  final Team team;
  @JsonKey(name: 'goalsDiff')
  final int goalsDifference;
  final String? group;
  final String status;
  final String? description;
  final Matches all;
  final Matches home;
  final Matches away;

  TeamStanding({
    required this.rank,
    required this.points,
    required this.team,
    required this.goalsDifference,
    required this.group,
    required this.status,
    required this.description,
    required this.all,
    required this.home,
    required this.away,
  });

  factory TeamStanding.fromJson(Map<String, dynamic> json) => _$TeamStandingFromJson(json);

  @override
  TeamStanding Function(Map<String, dynamic> object) get deserialize => TeamStanding.fromJson;
}