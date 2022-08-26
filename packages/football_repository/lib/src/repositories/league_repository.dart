import 'dart:async';
import 'dart:developer' as devlog;
import 'package:football_api/football_api.dart' hide League;
import 'package:football_repository/src/models/season/league_season.dart';

import 'repository.dart';
import '../models/league/league.dart';
import '../extensions/list_extension.dart';
import '../cache/cache_repository.dart';

class LeagueRepository implements Repository<League> {
  LeagueRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared;

  final ApiClient _client;

  Future<List<League>> getResource(Map<String, dynamic> parameters) async {
    final code = parameters['code'];
    final List<League>? cachedInfo = CacheRepository.shared.getResponseFromEndpoint(Endpoint.leagues, parameters,);
    if (cachedInfo != null) return cachedInfo;

    final response = await _client.getResponseFromEndpoint(Endpoint.leagues, parameters,);
    final leaguesInfo = response.response.castToType<LeagueInfo>();

    var leagues = leaguesInfo.map((leagueInfo) {
      leagueInfo.seasons.sort((left, right) => right.year.compareTo(left.year));
      return League(
        id: leagueInfo.league.id,
        name: leagueInfo.league.name,
        logo: leagueInfo.league.logo,
        country: leagueInfo.country.name,
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

    CacheRepository.shared.saveValueForEndpoint(
      Endpoint.leagues,
      parameters,
      leagues,
    );
    return leagues;
  }
}