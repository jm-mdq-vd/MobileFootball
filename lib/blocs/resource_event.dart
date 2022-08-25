part of 'resource_bloc.dart';

class ResourceEvent<Resource> extends Equatable {
  ResourceEvent({required this.parameters});

  final Map<String, dynamic> parameters;

  @override
  List<Object?> get props => [];
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

ResourceEvent<CountryInfo> getCountries() => ResourceEvent(
  parameters: {},
);