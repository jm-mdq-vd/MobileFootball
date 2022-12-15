import 'package:flutter/material.dart';

class DetailText extends StatelessWidget {
  const DetailText(this.data, {super.key, this.fontSize = 18});

  final String data;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Text(
        data,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}