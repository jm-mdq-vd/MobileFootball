import 'dart:async';
import 'package:football_api/football_api.dart' hide League;
import 'package:football_repository/src/cache/cache_implementable.dart';
import 'package:football_repository/src/models/season/league_season.dart';

import '../models/league/league.dart';

class LeagueRepository extends ClientCacheRepository<League> {
  LeagueRepository(super.client);

  Future<List<League>> getResource(Map<String, dynamic> parameters) async {
    final leaguesInfo = await getResults<LeagueInfo>(Endpoint.leagues, parameters);
    var leagues = leaguesInfo
        .map((leagueInfo) {
      leagueInfo.seasons.sort((left, right) => right.year.compareTo(left.year));
      return League(
        id: leagueInfo.league.id,
        name: leagueInfo.league.name,
        logo: leagueInfo.league.logo,
        country: leagueInfo.country.name,
        isCup: leagueInfo.league.type == 'Cup',
        seasons: leagueInfo.seasons.map((season) {
          return LeagueSeason(
            year: season.year,
            startDate: season.start,
            endDate: season.end,
            fixtures: {
              FixturesKeys.events.key: season.coverage.fixtures.events,
              FixturesKeys.lineups.key: season.coverage.fixtures.lineups,
              FixturesKeys.fixturesStatistics.key: season.coverage.fixtures.statisticsFixtures,
              FixturesKeys.playersStatistics.key: season.coverage.fixtures.statisticsPlayers,
            },
            isCurrent: season.current,
            hasPredictions: season.coverage.predictions,
          );
        }).toList()
      );
    }).toList();

    save(
      Endpoint.leagues,
      parameters,
      leaguesInfo,
    );

    return leagues;
  }
}