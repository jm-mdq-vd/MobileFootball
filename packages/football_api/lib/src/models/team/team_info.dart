import 'package:json_annotation/json_annotation.dart';

import 'team.dart';
import '../venue/venue.dart';
import '../../interfaces/deserializable.dart';

part 'team_info.g.dart';

/// https://v3.football.api-sports.io/teams?league=130&season=2022
/// {
//     "team": {
//        "id": 434,
//        "name": "Gimnasia L.P.",
//        "code": "GIM",
//        "country": "Argentina",
//        "founded": 1887,
//        "national": false,
//        "logo": "https://media.api-sports.io/football/teams/434.png"
//      },
//      "venue": {
//        "id": 77,
//        "name": "Estadio Juan Carmelo Zerillo",
//        "address": "Avenida 60 y 118",
//        "city": "La Plata, Provincia de Buenos Aires",
//        "capacity": 24544,
//        "surface": "grass",
//        "image": "https://media.api-sports.io/football/venues/77.png"
//      }
//  },

@JsonSerializable()
class TeamInfo implements Deserializable {
  final Team team;
  final Venue venue;

  TeamInfo({
    required this.team,
    required this.venue,
  });

  factory TeamInfo.fromJson(Map<String, dynamic> json) => _$TeamInfoFromJson(json);

  @override
  TeamInfo Function(Map<String, dynamic> object) get deserialize => TeamInfo.fromJson;
}