import 'dart:async';
import 'package:football_api/football_api.dart' hide League;
import 'package:football_repository/src/models/season/league_season.dart';

import 'repository.dart';
import '../models/league/league.dart';
import '../extensions/list_extension.dart';

class LeagueRepository implements Repository<League> {
  LeagueRepository(ApiClient? client) : _client = client != null ? client : MockAPIClient();

  final ApiClient _client;

  Future<List<League>> getResource(Map<String, dynamic>? parameters) async {
    final response = await _client.getResponseFromEndpoint(Endpoint.leagues, parameters,);
    final leaguesInfo = response.response.castToType<LeagueInfo>();
    return leaguesInfo.map((leagueInfo) => League(
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
      }).toList(),
    )).toList();
  }
}