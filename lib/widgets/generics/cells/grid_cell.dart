import 'package:flutter/material.dart';

import 'cell_representable.dart';
import '../../../utility/network_image_provider.dart';

class GridCell extends StatelessWidget {
  const GridCell({
    super.key,
    required this.model,
    required this.isSelected,
    required this.width,
  });

  static const double _height = 100;
  static const double _xInsets = 16;
  static const double _yInsets = 8;
  static const double _fontSize = 14;
  static const double _spacingSize = 16;

  final CellRepresentable model;
  final bool isSelected;
  final double width;

  @override
  Widget build(BuildContext context) {
    final isSVG = NetworkImageProvider.isSvg(model.imageURL);
    final image = NetworkImageProvider.image(model.imageURL);

    return Container(
      width: width,
      height: _height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isSelected ? const Color(0x331DA7FA) : Colors.white,
        border: isSelected ? Border.all(
          color: const Color(0xA01DA7FA),
          width: 3,
        ) : null,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: _xInsets,
          vertical: _yInsets,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: isSVG ? 59 : 100,
              height: isSVG ? 45 : 95,
              decoration: isSVG ? BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                ),
              ) : null,
              child: image,
            ),
            const SizedBox(
              height: _spacingSize,
            ),
            Text(
              model.title,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: _fontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}