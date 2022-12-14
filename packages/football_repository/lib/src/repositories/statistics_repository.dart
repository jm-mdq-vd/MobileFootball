import 'dart:async';

import 'package:football_api/football_api.dart' hide League, MatchesStatistics;
import 'package:football_repository/football_repository.dart';

import '../extensions/list_extension.dart';

class StatisticsRepository implements Repository<Statistics> {
  StatisticsRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared;

  final ApiClient _client;

  late final LeagueRepository leagueRepository = LeagueRepository(_client);

  Future<List<Statistics>> getResource(Map<String, dynamic> parameters) async {
    final response = await _client.getResponseFromEndpoint(Endpoint.teamStatistics, parameters,);
    final teamStatistics = response.response.castToType<TeamStatistics>();
    final result = await teamStatistics.map((statistic) async {
      final list = await leagueRepository.getResource({'id': statistic.league.id.toString()});
      return Statistics(
        league: list.first,
        matchesStatistics: MatchesStatistics(
          totalPlayed: statistic.fixtures.played.total,
          totalWins: statistic.fixtures.wins.total,
          totalDraws: statistic.fixtures.draws.total,
          totalLoses: statistic.fixtures.loses.total,
        ),
      );
    }).toList();

    List<Statistics> statistics = result.map((future) async => await future).cast<Statistics>().toList();

    return statistics;
  }
}
