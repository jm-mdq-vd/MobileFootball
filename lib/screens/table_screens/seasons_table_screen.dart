import 'package:flutter/material.dart';

import 'package:mobile_football/navigation/app_coordinator.dart';
import 'package:mobile_football/view_models/cells/season_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/tables/table_representation.dart';
import 'package:mobile_football/widgets/generics/tables/unordered_list.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';
import 'package:mobile_football/screens/main_screens/main_season_tabs_screen.dart';
import 'package:mobile_football/screens/screen_requirements.dart';

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
        title: '${selectedItem.title} Temporadas',
        content: (selectedItem as LeagueCellViewModel).seasons.map((season) => SeasonCellViewModel(season: season)).toList(),
      ),
      onSelection: (selectedSeason) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
              MainSeasonTabScreen(
                isCup: (selectedItem as LeagueCellViewModel).isCup,
                requirements: LeagueSeasonRequirements(
                  values: {
                    LeagueSeasonRequirements.titleKey: selectedItem.title,
                    LeagueSeasonRequirements.leagueKey: selectedItem.id,
                    LeagueSeasonRequirements.seasonKey: selectedSeason.id.toString(),
                  },
                ),
              ),
          ),
        );
      },
    );
  }
}