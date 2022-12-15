import 'package:json_annotation/json_annotation.dart';

import '../team/team.dart';
import '../league/league.dart';
import '../../interfaces/deserializable.dart';

part 'player_info.g.dart';

@JsonSerializable()
class BasicPlayerInfo implements Deserializable {
  BasicPlayerInfo({
    required this.id,
    required this.name,
  });

  final int? id;
  final String name;

  factory BasicPlayerInfo.fromJson(Map<String, dynamic> json) => _$BasicPlayerInfoFromJson(json);

  @override
  BasicPlayerInfo Function(Map<String, dynamic> object) get deserialize => BasicPlayerInfo.fromJson;
}

@JsonSerializable()
class BirthInfo implements Deserializable {
  BirthInfo({
    required this.date,
    required this.place,
    required this.country,
  });

  final String? date;
  final String? place;
  final String? country;

  factory BirthInfo.fromJson(Map<String, dynamic> json) => _$BirthInfoFromJson(json);

  @override
  BirthInfo Function(Map<String, dynamic> object) get deserialize => BirthInfo.fromJson;
}

@JsonSerializable()
class Player extends BasicPlayerInfo implements Deserializable {
  Player({
    required super.id,
    required super.name,
    required this.firstname,
    required this.lastname,
    required this.age,
    required this.nationality,
    required this.height,
    required this.weight,
    required this.injured,
    required this.photo,
    required this.birth,
  });

  final String firstname;
  final String lastname;
  final int? age;
  final String nationality;
  final String height;
  final String weight;
  final bool injured;
  final String photo;
  final BirthInfo birth;

  factory Player.fromJson(Map<String, dynamic> json) => _$PlayerFromJson(json);

  @override
  Player Function(Map<String, dynamic> object) get deserialize => Player.fromJson;
}

@JsonSerializable()
class PlayerStatistics implements Deserializable {
  PlayerStatistics({
    required this.team,
    // required this.league
  });

  final BasicTeamInfo team;
  // final League league;

  factory PlayerStatistics.fromJson(Map<String, dynamic> json) => _$PlayerStatisticsFromJson(json);

  @override
  PlayerStatistics Function(Map<String, dynamic> object) get deserialize => PlayerStatistics.fromJson;
}

@JsonSerializable()
class PlayerInfo implements Deserializable {
  PlayerInfo({
    required this.player,
    required this.statistics,
  });

  final Player player;
  final List<PlayerStatistics> statistics;

  factory PlayerInfo.fromJson(Map<String, dynamic> json) => _$PlayerInfoFromJson(json);

  @override
  PlayerInfo Function(Map<String, dynamic> object) get deserialize => PlayerInfo.fromJson;
}