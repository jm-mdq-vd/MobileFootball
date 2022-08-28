// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_statistics.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MatchesStatistics _$MatchesStatisticsFromJson(Map<String, dynamic> json) =>
    MatchesStatistics(
      home: json['home'] as int,
      away: json['away'] as int,
      total: json['total'] as int,
    );

Map<String, dynamic> _$MatchesStatisticsToJson(MatchesStatistics instance) =>
    <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
      'total': instance.total,
    };

TeamStatisticsFixtures _$TeamStatisticsFixturesFromJson(
        Map<String, dynamic> json) =>
    TeamStatisticsFixtures(
      played:
          MatchesStatistics.fromJson(json['played'] as Map<String, dynamic>),
      wins: MatchesStatistics.fromJson(json['wins'] as Map<String, dynamic>),
      draws: MatchesStatistics.fromJson(json['draws'] as Map<String, dynamic>),
      loses: MatchesStatistics.fromJson(json['loses'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamStatisticsFixturesToJson(
        TeamStatisticsFixtures instance) =>
    <String, dynamic>{
      'played': instance.played,
      'wins': instance.wins,
      'draws': instance.draws,
      'loses': instance.loses,
    };

TeamStatistics _$TeamStatisticsFromJson(Map<String, dynamic> json) =>
    TeamStatistics(
      league: League.fromJson(json['league'] as Map<String, dynamic>),
      basicTeamInfo:
          BasicTeamInfo.fromJson(json['team'] as Map<String, dynamic>),
      fixtures: TeamStatisticsFixtures.fromJson(
          json['fixtures'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamStatisticsToJson(TeamStatistics instance) =>
    <String, dynamic>{
      'league': instance.league,
      'team': instance.basicTeamInfo,
      'fixtures': instance.fixtures,
    };
