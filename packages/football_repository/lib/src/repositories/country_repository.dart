import 'dart:async';

import 'package:football_api/football_api.dart';

class CountryRepository {
  CountryRepository() : _client = FootballAPIClient.shared;

  final FootballAPIClient _client;

  Future<List<Country>> getCountries() async {
    final response = await _client.getResponseFromEndpoint(
      Endpoint.countries,
      null,
    );
    return response.response as List<Country>;
  }
}