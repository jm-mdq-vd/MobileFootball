import 'dart:async';
import 'dart:developer' as devlog;

import 'package:football_api/football_api.dart' hide League, MatchesStatistics;
import 'package:football_repository/football_repository.dart';
import 'package:football_repository/src/models/team/statistics.dart';

import '../models/team/statistics.dart';
import '../extensions/list_extension.dart';
import '../cache/cache_repository.dart';

class StatisticsRepository implements Repository<Statistics> {
  StatisticsRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared;

  final ApiClient _client;

  late final LeagueRepository leagueRepository = LeagueRepository(_client);

  Future<List<Statistics>> getResource(Map<String, dynamic> parameters) async {
    final response = await _client.getResponseFromEndpoint(Endpoint.teamStatistics, parameters,);
    final teamStatistics = response.response.castToType<TeamStatistics>();
    devlog.log('Team statistics fetched ${teamStatistics.length}');
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
    devlog.log('Statistics fetched ${statistics.length}');

    return statistics;
  }
}
