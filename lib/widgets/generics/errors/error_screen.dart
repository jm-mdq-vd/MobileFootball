import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key,});

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
                  FontAwesomeIcons.faceSadTear,
                  size: 120.0,
                ),
                const SizedBox(height: 24.0,),
                Text(
                  'No se pudo cargar los resultados en este momento',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20.0,),
                ),
                const SizedBox(height: 8.0,),
                Text(
                  'Por favor, revise su conexion a internet o vuelva a intentarlo en otro momento',
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
