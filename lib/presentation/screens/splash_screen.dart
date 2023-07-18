import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'dart:async';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    redirigirScreen();
  }

  void redirigirScreen() {
    Timer(const Duration(seconds: 5), () {
      Get.off(const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Coloca aquí tu logo de la aplicación
            Image.asset(
              'assets/images/logobuscAR.png', // Ruta de la imagen de tu logo
            )
          ],
        ),
      ),
    );
  }
}
