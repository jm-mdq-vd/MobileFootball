import 'package:flutter/material.dart';

class UnderlinedBoldText extends StatelessWidget {
  const UnderlinedBoldText(this.data, {super.key,});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
        overflow: TextOverflow.fade,
      ),
    );
  }
}