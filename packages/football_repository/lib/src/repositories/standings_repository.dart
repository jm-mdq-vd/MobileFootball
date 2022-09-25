import 'dart:async';
import 'package:football_api/football_api.dart' hide Team;

import '../models/standing/standing_info.dart';
import '../models/team/team.dart';
import '../cache/cache_implementable.dart';

class StandingsRepository extends TimedClientCacheRepository<StandingInfo> {
  StandingsRepository(super.client);

  Future<List<StandingInfo>> getResource(Map<String, dynamic> parameters) async {
    final standings = await getResults<Standing>(Endpoint.standings, parameters,);
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

    save(
      Endpoint.standings,
      parameters,
      standings,
      saveWithTimeout: true,
    );

    return list;
  }
}