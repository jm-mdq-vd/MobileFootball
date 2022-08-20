import 'package:json_annotation/json_annotation.dart';

import '../team/team.dart';
import '../league/league.dart';
import '../../interfaces/deserializable.dart';

part 'player_info.g.dart';

@JsonSerializable()
class Player implements Deserializable {
  final int id;
  final String name;
  final String firstname;
  final String lastname;
  final int age;
  final String nationality;
  final String height;
  final String weight;
  final bool injured;
  final String photo;

  Player({
    required this.id,
    required this.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.injured,
    required this.photo,
  });

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  @override
  Player Function(Map<String, dynamic> object) get deserialize => Player.fromJson;
}

@JsonSerializable()
class PlayerStatistics implements Deserializable {
  final BasicTeamInfo team;
  final League league;

  PlayerStatistics({
    required this.team,
    required this.league
  });

  factory PlayerStatistics.fromJson(Map<String, dynamic> json) => _$PlayerStatisticsFromJson(json);

  @override
  PlayerStatistics Function(Map<String, dynamic> object) get deserialize => PlayerStatistics.fromJson;
}

@JsonSerializable()
class PlayerInfo implements Deserializable {
  final Player player;
  final PlayerStatistics statistics;

  PlayerInfo({
    required this.player,
    required this.statistics,
  });

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => _$PlayerInfoFromJson(json);

  @override
  PlayerInfo Function(Map<String, dynamic> object) get deserialize => PlayerInfo.fromJson;
}