part of 'resource_bloc.dart';

class ResourceEvent<Resource> extends Equatable {
  ResourceEvent({required this.parameters});

  final Map<String, dynamic>? parameters;

  @override
  List<Object?> get props => [];
}

ResourceEvent<League> getLeaguesByCountry(String country) => ResourceEvent(
  parameters: {
    'code': country,
  },
);

ResourceEvent<Team> getTeams(int league, int season) => ResourceEvent(
  parameters: {
    'league': league.toString(),
    'season': season.toString(),
  },
);

ResourceEvent<CountryInfo> getCountries() => ResourceEvent(
  parameters: {},
);