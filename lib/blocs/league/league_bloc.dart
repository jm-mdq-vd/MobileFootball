import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:football_repository/football_repository.dart';

import '../resource_status.dart';

part 'league_event.dart';
part 'league_state.dart';

class LeagueBloc extends Bloc<LeagueEvent, LeagueState> {
  LeagueBloc({required this.repository}) : super(LeagueState()) {
    on<GetLeaguesByCountry>(_mapEventToState);
  }

  final LeagueRepository repository;

  void _mapEventToState(GetLeaguesByCountry event, Emitter<LeagueState> emit) async {
    emit(state.copyWith(status: ResourceStatus.loading));
    final leagues = await repository.getResource({});
    emit(state.copyWith(
      status: ResourceStatus.success,
      leagues: leagues,
    ));
  }
}