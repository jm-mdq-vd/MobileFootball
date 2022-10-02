import 'package:json_annotation/json_annotation.dart';
import '../../interfaces/deserializable.dart';

import 'team.dart';

part 'team_squad.g.dart';

@JsonSerializable()
class SquadMember implements Deserializable {
  SquadMember({
    required this.id,
    required this.name,
    required this.age,
    required this.number,
    required this.position,
    required this.photo,
  });

  final int id;
  final String name;
  final int? age;
  final int? number;
  final String position;
  final String? photo;

  factory SquadMember.fromJson(Map<String, dynamic> json) => _$SquadMemberFromJson(json);

  @override
  SquadMember Function(Map<String, dynamic> object) get deserialize => SquadMember.fromJson;
}

@JsonSerializable()
class TeamSquad implements Deserializable {
  TeamSquad({
    required this.team,
    required this.players,
  });

  final BasicTeamInfo team;
  final List<SquadMember> players;

  factory TeamSquad.fromJson(Map<String, dynamic> json) => _$TeamSquadFromJson(json);

  @override
  TeamSquad Function(Map<String, dynamic> object) get deserialize => TeamSquad.fromJson;
}