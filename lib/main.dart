import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';
import 'package:mobile_football/widgets/generics/loaders/screen_loader.dart';
import 'package:mobile_football/widgets/generics/messages/no_results.dart';
import 'package:page_transition/page_transition.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/resources/local_assets.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/view_models/cells/country_cell_view_model.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/view_models/cells/team_cell_view_model.dart';
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
        nextScreen: CountriesGrid(),
      ),
    );
  }
}

class LeaguesGrid extends StatelessWidget {
  const LeaguesGrid({
    super.key,
    required this.country,
  });

  final String country;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LeagueRepository>(
      create: (context) => LeagueRepository(null),
      child: BlocProvider<ResourceBloc<League>>(
        create: (context) => ResourceBloc(
          repository: context.read<LeagueRepository>(),
        )..add(getLeaguesByCountry(country)),
        child: BlocBuilder<ResourceBloc<League>, ResourceState<League>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) {
            return GridScreen<League>(
              state: state,
              title: 'Country\'s Leagues',
              loaderMessage: 'Getting all the leagues from (country)...',
              content: state.resources.map((league) => LeagueCellViewModel(league: league)).toList(),
              onSelection: (selectedItem) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      int? id = int.tryParse(selectedItem.id);
                      if (id != null) return TeamsGrid(leagueId: id);
                      return Container();
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class TeamsGrid extends StatelessWidget {
  const TeamsGrid({
    super.key,
    required this.leagueId,
  });

  final int leagueId;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TeamRepository>(
      create: (context) => TeamRepository(null),
      child: BlocProvider<ResourceBloc<Team>>(
        create: (context) => ResourceBloc(
          repository: context.read<TeamRepository>(),
        )..add(getTeams(leagueId, 2022)),
        child: BlocBuilder<ResourceBloc<Team>, ResourceState<Team>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) {
            return GridScreen<Team>(
              state: state,
              title: 'Team',
              loaderMessage: 'Getting all the teams from (league)...',
              content: state.resources.map((team) => TeamCellViewModel(team: team)).toList(),
              onSelection: (_) {},
            );
          },
        ),
      ),
    );
  }
}

class CountriesGrid extends StatelessWidget {
  const CountriesGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<CountryRepository>(
      create: (context) => CountryRepository(null),
      child: BlocProvider<ResourceBloc<CountryInfo>>(
        create: (context) => ResourceBloc(
          repository: context.read<CountryRepository>(),
        )..add(getCountries()),
        child: BlocBuilder<ResourceBloc<CountryInfo>, ResourceState<CountryInfo>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) {
            return GridScreen<CountryInfo>(
              state: state,
              title: 'Countries',
              loaderMessage: 'Getting all the available countries...',
              content: state.resources.map((country) => CountryCellViewModel(country: country)).toList(),
              itemSpacing: 8,
              crossAxisCount: 3,
              onSelection: (selectedItem) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LeaguesGrid(country: selectedItem.id),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class GridScreen<Resource> extends StatelessWidget {
  const GridScreen({
    super.key,
    required this.state,
    required this.title,
    required this.loaderMessage,
    required this.content,
    this.onSelection,
    this.itemSpacing = 16,
    this.crossAxisCount = 2,
  });

  final String title;
  final String loaderMessage;
  final ResourceState<Resource> state;
  final List<CellRepresentable> content;
  final Function(CellRepresentable selectedItem)? onSelection;

  final double itemSpacing;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    if (state.status.isLoading) {
      return ScreenLoader(message: loaderMessage,);
    }

    if (state.status.isSuccess) {
      if (state.resources.isEmpty) {
        return const NoResults();
      }

      final gridRepresentation = GridRepresentation(
        title: title,
        content: content,
      );
      return Grid(
        representation: gridRepresentation,
        itemSpacing: itemSpacing,
        crossAxisCount: crossAxisCount,
        onSelection: onSelection,
      );
    }

    return ScreenLoader(message: loaderMessage,);
  }
}