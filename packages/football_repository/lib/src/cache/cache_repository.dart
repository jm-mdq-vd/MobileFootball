import 'dart:developer' as devlog;

import 'package:football_api/football_api.dart';

class CacheRepository  {
  CacheRepository._privateConstructor() : _cache = {};

  static final CacheRepository _instance = CacheRepository._privateConstructor();

  static CacheRepository get shared => _instance;

  Map<String, List<dynamic>> _cache;

  void saveValueForEndpoint(
      Endpoint endpoint,
      Map<String, dynamic> parameters,
      List<dynamic> value
      ) {
    final key = _keyForEndpoint(endpoint, parameters);
    _cache[key] = value;
  }

  List<T>? getResponseFromEndpoint<T>(Endpoint endpoint, Map<String, dynamic> parameters,) {
    final String key = _keyForEndpoint(endpoint, parameters);
    return _valueForKey(key);
  }

  List<T>? _valueForKey<T>(String key) {
    final List<T>? cachedInfo = _cache[key]?.cast<T>();
    if (cachedInfo != null) {
      devlog.log('Fetching data from cache: ${cachedInfo.length} results');
      return cachedInfo;
    }
    return null;
  }

  String _keyForEndpoint(Endpoint endpoint, Map<String, dynamic> parameters) {
    switch (endpoint) {
      case Endpoint.countries:
        return 'countries';
      case Endpoint.leagues:
        final String code = parameters['code'];
        return 'leagues_$code';
      case Endpoint.teams:
        String suffix;
        if (parameters['id'] != null) {
          suffix = '${parameters['id']}';
          return 'teams_' + suffix;
        }

        suffix = '${parameters['league']}_${parameters['season']}';
        return 'teams_' + suffix;
      case Endpoint.standings:
        final String suffix = '${parameters['league']}_${parameters['season']}';
        return 'standings_' + suffix;
      default:
        return '';
    }
  }
}