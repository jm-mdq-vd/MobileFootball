import '../models/models.dart';

enum Endpoint {
  countries,
  leagues,
  teams,
  fixtures,
  venues,
}

extension EndpointParse on Endpoint {
  dynamic Function(Map<String, dynamic> object) get parser {
    switch (this) {
      case Endpoint.countries:
        return Country.fromJson;
      case Endpoint.leagues:
        return LeagueInfo.fromJson;
      case Endpoint.teams:
        return TeamInfo.fromJson;
      case Endpoint.fixtures:
        return Fixture.fromJson;
      case Endpoint.venues:
        return Venue.fromJson;
    }
  }

  String get path {
    switch (this) {
      case Endpoint.countries:
        return 'countries';
      case Endpoint.leagues:
        return 'leagues';
      case Endpoint.teams:
        return 'teams';
      case Endpoint.fixtures:
        return 'fixtures';
      case Endpoint.venues:
        return 'venues';
    }
  }
}