import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  const BoldText(this.data, {super.key,});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        overflow: TextOverflow.fade,
      ),
    );
  }
}