import 'package:flutter/material.dart';

const Color amarilloChillon = Color(0xFFFFF81F);
const Color blanco = Color(0xFFFFFFFF);
const Color negro = Color(0xFF000000);
const Color azulFrancia = Color(0xFF001B3C);

const List<Color> coloresFrente = [amarilloChillon, blanco];
const List<Color> coloresFondo = [negro, azulFrancia];

class TemaApp {
  final int colorElegido;

  const TemaApp({this.colorElegido = 0})
      : assert(colorElegido >= 0 && colorElegido < 2);

  ThemeData createTheme() {
    return ThemeData(
        scaffoldBackgroundColor: coloresFondo[colorElegido],
        primaryColor: coloresFrente[colorElegido],
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: coloresFrente[colorElegido]),
        buttonTheme: ButtonThemeData(
            buttonColor: coloresFrente[colorElegido],
            textTheme: ButtonTextTheme.primary),
        textTheme: TextTheme(
            bodyLarge: TextStyle(color: coloresFrente[colorElegido]),
            bodyMedium: TextStyle(color: coloresFrente[colorElegido])));
  }
}
