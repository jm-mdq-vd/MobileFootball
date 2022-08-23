import 'dart:async';
import 'dart:developer' as devlog;
import 'package:football_api/football_api.dart';

import 'repository.dart';
import '../models/country/country_info.dart';
import '../extensions/list_extension.dart';

class CountryRepository implements Repository<CountryInfo> {
  CountryRepository() : _client = FootballAPIClient.shared;

  final FootballAPIClient _client;

  Future<List<CountryInfo>> getResource(Map<String, dynamic>? parameters) async {
    final response = await _client.getResponseFromEndpoint(
      Endpoint.countries,
      null,
    );
    final countries = response.response.castToType<Country>();
    devlog.log('Countries fetched ${countries.length}');
    List<CountryInfo> list = [];
    for (final country in countries) {
      /*
      final leagues = await _client.getResponseFromEndpoint(
          Endpoint.leagues,
          {'code': country.code}
      );
      */
      list.add(CountryInfo(
        name: country.name,
        code: country.code,
        flag: country.flag,
        // numberOfLeagues: await leagues.response.length,
      ));
    }

    return list;
  }
}