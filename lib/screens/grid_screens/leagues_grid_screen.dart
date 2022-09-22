import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:football_repository/football_repository.dart';

import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

import 'grid_screen.dart';
import '../table_screens/seasons_table_screen.dart';

class LeaguesGridScreenRequirements implements ScreenRequirements {
  LeaguesGridScreenRequirements({required Map<String, dynamic> values}) : _values = values;

  static String get titleKey => 'title';
  static String get countryKey => 'country';

  Map<String, dynamic> _values;

  String get title => _values[titleKey];
  String get country => _values[countryKey];
}

class LeaguesGridScreen extends StatelessWidget {
  const LeaguesGridScreen({
    super.key,
    required LeaguesGridScreenRequirements requirements,
  }) : _requirements = requirements;

  final LeaguesGridScreenRequirements _requirements;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<LeagueRepository>(
      create: (context) => LeagueRepository(null),
      child: BlocProvider<ResourceBloc<League>>(
        create: (context) => ResourceBloc(
          repository: context.read<LeagueRepository>(),
        )..add(getLeaguesByCountry(_requirements.country)),
        child: BlocBuilder<ResourceBloc<League>, ResourceState<League>>(
          buildWhen: (_, current) => current.status.isSuccess,
          builder: (context, state) {
            return GridScreen<League>(
              state: state,
              title: 'Ligas y Copas de ${_requirements.title}',
              loaderMessage: 'Obteniendo torneos de ${_requirements.title}...',
              content: state.resources.map((league) => LeagueCellViewModel(league: league)).toList(),
              onSelection: (selectedItem) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SeasonsTableScreen(selectedItem: selectedItem,),),
                );
              },
            );
          },
        ),
      ),
    );
  }
}