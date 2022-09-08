import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  const BoldText(this.data, {super.key, this.color = Colors.black});

  final String data;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.fade,
        color: color,
      ),
    );
  }
}