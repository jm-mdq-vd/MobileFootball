import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/resources/local_assets.dart';
import 'package:mobile_football/blocs/league/league_bloc.dart';
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
        nextScreen: RepositoryProvider<LeagueRepository>(
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

  Grid _buildTeamGrid(BuildContext context, LeagueState state) {
    final gridRepresentation = GridRepresentation(
      title: 'Argentina\'s Leagues',
      content: state.leagues.map((league) => LeagueCellViewModel(league: league)).toList(),
    );
    return Grid(representation: gridRepresentation);
  }
}

