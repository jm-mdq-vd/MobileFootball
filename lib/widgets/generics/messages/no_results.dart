import 'package:flutter/material.dart';

class NoResults extends StatelessWidget {
  const NoResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xB9EEECEC),
      child: const Center(
        child: Text('No Results',),
      ),
    );
  }
}
