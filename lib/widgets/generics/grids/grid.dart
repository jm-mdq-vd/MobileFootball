import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

import 'grid_representation.dart';
import '../cells/grid_cell.dart';
import '../cells/cell_representable.dart';
import '../../../utility/extensions/context_extension.dart';

class CellRepresentableRepository {
  CellRepresentableRepository({List<CellRepresentable<String>>? data}) : _data = data ?? const [];

  final List<CellRepresentable<String>> _data;

  List<CellRepresentable<String>> matches(String query) => _data.where((element) => element.id.contains(query)).toList();
}

class SearchBarBloc<Resource> {
  final CellRepresentableRepository _repository;
  final _searchQueryController = StreamController<String?>();
  Sink<String?> get searchQuery => _searchQueryController.sink;

  late Stream<List<CellRepresentable<String>>> results;

  SearchBarBloc(CellRepresentableRepository repository) : _repository = repository {
    results = _searchQueryController
      .stream
      .asyncMap((query) => _repository.matches(query ?? ''));
  }
}

class Grid extends StatefulWidget {
  const Grid({
    super.key,
    required this.representation,
    this.onSelection = null,
    this.crossAxisCount = 2,
    this.itemSpacing = 16,
  });

  final GridRepresentation representation;
  final int crossAxisCount;
  final double itemSpacing;

  final Function(CellRepresentable cell)? onSelection;

  String get title => representation.title;
  int get itemCount => representation.content.length;
  CellRepresentable itemAtIndex(int index) => representation.content[index];

  SliverGridDelegateWithFixedCrossAxisCount get delegate =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: itemSpacing,
        crossAxisSpacing: itemSpacing,
      );

  @override
  State<Grid> createState() => _GridState();

  void itemSelectedAtIndex(int index) {
    final selectedCell = itemAtIndex(index);
    if (onSelection != null) {
      onSelection!(selectedCell);
    }
  }
}

class _GridState extends State<Grid> {
  static const double _insets = 16.0;

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Container(
        padding: const EdgeInsets.all(_insets),
        color: const Color(0xB9EEECEC),
        child: Column(
          children: [
            _searchBar(),
            Expanded(
              child: GridView.builder(
                clipBehavior: Clip.none,
                scrollDirection: Axis.vertical,
                gridDelegate: widget.delegate,
                itemCount: widget.itemCount,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (mounted) {
                        setState(() {
                          _selectedIndex = index;
                        });
                        widget.itemSelectedAtIndex(index);
                      }
                    },
                    child: GridCell(
                      model: widget.itemAtIndex(index),
                      isSelected: _selectedIndex == index,
                      width: (context.width / widget.crossAxisCount) -
                          (widget.itemSpacing * widget.crossAxisCount),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: const InputDecoration(border: OutlineInputBorder(), hintText: 'Search ...'),
        onChanged: (query) {
          print(query);
        },
      ),
    );
  }
}
