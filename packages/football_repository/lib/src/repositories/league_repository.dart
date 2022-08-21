import 'dart:async';

import '../models/league/league.dart';
import 'package:football_api/football_api.dart' hide League;

class LeagueRepository {
  LeagueRepository() : _client = FootballAPIClient.shared;

  final FootballAPIClient _client;

  Future<List<League>> getLeaguesByCountry(String country) async {
    final response = await _client.getLeaguesByCountry({'code': country});
    final leaguesInfo = response.response as List<LeagueInfo>;
    return leaguesInfo.map((leagueInfo) => League(
      id: leagueInfo.league.id,
      name: leagueInfo.league.name,
      logo: leagueInfo.league.logo,
      country: leagueInfo.country.name,
    )).toList();
  }
}