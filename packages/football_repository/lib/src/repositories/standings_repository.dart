import 'dart:async';
import 'dart:developer' as devlog;
import 'package:football_api/football_api.dart';

import 'repository.dart';
import '../models/standing/standing_info.dart';
import '../extensions/list_extension.dart';
import '../cache/cache_repository.dart';

class StandingsRepository implements Repository<StandingInfo> {
  StandingsRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared;

  final ApiClient _client;

  Future<List<StandingInfo>> getResource(Map<String, dynamic> parameters) async {
    final List<StandingInfo>? cachedInfo = CacheRepository.shared.getResponseFromEndpoint(Endpoint.standings, parameters,);
    if (cachedInfo != null) return cachedInfo;
    final response = await _client.getResponseFromEndpoint(
      Endpoint.standings,
      null,
    );

    final standings = response.response.castToType<Standing>();
    List<StandingInfo> list = standings.map((standing) {
      return StandingInfo(
        id: standing.league.id,
        name: standing.league.name,
        country: standing.league.country,
        logo: standing.league.logo,
        flag: standing.league.flag,
        season: standing.league.season,
      );
    }).toList();

    CacheRepository.shared.saveValueForEndpoint(
      Endpoint.standings,
      parameters,
      list,
    );
    return list;
  }
}