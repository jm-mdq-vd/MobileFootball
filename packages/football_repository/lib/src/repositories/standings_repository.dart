import 'dart:async';
import 'dart:developer' as devlog;
import 'package:football_api/football_api.dart' hide Team;

import 'repository.dart';
import '../models/standing/standing_info.dart';
import '../models/team/team.dart';
import '../extensions/list_extension.dart';
import '../cache/cache_repository.dart';

class StandingsRepository implements Repository<StandingInfo> {
  StandingsRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared;

  final ApiClient _client;

  Future<List<StandingInfo>> getResource(Map<String, dynamic> parameters) async {
    final response = await _client.getResponseFromEndpoint(
      Endpoint.standings,
      parameters,
    );

    final standings = response.response.castToType<Standing>();
    List<StandingInfo> list = standings.map((standing) {
      final teams = standing.league.standings.expand((list) => list).toList();
      return StandingInfo(
        id: standing.league.id,
        name: standing.league.name,
        country: standing.league.country,
        logo: standing.league.logo,
        flag: standing.league.flag,
        season: standing.league.season,
        teams: teams.map((team) => GeneralTeamInfo(
          rank: team.rank,
          points: team.points,
          team: Team(
            id: team.team.id,
            name: team.team.name,
            logo: team.team.logo,
            country: '',
          ),
          status: StatusX.from(team.status),
          results: MatchesResult(
            played: team.all.played,
            win: team.all.win,
            draw: team.all.draw,
            lose: team.all.lose,
          ),
        )).toList(),
      );
    }).toList();

    return list;
  }
}