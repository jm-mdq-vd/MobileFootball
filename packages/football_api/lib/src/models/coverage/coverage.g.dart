// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coverage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixturesCoverage _$FixturesCoverageFromJson(Map<String, dynamic> json) =>
    FixturesCoverage(
      events: json['events'] as bool,
      lineups: json['lineups'] as bool,
      statisticsFixtures: json['statistics_fixtures'] as bool,
      statisticsPlayers: json['statistics_players'] as bool,
    );

Map<String, dynamic> _$FixturesCoverageToJson(FixturesCoverage instance) =>
    <String, dynamic>{
      'events': instance.events,
      'lineups': instance.lineups,
      'statistics_fixtures': instance.statisticsFixtures,
      'statistics_players': instance.statisticsPlayers,
    };

Coverage _$CoverageFromJson(Map<String, dynamic> json) => Coverage(
      fixtures:
          FixturesCoverage.fromJson(json['fixtures'] as Map<String, dynamic>),
      standings: json['standings'] as bool,
      players: json['players'] as bool,
      predictions: json['predictions'] as bool,
      odds: json['odds'] as bool,
    );

Map<String, dynamic> _$CoverageToJson(Coverage instance) => <String, dynamic>{
      'fixtures': instance.fixtures,
      'standings': instance.standings,
      'players': instance.players,
      'predictions': instance.predictions,
      'odds': instance.odds,
    };
