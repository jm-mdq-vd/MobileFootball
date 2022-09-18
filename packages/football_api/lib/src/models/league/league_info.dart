import 'package:json_annotation/json_annotation.dart';

import 'league.dart';
import '../country/country.dart';
import '../season/season.dart';
import '../../interfaces/deserializable.dart';

part 'league_info.g.dart';

@JsonSerializable()
class LeagueInfo implements Deserializable {
  LeagueInfo({
    required this.league,
    required this.country,
    required this.seasons,
  });

  final League league;
  final Country country;
  final List<Season> seasons;

  factory LeagueInfo.fromJson(Map<String, dynamic> json) => _$LeagueInfoFromJson(json);

  @override
  LeagueInfo Function(Map<String, dynamic> object) get deserialize => LeagueInfo.fromJson;
}