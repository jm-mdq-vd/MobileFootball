import 'package:flutter/material.dart';
import 'package:mobile_football/widgets/generics/cells/cell_representable.dart';

import 'grid_representation.dart';
import '../cells/grid_cell.dart';
import '../cells/cell_representable.dart';
import '../../../utility/extensions/context_extension.dart';

class Grid extends StatefulWidget {
  const Grid({
    super.key,
    required this.representation,
    this.crossAxisCount = 2,
    this.itemSpacing = 16,
  });

  final GridRepresentation representation;
  final int crossAxisCount;
  final double itemSpacing;

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

  void itemSelectedAtIndex(int index) {}
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
    );
  }
}
