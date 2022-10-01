import 'package:flutter/material.dart';

import 'cell_representable.dart';

class Cell extends StatelessWidget {
  const Cell({
    super.key,
    required this.model,
    required this.isSelected,
  });

  static const double _padding = 16;

  final bool isSelected;
  final BaseCellRepresentable model;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: isSelected ? const Color(0x331DA7FA) : Colors.white,
        border: isSelected ? Border.all(
          color: const Color(0xA01DA7FA),
          width: 2,
        ) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: _padding,
          top: _padding,
          bottom: _padding,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              model.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}