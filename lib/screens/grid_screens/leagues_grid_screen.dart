import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';

import 'grid_screen.dart';
import '../table_screens/seasons_table_screen.dart';

class LeaguesGridScreen extends StatelessWidget {
  const LeaguesGridScreen({
    super.key,
    required this.title,
    required this.country,
  });

  final String title;
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
              title: '$title\'s Leagues',
              loaderMessage: 'Getting all the leagues from $title...',
              content: state.resources.map((league) => LeagueCellViewModel(league: league)).toList(),
              onSelection: (selectedItem) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SeasonsTableScreen(selectedItem: selectedItem,);
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