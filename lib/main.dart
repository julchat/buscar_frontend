import 'package:buscar_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/tema_app.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'buscAR',
      theme: const TemaApp(colorElegido: 0).createTheme(),     
      home: const SplashScreen()
    );
  }
}



