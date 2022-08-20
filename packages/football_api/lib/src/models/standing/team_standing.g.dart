// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_standing.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Matches _$MatchesFromJson(Map<String, dynamic> json) => Matches(
      played: json['played'] as int,
      win: json['win'] as int,
      draw: json['draw'] as int,
      lose: json['lose'] as int,
    );

Map<String, dynamic> _$MatchesToJson(Matches instance) => <String, dynamic>{
      'played': instance.played,
      'win': instance.win,
      'draw': instance.draw,
      'lose': instance.lose,
    };

TeamStanding _$TeamStandingFromJson(Map<String, dynamic> json) => TeamStanding(
      rank: json['rank'] as int,
      points: json['points'] as int,
      team: Team.fromJson(json['team'] as Map<String, dynamic>),
      goalsDifference: json['goalsDiff'] as int,
      group: json['group'] as String?,
      status: json['status'] as String,
      description: json['description'] as String?,
      all: Matches.fromJson(json['all'] as Map<String, dynamic>),
      home: Matches.fromJson(json['home'] as Map<String, dynamic>),
      away: Matches.fromJson(json['away'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamStandingToJson(TeamStanding instance) =>
    <String, dynamic>{
      'rank': instance.rank,
      'points': instance.points,
      'team': instance.team,
      'goalsDiff': instance.goalsDifference,
      'group': instance.group,
      'status': instance.status,
      'description': instance.description,
      'all': instance.all,
      'home': instance.home,
      'away': instance.away,
    };
