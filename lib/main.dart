import 'package:buscar_app/domain/controllers/loading_controller.dart';
import 'package:buscar_app/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.put(LoadingController());
    return GetMaterialApp(
        title: 'buscAR',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFF010101),
          appBarTheme: const AppBarTheme(
              iconTheme: IconThemeData(size: 40, color: Colors.black),
              titleTextStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 23)),
          colorScheme: const ColorScheme.highContrastDark(
              primary: Color(0xFFFFF81F),
              secondary: Color(0xFFFFF81F),
              error: Color.fromARGB(252, 255, 71, 117),
              background: Color(0xFF010101),
              onBackground: Color(0xFFFFF81F),
              surface: Color(0xFFFFF81F),
              onSurface: Color(0xFF010101),
              tertiary: Color.fromARGB(255, 255, 255, 255),
              inversePrimary: Color(0xFF66fff9)),
          inputDecorationTheme: const InputDecorationTheme(
              labelStyle: TextStyle(color: Color(0xFFFFF81F), fontSize: 20),
              floatingLabelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFFFF81F))),
        ),
        //theme: const TemaApp(colorElegido: 0).createTheme(),
        home: const SplashScreen());
  }
}
