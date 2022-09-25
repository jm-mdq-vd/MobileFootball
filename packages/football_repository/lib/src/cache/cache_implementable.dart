import 'dart:developer' as dev_tools;
import 'package:football_api/football_api.dart';
import 'package:football_repository/football_repository.dart';

import 'cache_repository.dart';
import '../extensions/list_extension.dart';

mixin Cache<Resource> implements Repository<Resource> {
  late final ApiClient cacheClient;

  Future<List<T>> getResults<T>(Endpoint endpoint, Map<String, dynamic> parameters,) async {
    final cachedResults = getResultsFromCache(endpoint, parameters);
    if (cachedResults != null) return cachedResults.castToType<T>();

    final response = await cacheClient.getResponseFromEndpoint(
      endpoint,
      parameters,
    );
    final results = response.response.castToType<T>();
    return results;
  }

  List? getResultsFromCache(Endpoint endpoint, Map<String, dynamic> parameters,) {
    final List? cachedInfo = CacheRepository.shared.getResponseFromEndpoint(endpoint, parameters,);
    dev_tools.log('Getting ${cachedInfo?.length ?? 0} results from cache');
    return cachedInfo;
  }

  void save(Endpoint endpoint, Map<String, dynamic> parameters, List values,) {
    dev_tools.log('Saving ${values?.length ?? 0} results to cache');
    CacheRepository.shared.saveValueForEndpoint(
      endpoint,
      parameters,
      values,
    );
  }
}

abstract class ClientCacheRepository<Resource> with Cache<Resource> {
  ClientCacheRepository(ApiClient? client)
      : _client = client != null ? client : FootballAPIClient.shared {
    cacheClient = _client;
  }

  final ApiClient _client;
}