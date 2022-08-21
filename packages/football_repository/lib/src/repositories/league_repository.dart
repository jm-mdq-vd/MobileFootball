import 'dart:async';
import 'package:football_api/football_api.dart' hide League;

import 'repository.dart';
import '../models/league/league.dart';
import '../extensions/list_extension.dart';

class LeagueRepository implements Repository<League> {
  LeagueRepository() : _client = FootballAPIClient.shared;

  final FootballAPIClient _client;

  Future<List<League>> getResource(Map<String, dynamic>? parameters) async {
    final response = await _client.getResponseFromEndpoint(Endpoint.leagues, parameters,);
    final leaguesInfo = response.response.castToType<LeagueInfo>();
    return leaguesInfo.map((leagueInfo) => League(
      id: leagueInfo.league.id,
      name: leagueInfo.league.name,
      logo: leagueInfo.league.logo,
      country: leagueInfo.country.name,
    )).toList();
  }
}