import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/navigation/app_coordinator.dart';
import 'package:mobile_football/screens/details/team_details_screen.dart';
import 'package:mobile_football/view_models/cells/team_cell_view_model.dart';

import 'grid_screen.dart';

class TeamsGridScreen extends StatelessWidget {
  TeamsGridScreen({
    super.key,
    required this.title,
    required this.leagueId,
    required this.season,
    this.hasSearchBar = true,
    AppCoordinator? coordinator,
  });

  final String title;
  final String leagueId;
  final String season;
  final bool hasSearchBar;

  AppCoordinator? _coordinator;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TeamRepository>(
      create: (context) => TeamRepository(null),
      child: BlocProvider<ResourceBloc<Team>>(
        create: (context) => ResourceBloc(
          repository: context.read<TeamRepository>(),
        )..add(getTeams(leagueId, season)),
        child: BlocBuilder<ResourceBloc<Team>, ResourceState<Team>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) {
            return GridScreen<Team>(
              state: state,
              title: title,
              loaderMessage: 'Obteniendo todos los equipos de $title...',
              content: state.resources.map((team) => TeamCellViewModel(team: team)).toList(),
              onSelection: (selectedTeam) {
                print(_coordinator);
                print(selectedTeam.id);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TeamDetailScreen(
                      league: leagueId,
                      season: season,
                      id: selectedTeam.id,
                    ),
                  ),
                );
              },
              allowsMultipleSelection: true,
              hasSearchBar: hasSearchBar,
            );
          },
        ),
      ),
    );
  }
}