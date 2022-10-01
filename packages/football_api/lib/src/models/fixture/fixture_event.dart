import 'package:json_annotation/json_annotation.dart';

import '../../interfaces/deserializable.dart';
import '../team/team.dart';
import '../player/player_info.dart';

part 'fixture_event.g.dart';

@JsonSerializable()
class Time implements Deserializable {
  const Time({
    required this.elapsed,
    required this.extra,
  });

  final int elapsed;
  final int? extra;

  factory Time.fromJson(Map<String, dynamic> json) => _$TimeFromJson(json);

  @override
  Time Function(Map<String, dynamic> object) get deserialize => Time.fromJson;
}

@JsonSerializable()
class FixtureEvent implements Deserializable {
  FixtureEvent({
    required this.time,
    required this.team,
    required this.player,
    required this.type,
    required this.details,
    required this.comments,
  });

  final Time time;
  final BasicTeamInfo team;
  final BasicPlayerInfo player;
  final String type;
  final String details;
  final String? comments;

  factory FixtureEvent.fromJson(Map<String, dynamic> json) => _$FixtureEventFromJson(json);

  @override
  FixtureEvent Function(Map<String, dynamic> object) get deserialize => FixtureEvent.fromJson;
}