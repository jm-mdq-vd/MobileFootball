// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'league_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LeagueInfo _$LeagueInfoFromJson(Map<String, dynamic> json) => LeagueInfo(
      league: League.fromJson(json['league'] as Map<String, dynamic>),
      country: Country.fromJson(json['country'] as Map<String, dynamic>),
      seasons: (json['seasons'] as List<dynamic>)
          .map((e) => Season.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LeagueInfoToJson(LeagueInfo instance) =>
    <String, dynamic>{
      'league': instance.league,
      'country': instance.country,
      'seasons': instance.seasons,
    };
