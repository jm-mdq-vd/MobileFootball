import '../models/models.dart';

enum Endpoint {
  countries,
  leagues,
  teams,
  teamStatistics,
  fixtures,
  events,
  squads,
  venues,
  standings,
  players,
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
      case Endpoint.teamStatistics:
        return TeamStatistics.fromJson;
      case Endpoint.fixtures:
        return FixturesInfo.fromJson;
      case Endpoint.events:
        return FixtureEvent.fromJson;
      case Endpoint.squads:
        return TeamSquad.fromJson;
      case Endpoint.venues:
        return Venue.fromJson;
      case Endpoint.standings:
        return Standing.fromJson;
      case Endpoint.players:
        return PlayerInfo.fromJson;
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
      case Endpoint.teamStatistics:
        return 'teams/statistics';
      case Endpoint.fixtures:
        return 'fixtures';
      case Endpoint.events:
        return 'fixtures/events';
      case Endpoint.squads:
        return 'players/squads';
      case Endpoint.venues:
        return 'venues';
      case Endpoint.standings:
        return 'standings';
      case Endpoint.players:
        return 'players';
    }
  }
}