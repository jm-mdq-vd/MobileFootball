import 'package:flutter/material.dart';
import 'package:mobile_football/screens/table_screens/standing_table_screen.dart';

import 'package:mobile_football/view_models/cells/season_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/tables/table_representation.dart';
import 'package:mobile_football/widgets/generics/tables/unordered_list.dart';
import 'package:mobile_football/screens/grid_screens/teams_grid_screen.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

class SeasonsTableScreen extends StatelessWidget {
  const SeasonsTableScreen({
    super.key,
    required this.selectedItem,
  });

  final CellRepresentable selectedItem;

  @override
  Widget build(BuildContext context) {
    return UnorderedList(
      representation: TableRepresentation(
        id: selectedItem.id,
        title: '${selectedItem.title} Seasons',
        content: (selectedItem as LeagueCellViewModel).seasons.map((season) => SeasonCellViewModel(season: season)).toList(),
      ),
      onSelection: (selectedSeason) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StandingTableScreen(
              title: selectedItem.title,
              leagueId: selectedItem.id,
              season: selectedSeason.id.toString(),
            ),
          ),
        );
      },
    );
  }
}