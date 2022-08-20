import 'package:json_annotation/json_annotation.dart';
import '../../interfaces/deserializable.dart';

part 'team.g.dart';

/// A single team from https://v3.football.api-sports.io/teams?league=<league's id>&season=<season's code>
/// {
//    "id": 434,
//    "name": "Gimnasia L.P.",
//    "code": "GIM",
//    "country": "Argentina",
//    "founded": 1887,
//    "national": false,
//    "logo": "https://media.api-sports.io/football/teams/434.png"
// }

@JsonSerializable()
class BasicTeamInfo implements Deserializable {
  final int id;
  final String name;
  final String logo;

  BasicTeamInfo({
    required this.id,
    required this.name,
    required this.logo
  });

  factory BasicTeamInfo.fromJson(Map<String, dynamic> json) => _$BasicTeamInfoFromJson(json);

  @override
  BasicTeamInfo Function(Map<String, dynamic> object) get deserialize => BasicTeamInfo.fromJson;
}

@JsonSerializable()
class Team extends BasicTeamInfo implements Deserializable {
  final String? code;
  final String country;
  final int? founded;

  Team({
    required super.id,
    required super.name,
    required super.logo,
    required this.code,
    required this.country,
    required this.founded,
  });

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  @override
  Team Function(Map<String, dynamic> object) get deserialize => Team.fromJson;
}