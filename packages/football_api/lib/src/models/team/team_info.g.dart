// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TeamInfo _$TeamInfoFromJson(Map<String, dynamic> json) => TeamInfo(
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      venue: Venue.fromJson(json['venue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamInfoToJson(TeamInfo instance) => <String, dynamic>{
      'team': instance.team,
      'venue': instance.venue,
    };
