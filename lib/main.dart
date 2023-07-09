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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor:const Color(0xFF010101),
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(size:40, color: Colors.black),
        ),
        colorScheme: const ColorScheme.highContrastDark(
          primary: Color(0xFFFFF81F),
          secondary:Color(0xFFFFF81F), 
          error: Color.fromARGB(253, 255, 0, 64), 
          background: Color(0xFF010101),
          onBackground: Color(0xFFFFF81F),
          surface: Color(0xFFFFF81F),
          onSurface: Color(0xFF010101),

          )
      ),
      //theme: const TemaApp(colorElegido: 0).createTheme(),     
      home: const SplashScreen()
    );
  }
}



