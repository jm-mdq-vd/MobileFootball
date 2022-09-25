import 'dart:async';
import 'dart:developer' as dev_tools;
import 'package:football_api/football_api.dart' hide Team;
import 'package:football_repository/src/mixins/timing.dart';

import 'repository.dart';
import '../models/standing/standing_info.dart';
import '../models/team/team.dart';
import '../extensions/list_extension.dart';
import '../cache/cache_repository.dart';

class StandingsRepository with Timing implements Repository<StandingInfo> {
  StandingsRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared;

  final ApiClient _client;

  Future<List<StandingInfo>> getResource(Map<String, dynamic> parameters) async {
    if (timer != null && timerIsActive) {
      final List<StandingInfo>? cachedInfo = CacheRepository.shared.getResponseFromEndpoint(Endpoint.standings, parameters,);
      if (cachedInfo != null) {
        dev_tools.log('Getting results from cache');
        return cachedInfo;
      }
    }

    final response = await _client.getResponseFromEndpoint(
      Endpoint.standings,
      parameters,
    );

    final standings = response.response.castToType<Standing>();
    List<StandingInfo> list = standings.map((standing) {
      final teams = standing.league.standings.first;
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

    CacheRepository.shared.saveValueForEndpoint(
      Endpoint.standings,
      parameters,
      standings,
    );

    startTimer();

    dev_tools.log('TIMER INITIALIZED');

    return list;
  }
}