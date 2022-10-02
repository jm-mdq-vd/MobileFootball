// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_squad.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SquadMember _$SquadMemberFromJson(Map<String, dynamic> json) => SquadMember(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int?,
      number: json['number'] as int?,
      position: json['position'] as String,
      photo: json['photo'] as String?,
    );

Map<String, dynamic> _$SquadMemberToJson(SquadMember instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'number': instance.number,
      'position': instance.position,
      'photo': instance.photo,
    };

TeamSquad _$TeamSquadFromJson(Map<String, dynamic> json) => TeamSquad(
      team: BasicTeamInfo.fromJson(json['team'] as Map<String, dynamic>),
      players: (json['players'] as List<dynamic>)
          .map((e) => SquadMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TeamSquadToJson(TeamSquad instance) => <String, dynamic>{
      'team': instance.team,
      'players': instance.players,
    };
