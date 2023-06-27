import 'package:buscar_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';

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
      theme: ThemeData(brightness: Brightness.dark,
      primaryColor: Colors.yellow),
      //theme: ThemeData(
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        //useMaterial3: true,
      //),
      home: const SplashScreen()
    );
  }
}



