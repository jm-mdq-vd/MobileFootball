import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_football/view_models/cells/season_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/tables/table_representation.dart';
import 'package:mobile_football/widgets/generics/tables/unordered_list.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

import 'package:mobile_football/blocs/navigation/navigation_bloc.dart';

class SeasonsTableScreen extends StatelessWidget {
  const SeasonsTableScreen({
    super.key,
    required this.selectedItem,
  });

  final CellRepresentable selectedItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigationBloc>(
      create: (context) => NavigationBloc(context: context),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return TableScreen(
            representation: TableRepresentation(
              id: selectedItem.id,
              title: '${selectedItem.title} Temporadas',
              content: (selectedItem as LeagueCellViewModel).seasons.map((season) => SeasonCellViewModel(season: season)).toList(),
            ),
            onSelection: (selectedSeason) {
              context.read<NavigationBloc>().add(
                GoToMainScreen(
                  parameters: {
                    'title': selectedItem.title,
                    'leagueId': selectedItem.id,
                    'season': selectedSeason.id.toString(),
                    'isCup': (selectedItem as LeagueCellViewModel).isCup,
                  },
                ),
              );
            },
          );
        }
      ),
    );
  }
}