import 'package:flutter/material.dart';

import 'table_representation.dart';
import '../cells/cell.dart';
import '../cells/cell_representable.dart';

class UnorderedList extends StatefulWidget {
  const UnorderedList({
    super.key,
    required this.representation,
    this.onSelection = null,
  });

  final TableRepresentation representation;

  final Function(BaseCellRepresentable cell)? onSelection;

  String get title => representation.title;
  int get itemCount => representation.content.length;
  BaseCellRepresentable itemAtIndex(int index) => representation.content[index];

  void itemSelectedAtIndex(int index) {
    final selectedCell = itemAtIndex(index);
    if (onSelection != null) {
      onSelection!(selectedCell);
    }
  }

  @override
  State<UnorderedList> createState() => _TableState();
}

class _TableState extends State<UnorderedList> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
      ),
      body: Container(
        color: const Color(0xB9EEECEC),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: GestureDetector(
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
                  ),
                ),
                itemCount: widget.itemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}