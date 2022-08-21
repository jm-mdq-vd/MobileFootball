part of 'league_bloc.dart';

class LeagueState extends Equatable {
  const LeagueState({
    this.status = ResourceStatus.initial,
    List<League>? leagues,
  }) : leagues = leagues ?? const [];

  final List<League> leagues;
  final ResourceStatus status;

  @override
  List<Object?> get props => [status, leagues,];

  LeagueState copyWith({
    List<League>? leagues,
    ResourceStatus? status,
  }) {
    return LeagueState(
      leagues: leagues ?? this.leagues,
      status: status ?? this.status,
    );
  }
}