import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/screens/details/team_details_screen.dart';
import 'package:mobile_football/view_models/cells/team_cell_view_model.dart';
import 'package:mobile_football/screens/resource_status_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

import 'grid_screen.dart';

class TeamsGridScreen extends StatelessWidget {
  TeamsGridScreen({
    super.key,
    required LeagueSeasonRequirements requirements,
    this.hasSearchBar = true,
  }) : _requirements = requirements;

  final LeagueSeasonRequirements _requirements;
  final bool hasSearchBar;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<TeamRepository>(
      create: (context) => TeamRepository(null),
      child: BlocProvider<ResourceBloc<Team>>(
        create: (context) => ResourceBloc(
          repository: context.read<TeamRepository>(),
        )..add(getTeams(_requirements.leagueId, _requirements.season)),
        child: BlocBuilder<ResourceBloc<Team>, ResourceState<Team>>(
          builder: (context, state) {
            return ResourceStatusScreen(
              state: state,
              loaderMessage: 'Obteniendo todos los equipos de ${_requirements.title}...',
              successWidget: GridScreen(
                state: state,
                title: _requirements.title,
                content: state.resources.map((team) => TeamCellViewModel(team: team)).toList(),
                onSelection: (selectedTeam) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TeamDetailScreen(
                        league: _requirements.leagueId,
                        season: _requirements.season,
                        id: selectedTeam.id,
                      ),
                    ),
                  );
                },
                allowsMultipleSelection: true,
                hasSearchBar: hasSearchBar,
              ),
            );
          },
        ),
      ),
    );
  }
}