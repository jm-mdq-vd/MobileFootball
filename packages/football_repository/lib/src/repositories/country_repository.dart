import 'dart:async';
import 'dart:developer' as devlog;
import 'package:football_api/football_api.dart';

import '../models/country/country_info.dart';
import '../cache/cache_implementable.dart';

class CountryRepository extends ClientCacheRepository<CountryInfo> {
  CountryRepository(super.client);

  Future<List<CountryInfo>> getResource(Map<String, dynamic> parameters) async {
    final countries = await getResults<Country>(Endpoint.countries, parameters);
    List<CountryInfo> list = [];
    for (final country in countries) {
      list.add(CountryInfo(
        name: country.name,
        code: country.code,
        flag: country.flag,
      ));
    }

    list.removeWhere((country) => country.name == "World");
    save(
      Endpoint.countries,
      parameters,
      countries,
    );

    return list;
  }
}