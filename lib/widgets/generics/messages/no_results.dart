import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoResults extends StatelessWidget {
  const NoResults({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 24.0,
            horizontal: 24.0,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.faceGrimace,
                  size: 120.0,
                ),
                const SizedBox(height: 24.0,),
                Text(
                  'Ha alcanzado el limite de consultas por hoy',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0,),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  'Por favor vuelva a intentar cargar esta pagina mas tarde.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
