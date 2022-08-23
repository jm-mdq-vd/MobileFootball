import 'package:flutter/material.dart';

import 'table_representation.dart';
import '../cells/cell.dart';
import '../cells/cell_representable.dart';

class Table extends StatefulWidget {
  const Table({
    super.key,
    required this.representation,
    this.onSelection = null,
  });

  final TableRepresentation representation;

  final Function(BaseCellRepresentable cell)? onSelection;

  String get title => representation.title;
  int get itemCount => representation.content.length;
  BaseCellRepresentable itemAtIndex(int index) => representation.content[index];

  @override
  State<Table> createState() => _TableState();
}

class _TableState extends State<Table> {
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
                itemBuilder: (context, index) => ListTile(title: Cell(model: widget.itemAtIndex(index),),),
                itemCount: widget.itemCount,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
