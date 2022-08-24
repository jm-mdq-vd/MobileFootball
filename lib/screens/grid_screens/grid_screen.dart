import 'package:flutter/material.dart';

import 'package:mobile_football/widgets/generics/grids/grid.dart';
import 'package:mobile_football/widgets/generics/grids/grid_representation.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';
import 'package:mobile_football/widgets/generics/loaders/screen_loader.dart';
import 'package:mobile_football/widgets/generics/messages/no_results.dart';
import 'package:mobile_football/blocs/resource_status.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';

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