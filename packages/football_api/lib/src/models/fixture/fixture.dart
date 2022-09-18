import 'package:json_annotation/json_annotation.dart';

import '../../interfaces/deserializable.dart';

part 'fixture.g.dart';

@JsonSerializable()
class FixtureTeam implements Deserializable {
  FixtureTeam({
    required this.id,
    required this.name,
    required this.logo,
    required this.winner,
  });

  final int id;
  final String name;
  final String logo;
  final bool? winner;

  factory FixtureTeam.fromJson(Map<String, dynamic> json) => _$FixtureTeamFromJson(json);

  @override
  FixtureTeam Function(Map<String, dynamic> object) get deserialize => FixtureTeam.fromJson;
}

@JsonSerializable()
class Teams implements Deserializable {
  Teams({
    required this.home,
    required this.away,
  });

  final FixtureTeam home;
  final FixtureTeam away;

  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);

  @override
  Teams Function(Map<String, dynamic> object) get deserialize => Teams.fromJson;
}

@JsonSerializable()
class Goals implements Deserializable {
  Goals({
    required this.home,
    required this.away,
  });

  final int? home;
  final int? away;

  factory Goals.fromJson(Map<String, dynamic> json) => _$GoalsFromJson(json);

  @override
  Goals Function(Map<String, dynamic> object) get deserialize => Goals.fromJson;
}

@JsonSerializable()
class FixtureLeague implements Deserializable {
  FixtureLeague({
    required this.id,
    required this.name,
    required this.country,
    required this.logo,
    required this.flag,
    required this.round,
  });

  final int id;
  final String name;
  final String country;
  final String logo;
  final String flag;
  final String round;

  factory FixtureLeague.fromJson(Map<String, dynamic> json) => _$FixtureLeagueFromJson(json);

  @override
  FixtureLeague Function(Map<String, dynamic> object) get deserialize => FixtureLeague.fromJson;
}

@JsonSerializable()
class Status implements Deserializable {
  Status({
    required this.long,
    required this.short,
    required this.elapsed
  });

  final String long;
  final String short;
  final int? elapsed;

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  @override
  Status Function(Map<String, dynamic> object) get deserialize => Status.fromJson;
}

@JsonSerializable()
class Fixture implements Deserializable {
  Fixture({
    required this.id,
    required this.referee,
    required this.date,
    required this.status,
  });

  final int id;
  final String? referee;
  final String date;
  final Status status;

  factory Fixture.fromJson(Map<String, dynamic> json) => _$FixtureFromJson(json);

  @override
  Fixture Function(Map<String, dynamic> object) get deserialize => Fixture.fromJson;
}

@JsonSerializable()
class FixturesInfo implements Deserializable {
  FixturesInfo({
    required this.fixture,
    required this.league,
    required this.teams,
    required this.goals,
  });

  final Fixture fixture;
  final FixtureLeague league;
  final Teams teams;
  final Goals goals;

  factory FixturesInfo.fromJson(Map<String, dynamic> json) => _$FixturesInfoFromJson(json);

  @override
  FixturesInfo Function(Map<String, dynamic> object) get deserialize => FixturesInfo.fromJson;
}