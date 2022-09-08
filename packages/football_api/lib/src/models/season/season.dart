import 'package:json_annotation/json_annotation.dart';
import '../coverage/coverage.dart';
import '../../interfaces/deserializable.dart';

part 'season.g.dart';

// {
//      "year": 2022,
//      "start": "2022-02-12",
//      "end": "2022-10-01",
//      "current": true,
//      "coverage": {
//          "fixtures": {
//              "events": true,
//              "lineups": true,
//              "statistics_fixtures": false,
//              "statistics_players": false
//          },
//          "standings": true,
//          "players": true,
//          "top_scorers": true,
//          "top_assists": true,
//          "top_cards": true,
//          "injuries": false,
//          "predictions": true,
//          "odds": true
//       }
//   }
@JsonSerializable()
class Season implements Deserializable {
  final int year;
  final String start;
  final String end;
  final bool current;
  final Coverage coverage;

  Season({
    required this.year,
    required this.start,
    required this.end,
    required this.current,
    required this.coverage,
  });

  factory Season.fromJson(Map<String, dynamic> json) => _$SeasonFromJson(json);

  @override
  Season Function(Map<String, dynamic> object) get deserialize => Season.fromJson;
}