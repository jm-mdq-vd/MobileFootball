import 'dart:developer' as dev_tools;

import 'package:football_api/football_api.dart';

class CacheRepository  {
  CacheRepository._privateConstructor() : _cache = {}, _saveDates = {};

  static final CacheRepository _instance = CacheRepository._privateConstructor();

  static CacheRepository get shared => _instance;

  Map<String, List<dynamic>> _cache;
  Map<String, DateTime?> _saveDates;

  int timeOut = 15;

  void saveValueForEndpoint(
      Endpoint endpoint,
      Map<String, dynamic> parameters,
      List<dynamic> values,
      {bool saveWithTimeout = false,}
      ) {
    final key = _keyForEndpoint(endpoint, parameters);
    if (_cache[key] == null) {
      if (saveWithTimeout) {
        _saveDates[key] = DateTime.now();
      }
      dev_tools.log('Saving ${values.length} results to cache');
      _cache[key] = values;
    }

    if (_saveDates[key] != null) dev_tools.log('Saved at ${_saveDates[key].toString()}');
  }

  bool timeoutReached(Endpoint endpoint, Map<String, dynamic> parameters,) {
    final key = _keyForEndpoint(endpoint, parameters);
    DateTime? savedDate = _saveDates[key];
    dev_tools.log(savedDate.toString());
    int timeDifference = savedDate?.difference(DateTime.now()).inMinutes.abs() ?? timeOut;
    dev_tools.log('Time difference ${timeDifference.toString()}');
    bool reached = timeDifference >= timeOut;
    if (reached) _saveDates[key] = null;
    return reached;
  }

  List<T>? getResponseFromEndpoint<T>(Endpoint endpoint, Map<String, dynamic> parameters,) {
    final String key = _keyForEndpoint(endpoint, parameters);
    return _valueForKey(key);
  }

  List<T>? _valueForKey<T>(String key) {
    final List<T>? cachedInfo = _cache[key]?.cast<T>();
    if (cachedInfo != null) {
      dev_tools.log('Getting ${cachedInfo.length} results from cache');
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
      case Endpoint.fixtures:
        final String suffix = '${parameters['league']}_${parameters['season']}';
        return 'fixtures_' + suffix;
      default:
        return '';
    }
  }
}