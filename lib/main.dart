import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:football_repository/football_repository.dart';
import 'package:mobile_football/resources/local_assets.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/grids/grid.dart';
import 'package:mobile_football/widgets/generics/grids/grid_representation.dart';

void main() {
  runApp(const MobileFootballApp());
}

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

enum LeagueStatus { initial, success, error, loading, selected }

extension LeagueStatusX on LeagueStatus {
  bool get isInitial => this == LeagueStatus.initial;
  bool get isSuccess => this == LeagueStatus.success;
  bool get isError => this == LeagueStatus.error;
  bool get isLoading => this == LeagueStatus.loading;
  bool get isSelected => this == LeagueStatus.selected;
}

class LeagueState extends Equatable {
  const LeagueState({
    this.status = LeagueStatus.initial,
    List<League>? leagues,
  }) : leagues = leagues ?? const [];

  final List<League> leagues;
  final LeagueStatus status;

  @override
  List<Object?> get props => [status, leagues,];

  LeagueState copyWith({
    List<League>? leagues,
    LeagueStatus? status,
  }) {
    return LeagueState(
      leagues: leagues ?? this.leagues,
      status: status ?? this.status,
    );
  }
}

class LeagueBloc extends Bloc<LeagueEvent, LeagueState> {
  LeagueBloc({required this.repository}) : super(LeagueState()) {
    on<GetLeaguesByCountry>(_mapEventToState);
  }

  final LeagueRepository repository;

  void _mapEventToState(GetLeaguesByCountry event, Emitter<LeagueState> emit) async {
    emit(state.copyWith(status: LeagueStatus.loading));
    final leagues = await repository.getLeaguesByCountry(event.country);
    emit(state.copyWith(
      status: LeagueStatus.success,
      leagues: leagues,
    ));
  }
}

class MobileFootballApp extends StatelessWidget {
  const MobileFootballApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splash: LocalAssets.splashLottie,
        backgroundColor: Colors.white,
        splashIconSize: 400,
        duration: 1,
        pageTransitionType: PageTransitionType.fade,
        nextScreen: RepositoryProvider<LeagueRepository>(
          create: (context) => LeagueRepository(),
          child: BlocProvider<LeagueBloc>(
            create: (context) => LeagueBloc(
              repository: context.read<LeagueRepository>(),
            )..add(GetLeaguesByCountry('AR')),
            child: BlocBuilder<LeagueBloc, LeagueState>(
              buildWhen: (_, current) => current.status.isSuccess,
              builder: _buildLeagueGrid,
            ),
          ),
        ),
      ),
    );
  }

  Grid _buildLeagueGrid(BuildContext context, LeagueState state) {
    final gridRepresentation = GridRepresentation(
      title: 'Argentina\'s Leagues',
      content: state.leagues.map((league) => LeagueCellViewModel(league: league)).toList(),
    );
    return Grid(representation: gridRepresentation);
  }
}

