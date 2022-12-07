import 'package:flutter/material.dart';

import 'package:mobile_football/widgets/generics/grids/grid.dart';
import 'package:mobile_football/widgets/generics/grids/grid_representation.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';
import 'package:mobile_football/blocs/resource_bloc.dart';

class GridScreen<Resource> extends StatelessWidget {
  const GridScreen({
    super.key,
    required this.state,
    required this.title,
    required this.content,
    this.onSelection,
    this.itemSpacing = 16,
    this.crossAxisCount = 2,
    this.allowsMultipleSelection = false,
    this.hasSearchBar = true,
  });

  final String title;
  final bool allowsMultipleSelection;
  final ResourceState<Resource> state;
  final List<CellRepresentable> content;
  final Function(CellRepresentable selectedItem)? onSelection;
  final bool hasSearchBar;

  final double itemSpacing;
  final int crossAxisCount;

  @override
  Widget build(BuildContext context) {
    final gridRepresentation = GridRepresentation(
      title: title,
      content: content,
    );
    return hasSearchBar ? SearchGrid(
      representation: gridRepresentation,
      itemSpacing: itemSpacing,
      crossAxisCount: crossAxisCount,
      onSelection: onSelection,
    ) : Grid(
      representation: gridRepresentation,
      itemSpacing: itemSpacing,
      crossAxisCount: crossAxisCount,
      onSelection: onSelection,
    );
  }
}