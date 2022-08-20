import 'package:json_annotation/json_annotation.dart';
import '../../interfaces/deserializable.dart';

part 'league.g.dart';

/// A single league from https://v3.football.api-sports.io/leagues?code=<country's code>
/// {
///   "id": 134
///   "name": "Torneo Federal A""
///   "code": "League"
///   "flag": "https://media.api-sports.io/football/leagues/134.png"
/// }
@JsonSerializable()
class League implements Deserializable {
  final int id;
  final String name;
  final String type;
  final String logo;

  League({
    required this.id,
    required this.name,
    required this.type,
    required this.logo,
  });

  factory League.fromJson(Map<String, dynamic> json) => _$LeagueFromJson(json);

  @override
  League Function(Map<String, dynamic> object) get deserialize => League.fromJson;
}