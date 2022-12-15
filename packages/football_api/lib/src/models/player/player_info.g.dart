// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicPlayerInfo _$BasicPlayerInfoFromJson(Map<String, dynamic> json) =>
    BasicPlayerInfo(
      id: json['id'] as int?,
      name: json['name'] as String,
    );

Map<String, dynamic> _$BasicPlayerInfoToJson(BasicPlayerInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };

BirthInfo _$BirthInfoFromJson(Map<String, dynamic> json) => BirthInfo(
      date: json['date'] as String?,
      place: json['place'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$BirthInfoToJson(BirthInfo instance) => <String, dynamic>{
      'date': instance.date,
      'place': instance.place,
      'country': instance.country,
    };

Player _$PlayerFromJson(Map<String, dynamic> json) => Player(
      id: json['id'] as int?,
      name: json['name'] as String,
      firstname: json['firstname'] as String,
      lastname: json['lastname'] as String,
      age: json['age'] as int?,
      nationality: json['nationality'] as String,
      height: json['height'] as String,
      weight: json['weight'] as String,
      injured: json['injured'] as bool,
      photo: json['photo'] as String,
      birth: BirthInfo.fromJson(json['birth'] as Map<String, dynamic>),
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
      'birth': instance.birth,
    };

PlayerStatistics _$PlayerStatisticsFromJson(Map<String, dynamic> json) =>
    PlayerStatistics(
      team: BasicTeamInfo.fromJson(json['team'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PlayerStatisticsToJson(PlayerStatistics instance) =>
    <String, dynamic>{
      'team': instance.team,
    };

PlayerInfo _$PlayerInfoFromJson(Map<String, dynamic> json) => PlayerInfo(
      player: Player.fromJson(json['player'] as Map<String, dynamic>),
      statistics: (json['statistics'] as List<dynamic>)
          .map((e) => PlayerStatistics.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlayerInfoToJson(PlayerInfo instance) =>
    <String, dynamic>{
      'player': instance.player,
      'statistics': instance.statistics,
    };
