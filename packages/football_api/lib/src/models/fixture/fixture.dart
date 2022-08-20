import 'package:json_annotation/json_annotation.dart';

import '../../interfaces/deserializable.dart';

part 'fixture.g.dart';

@JsonSerializable()
class FixtureTeam implements Deserializable {
  final int id;
  final String name;
  final String logo;
  final bool winner;

  FixtureTeam({
    required this.id,
    required this.name,
    required this.logo,
    required this.winner,
  });

  factory FixtureTeam.fromJson(Map<String, dynamic> json) => _$FixtureTeamFromJson(json);

  @override
  FixtureTeam Function(Map<String, dynamic> object) get deserialize => FixtureTeam.fromJson;
}

@JsonSerializable()
class Status implements Deserializable {
  final String long;
  final String short;
  final int elapsed;

  Status({
    required this.long,
    required this.short,
    required this.elapsed
  });

  factory Status.fromJson(Map<String, dynamic> json) => _$StatusFromJson(json);

  @override
  Status Function(Map<String, dynamic> object) get deserialize => Status.fromJson;
}

@JsonSerializable()
class Fixture implements Deserializable {
  final int id;
  final String referee;
  final String timezone;
  final String date;
  final Status status;

  Fixture({
    required this.id,
    required this.referee,
    required this.timezone,
    required this.date,
    required this.status,
  });

  factory Fixture.fromJson(Map<String, dynamic> json) => _$FixtureFromJson(json);

  @override
  Fixture Function(Map<String, dynamic> object) get deserialize => Fixture.fromJson;
}