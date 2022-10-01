// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Time _$TimeFromJson(Map<String, dynamic> json) => Time(
      elapsed: json['elapsed'] as int,
      extra: json['extra'] as int?,
    );

Map<String, dynamic> _$TimeToJson(Time instance) => <String, dynamic>{
      'elapsed': instance.elapsed,
      'extra': instance.extra,
    };

FixtureEvent _$FixtureEventFromJson(Map<String, dynamic> json) => FixtureEvent(
      time: Time.fromJson(json['time'] as Map<String, dynamic>),
      team: BasicTeamInfo.fromJson(json['team'] as Map<String, dynamic>),
      player: BasicPlayerInfo.fromJson(json['player'] as Map<String, dynamic>),
      type: json['type'] as String,
      details: json['details'] as String,
      comments: json['comments'] as String?,
    );

Map<String, dynamic> _$FixtureEventToJson(FixtureEvent instance) =>
    <String, dynamic>{
      'time': instance.time,
      'team': instance.team,
      'player': instance.player,
      'type': instance.type,
      'details': instance.details,
      'comments': instance.comments,
    };
