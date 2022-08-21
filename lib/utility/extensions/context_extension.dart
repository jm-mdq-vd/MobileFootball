import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {
  Size get screenSize => MediaQuery.of(this).size;
  EdgeInsets get padding => MediaQuery.of(this).padding;

  double get height => screenSize.height;
  double get width => screenSize.width;
}