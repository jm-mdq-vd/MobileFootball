import 'package:flutter/material.dart';

import 'package:mobile_football/navigation/app_coordinator.dart';
import 'package:mobile_football/view_models/cells/season_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/tables/table_representation.dart';
import 'package:mobile_football/widgets/generics/tables/unordered_list.dart';
import 'package:mobile_football/view_models/cells/league_cell_view_model.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

class SeasonsTableScreen extends StatelessWidget {
  const SeasonsTableScreen({
    super.key,
    required this.selectedItem,
    AppCoordinator? coordinator = null,
  }) : _coordinator = coordinator;

  final CellRepresentable selectedItem;
  final AppCoordinator? _coordinator;

  @override
  Widget build(BuildContext context) {
    return UnorderedList(
      representation: TableRepresentation(
        id: selectedItem.id,
        title: '${selectedItem.title} Seasons',
        content: (selectedItem as LeagueCellViewModel).seasons.map((season) => SeasonCellViewModel(season: season)).toList(),
      ),
      onSelection: (selectedSeason) {
        _coordinator?.goToMainSeason(
          context,
          selectedItem,
          selectedSeason,
            (selectedItem as LeagueCellViewModel).isCup,
        );
      },
    );
  }
}