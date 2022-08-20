// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: json['id'] as int,
      name: json['name'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      age: json['age'] as int,
      nationality: json['nationality'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      injured: json['injured'] as bool,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$PlayerToJson(Player instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'age': instance.age,
      'nationality': instance.nationality,
      'height': instance.height,
      'weight': instance.weight,
      'injured': instance.injured,
      'photo': instance.photo,
    };

PlayerStatistics _$PlayerStatisticsFromJson(Map<String, dynamic> json) =>
    PlayerStatistics(
      team: BasicTeamInfo.fromJson(json['team'] as Map<String, dynamic>),
      league: League.fromJson(json['league'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerStatisticsToJson(PlayerStatistics instance) =>
    <String, dynamic>{
      'team': instance.team,
      'league': instance.league,
    };

PlayerInfo _$PlayerInfoFromJson(Map<String, dynamic> json) => PlayerInfo(
      player: Player.fromJson(json['player'] as Map<String, dynamic>),
      statistics:
          PlayerStatistics.fromJson(json['statistics'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerInfoToJson(PlayerInfo instance) =>
    <String, dynamic>{
      'player': instance.player,
      'statistics': instance.statistics,
    };
