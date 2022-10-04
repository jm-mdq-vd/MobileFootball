part of 'resource_bloc.dart';

class ResourceEvent<Resource> extends Equatable {
  ResourceEvent({required this.parameters});

  final Map<String, dynamic> parameters;

  @override
  List<Object?> get props => [parameters];
}

ResourceEvent<League> getLeaguesByCountry(String country) => ResourceEvent(
  parameters: {
    'code': country,
  },
);

ResourceEvent<Team> getTeams(String league, String season) => ResourceEvent(
  parameters: {
    'league': league,
    'season': season,
  },
);

ResourceEvent<Team> getTeamWithId(String id) => ResourceEvent(
  parameters: {
    'id': id,
  },
);

ResourceEvent<CountryInfo> getCountries() => ResourceEvent(
  parameters: {},
);

ResourceEvent<StandingInfo> getStanding(String league, String season) => ResourceEvent(
  parameters: {
    'league': league,
    'season': season,
  },
);

ResourceEvent<Statistics> getStatistics(String league, String season, String team) => ResourceEvent(
  parameters: {
    'league': league,
    'season': season,
    'team': team,
  },
);

ResourceEvent<Fixture> getFixturesByTeam(String teamId, String season) => ResourceEvent(
  parameters: {
    'team': teamId,
    'season': season,
  },
);

ResourceEvent<Fixture> getFixturesByLeague(String leagueId, String season) => ResourceEvent(
  parameters: {
    'league': leagueId,
    'season': season,
  },
);

ResourceEvent<Event> getEventsFromFixture(String fixtureId) => ResourceEvent(
    parameters: {
      'fixture': fixtureId,
    },
);