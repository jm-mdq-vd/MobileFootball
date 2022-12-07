import 'package:flutter/material.dart';

import 'table_representation.dart';
import '../cells/cell.dart';
import '../cells/cell_representable.dart';


class TableScreen extends StatelessWidget {
  const TableScreen({
    super.key,
    required TableRepresentation representation,
    Function(BaseCellRepresentable cell)? onSelection,
  }) : _representation = representation, _onSelection = onSelection;

  final TableRepresentation _representation;
  final Function(BaseCellRepresentable cell)? _onSelection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_representation.title),
      ),
      body: UnorderedList(
        representation: _representation,
        onSelection: _onSelection,
      ),
    );
  }
}


class UnorderedList extends StatefulWidget {
  const UnorderedList({
    super.key,
    required this.representation,
    this.onSelection = null,
    this.isScrollable = true,
  });

  final TableRepresentation representation;
  final Function(BaseCellRepresentable cell)? onSelection;
  final bool isScrollable;

  int get itemCount => representation.content.length;
  BaseCellRepresentable itemAtIndex(int index) => representation.content[index];

  void itemSelectedAtIndex(int index) {
    final selectedCell = itemAtIndex(index);
    if (onSelection != null) {
      onSelection!(selectedCell);
    }
  }

  @override
  State<UnorderedList> createState() => _UnorderedListState();
}

class _UnorderedListState extends State<UnorderedList> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      primary: widget.isScrollable,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (mounted) {
              setState(() {
                _selectedIndex = index;
              });
              widget.itemSelectedAtIndex(index);
            }
          },
          child: Cell(
            model: widget.itemAtIndex(index),
            isSelected: _selectedIndex == index,
          ),
        );
      },
      itemCount: widget.itemCount,
      separatorBuilder: (BuildContext context, int index) => Container(height: 1, color: Colors.grey,),
      // physics: widget.isScrollable ? null : NeverScrollableScrollPhysics(),
    );
  }
}
