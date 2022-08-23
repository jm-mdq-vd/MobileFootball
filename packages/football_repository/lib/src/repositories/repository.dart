import 'package:football_api/football_api.dart';

abstract class Repository<Resource> {
  ApiClient get _client;

  Future<List<Resource>> getResource(Map<String, dynamic>? parameters);
}