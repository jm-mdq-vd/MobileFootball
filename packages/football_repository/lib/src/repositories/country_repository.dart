import 'dart:async';
import 'dart:developer' as devlog;
import 'package:football_api/football_api.dart';

import 'repository.dart';
import '../models/country/country_info.dart';
import '../extensions/list_extension.dart';
import '../cache/cache_repository.dart';

class CountryRepository implements Repository<CountryInfo> {
  CountryRepository(ApiClient? client)
      : _cache = CacheRepository.shared,
        _client = client != null ? client : FootballAPIClient.shared;

  final CacheRepository _cache;
  final ApiClient _client;

  Future<List<CountryInfo>> getResource(Map<String, dynamic>? parameters) async {
    final List<CountryInfo>? cachedInfo = _cache.valueForKey('countries');
    if (cachedInfo != null) return cachedInfo;

    final response = await _client.getResponseFromEndpoint(
      Endpoint.countries,
      null,
    );
    final countries = response.response.castToType<Country>();
    devlog.log('Countries fetched ${countries.length}');
    List<CountryInfo> list = [];
    for (final country in countries) {
      list.add(CountryInfo(
        name: country.name,
        code: country.code,
        flag: country.flag,
      ));
    }

    list.removeWhere((country) => country.name == "World");
    _cache.saveWithKey('countries', list);
    return list;
  }
}