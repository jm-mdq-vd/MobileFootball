import 'dart:developer' as devlog;

class CacheRepository {
  CacheRepository._privateConstructor() : _cache = {};

  static final CacheRepository _instance = CacheRepository._privateConstructor();

  static CacheRepository get shared => _instance;

  Map<String, List<dynamic>> _cache;

  void saveWithKey(String key, List<dynamic> value) {
    _cache[key] = value;
  }

  List<T>? valueForKey<T>(String key) {
    final List<T>? cachedInfo = _cache[key]?.cast<T>();
    if (cachedInfo != null) {
      devlog.log('Fetching data from cache: ${cachedInfo.length} results');
      return cachedInfo;
    }
    return null;
  }
}