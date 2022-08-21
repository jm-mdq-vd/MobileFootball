part of 'league_bloc.dart';

class LeagueEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetLeaguesByCountry extends LeagueEvent {
  final String country;

  GetLeaguesByCountry(this.country);

  @override
  List<Object?> get props => [country];
}