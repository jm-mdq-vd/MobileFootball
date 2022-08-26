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
/// {
///   "rank":1,
//    "team": {
//      "id":455,
//      "name":"Atletico Tucuman",
//      "logo":"https://media.api-sports.io/football/teams/455.png"
//    },
//    "points":32,
//    "goalsDiff":12,
//    "group":"Liga Profesional Argentina: 2nd Phase",
//    "form":"WDWLW",
//    "status":"same",
//    "description":"CONMEBOL Libertadores",
//    "all":{
//      "played":15,
//      "win":9,
//      "draw":5,
//      "lose":1,
//      "goals":{
//        "for":18,
//        "against":6
//      }
//    },
//    "home":{
//      "played":8,
//      "win":6,
//      "draw":2,
//      "lose":0,
//      "goals":{
//        "for":14,
//        "against":3
//      }
//    },
//    "away":{
//      "played":7,
//      "win":3,
//      "draw":3,
//      "lose":1,
//      "goals":{
//        "for":4,
//        "against":3
//      }
//    },
//    "update":"2022-08-24T00:00:00+00:00"
//  },
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