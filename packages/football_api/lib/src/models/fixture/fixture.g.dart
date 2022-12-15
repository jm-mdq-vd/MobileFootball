// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fixture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FixtureTeam _$FixtureTeamFromJson(Map<String, dynamic> json) => FixtureTeam(
      id: json['id'] as int,
      name: json['name'] as String,
      logo: json['logo'] as String,
      winner: json['winner'] as bool?,
    );

Map<String, dynamic> _$FixtureTeamToJson(FixtureTeam instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'logo': instance.logo,
      'winner': instance.winner,
    };

Teams _$TeamsFromJson(Map<String, dynamic> json) => Teams(
      home: FixtureTeam.fromJson(json['home'] as Map<String, dynamic>),
      away: FixtureTeam.fromJson(json['away'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TeamsToJson(Teams instance) => <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

Goals _$GoalsFromJson(Map<String, dynamic> json) => Goals(
      home: json['home'] as int?,
      away: json['away'] as int?,
    );

Map<String, dynamic> _$GoalsToJson(Goals instance) => <String, dynamic>{
      'home': instance.home,
      'away': instance.away,
    };

FixtureLeague _$FixtureLeagueFromJson(Map<String, dynamic> json) =>
    FixtureLeague(
      id: json['id'] as int,
      name: json['name'] as String,
      country: json['country'] as String,
      logo: json['logo'] as String,
      flag: json['flag'] as String?,
      round: json['round'] as String,
    );

Map<String, dynamic> _$FixtureLeagueToJson(FixtureLeague instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'logo': instance.logo,
      'flag': instance.flag,
      'round': instance.round,
    };

Status _$StatusFromJson(Map<String, dynamic> json) => Status(
      long: json['long'] as String,
      short: json['short'] as String,
      elapsed: json['elapsed'] as int?,
    );

Map<String, dynamic> _$StatusToJson(Status instance) => <String, dynamic>{
      'long': instance.long,
      'short': instance.short,
      'elapsed': instance.elapsed,
    };

Fixture _$FixtureFromJson(Map<String, dynamic> json) => Fixture(
      id: json['id'] as int,
      referee: json['referee'] as String?,
      date: json['date'] as String,
      status: Status.fromJson(json['status'] as Map<String, dynamic>),
      venue: BaseVenue.fromJson(json['venue'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FixtureToJson(Fixture instance) => <String, dynamic>{
      'id': instance.id,
      'referee': instance.referee,
      'date': instance.date,
      'status': instance.status,
      'venue': instance.venue,
    };

FixturesInfo _$FixturesInfoFromJson(Map<String, dynamic> json) => FixturesInfo(
      fixture: Fixture.fromJson(json['fixture'] as Map<String, dynamic>),
      league: FixtureLeague.fromJson(json['league'] as Map<String, dynamic>),
      teams: Teams.fromJson(json['teams'] as Map<String, dynamic>),
      goals: Goals.fromJson(json['goals'] as Map<String, dynamic>),
      events: (json['events'] as List<dynamic>?)
          ?.map((e) => FixtureEvent.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FixturesInfoToJson(FixturesInfo instance) =>
    <String, dynamic>{
      'fixture': instance.fixture,
      'league': instance.league,
      'teams': instance.teams,
      'goals': instance.goals,
      'events': instance.events,
    };
