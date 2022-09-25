import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';
import 'grid_representation.dart';
import '../cells/grid_cell.dart';
import '../../../utility/extensions/context_extension.dart';

abstract class CellRepresentationProvider {
  int get itemCount;
  Function(CellRepresentable cell)? get onSelection;
  CellRepresentable itemAtIndex(int index);
}

extension CellRepresentationX on CellRepresentationProvider {
  void itemSelectedAtIndex(int index) {
    final selectedCell = itemAtIndex(index);
    if (onSelection != null) {
      onSelection!(selectedCell);
    }
  }
}

class CellRepresentableRepository {
  CellRepresentableRepository({required List<CellRepresentable> data}) : _data = data ?? const [];

  final List<CellRepresentable> _data;

  List<CellRepresentable> results(String query) => _data.where((element) => element.searchValue.substring(0, query.length).toLowerCase().contains(query.toLowerCase())).toList();
}

class SearchState implements CellRepresentationProvider {
  SearchState({required List<CellRepresentable> results}) : _results = results;

  List<CellRepresentable> _results;

  Function(CellRepresentable cell)? onSelection;

  int get itemCount => _results.length;
  bool get foundResults => _results.isNotEmpty;
  CellRepresentable itemAtIndex(int index) => _results[index];
}


class SearchEvent {
  SearchEvent({required this.query});

  String query;
}

class SearchBloc extends Bloc<SearchEvent, SearchState>  {
  final CellRepresentableRepository _repository;

  SearchBloc({required CellRepresentableRepository repository}) : _repository = repository, super(SearchState(results: [])) {
    on<SearchEvent>((event, emit) {
      final results = _repository.results(event.query);
      emit(SearchState(results: results));
    });
  }
}

class SearchGrid extends StatefulWidget implements CellRepresentationProvider {
  const SearchGrid({
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
  State<SearchGrid> createState() => _SearchGridState();
}

class _SearchGridState extends State<SearchGrid> {
  static const double _insets = 16.0;

  int _selectedIndex = -1;
  CellRepresentationProvider cellProvider(SearchState state) => state.foundResults ? state : widget;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CellRepresentableRepository(data: widget.representation.content),
      child: BlocProvider<SearchBloc>(
        create: (context) => SearchBloc(repository: context.read<CellRepresentableRepository>()),
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.black,
                title: Text(widget.title),
              ),
              body: Container(
                color: const Color(0xB9EEECEC),
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _searchBar(context),
                    Container(
                      padding: const EdgeInsets.all(_insets),
                      child: GridView.builder(
                        clipBehavior: Clip.none,
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
                        shrinkWrap: true,
                        gridDelegate: widget.delegate,
                        itemCount: !state.foundResults ? widget.itemCount : state.itemCount,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              final CellRepresentationProvider cellProvider = state.foundResults ? state : widget;
                              if (cellProvider == state) state.onSelection = widget.onSelection;
                              if (mounted) {
                                setState(() {
                                  if (_selectedIndex == index) {
                                    _selectedIndex = -1;
                                    return;
                                  }
                                  _selectedIndex = index;
                                });
                                cellProvider.itemSelectedAtIndex(index);
                              }
                            },
                            child: GridCell(
                              model: cellProvider(state).itemAtIndex(index),
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
        )
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextField(
        decoration: const InputDecoration(
          hintText: 'Buscar ...',
          contentPadding: const EdgeInsets.symmetric(horizontal: 16,),
        ),
        onChanged: (query) {
          context.read<SearchBloc>().add(SearchEvent(query: query));
        },
      ),
    );
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

  int get _itemCount => representation.content.length;
  CellRepresentable _itemAtIndex(int index) => representation.content[index];

  SliverGridDelegateWithFixedCrossAxisCount get _delegate =>
      SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: itemSpacing,
        crossAxisSpacing: itemSpacing,
      );

  void _itemSelectedAtIndex(int index) {
    final selectedCell = _itemAtIndex(index);
    if (onSelection != null) {
      onSelection!(selectedCell);
    }
  }

  @override
  State<Grid> createState() => _GridState();
}

class _GridState extends State<Grid> {
  static const double _insets = 16.0;

  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xB9EEECEC),
      child: ListView(
        shrinkWrap: true,
        children: [
          Container(
            padding: const EdgeInsets.all(_insets),
            child: GridView.builder(
              clipBehavior: Clip.none,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(), // to disable GridView's scrolling
              shrinkWrap: true,
              gridDelegate: widget._delegate,
              itemCount: widget._itemCount,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    if (mounted) {
                      setState(() {
                        if (_selectedIndex == index) {
                          _selectedIndex = -1;
                          return;
                        }
                        _selectedIndex = index;
                      });
                      widget._itemSelectedAtIndex(index);
                    }
                  },
                  child: GridCell(
                    model: widget._itemAtIndex(index),
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
    );
  }
}

