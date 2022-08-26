// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'standing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueStanding _$LeagueStandingFromJson(Map<String, dynamic> json) =>
    LeagueStanding(
      id: json['id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
      logo: json['logo'] as String,
      flag: json['flag'] as String,
      season: json['season'] as int,
      standings: (json['standings'] as List<dynamic>)
          .map((e) => (e as List<dynamic>)
              .map((e) => TeamStanding.fromJson(e as Map<String, dynamic>))
              .toList())
          .toList(),
    );

Map<String, dynamic> _$LeagueStandingToJson(LeagueStanding instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'logo': instance.logo,
      'flag': instance.flag,
      'season': instance.season,
      'standings': instance.standings,
    };

Standing _$StandingFromJson(Map<String, dynamic> json) => Standing(
      league: LeagueStanding.fromJson(json['league'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$StandingToJson(Standing instance) => <String, dynamic>{
      'league': instance.league,
    };
