import 'package:football_api/football_api.dart';
import 'package:football_repository/football_repository.dart';

import 'cache_repository.dart';
import '../extensions/list_extension.dart';

mixin Cache<Resource> implements Repository<Resource> {
  late final ApiClient cacheClient;

  List? getResultsFromCache(Endpoint endpoint, Map<String, dynamic> parameters,) {
    final List? cachedInfo = CacheRepository.shared.getResponseFromEndpoint(endpoint, parameters,);
    return cachedInfo;
  }

  void save(Endpoint endpoint, Map<String, dynamic> parameters, List values, {bool saveWithTimeout = false}) {
    CacheRepository.shared.saveValueForEndpoint(
      endpoint,
      parameters,
      values,
      saveWithTimeout: saveWithTimeout,
    );
  }
}

abstract class ClientCacheRepository<Resource> with Cache<Resource> {
  ClientCacheRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared {
    cacheClient = _client;
  }

  final ApiClient _client;

  Future<List<T>> getResults<T>(Endpoint endpoint, Map<String, dynamic> parameters,) async {
    final cachedResults = getResultsFromCache(endpoint, parameters);
    if (cachedResults != null) return cachedResults.castToType<T>();

    final response = await cacheClient.getResponseFromEndpoint(
      endpoint,
      parameters,
    );

    return response.response.castToType<T>();
  }
}

abstract class TimedClientCacheRepository<Resource> with Cache<Resource> {
  TimedClientCacheRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared {
    cacheClient = _client;
  }

  final ApiClient _client;

  Future<List<T>> getResults<T>(Endpoint endpoint, Map<String, dynamic> parameters,) async {
    if (CacheRepository.shared.timeoutReached(endpoint, parameters,)) {
      final response = await cacheClient.getResponseFromEndpoint(endpoint, parameters,);
      return response.response.castToType<T>();
    } else {
      final List<T>? cachedInfo = CacheRepository.shared.getResponseFromEndpoint(endpoint, parameters,);
      if (cachedInfo != null) {
        return cachedInfo;
      }
    }

    return [];
  }
}