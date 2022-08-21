import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/view_models/cells/team_cell_view_model.dart';
import 'package:page_transition/page_transition.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/resources/local_assets.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/grids/grid.dart';
import 'package:mobile_football/widgets/generics/grids/grid_representation.dart';

void main() {
  runApp(const MobileFootballApp());
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
        nextScreen: TeamsGrid(),
      ),
    );
  }
}

class LeaguesGrid extends StatelessWidget {
  const LeaguesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LeagueRepository>(
      create: (context) => LeagueRepository(),
      child: BlocProvider<ResourceBloc<League>>(
        create: (context) => ResourceBloc(
          repository: context.read<LeagueRepository>(),
        )..add(getLeaguesByCountry('AR')),
        child: BlocBuilder<ResourceBloc<League>, ResourceState<League>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: _buildLeagueGrid,
        ),
      ),
    );
  }

  Grid _buildLeagueGrid(BuildContext context, ResourceState<League> state) {
    print(state.resources.length);
    final gridRepresentation = GridRepresentation(
      title: 'Argentina\'s Leagues',
      content: state.resources.map((league) => LeagueCellViewModel(league: league)).toList(),
    );
    return Grid(representation: gridRepresentation);
  }
}

class TeamsGrid extends StatelessWidget {
  const TeamsGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TeamRepository>(
      create: (context) => TeamRepository(),
      child: BlocProvider<ResourceBloc<Team>>(
        create: (context) => ResourceBloc(
          repository: context.read<TeamRepository>(),
        )..add(getTeams(130, 2022)),
        child: BlocBuilder<ResourceBloc<Team>, ResourceState<Team>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: _buildTeamGrid,
        ),
      ),
    );
  }

  Grid _buildTeamGrid(BuildContext context, ResourceState<Team> state) {
    print(state.resources.length);
    final gridRepresentation = GridRepresentation(
      title: 'Argentina\'s Teams',
      content: state.resources.map((team) => TeamCellViewModel(team: team)).toList(),
    );
    return Grid(representation: gridRepresentation);
  }
}

