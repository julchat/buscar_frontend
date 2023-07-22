import 'package:buscar_app/presentation/screens/login_screen.dart';
import 'package:buscar_app/presentation/widgets/boton_custom.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'items_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child:
      Center(child:
        Column(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 120),
          BotonCustomSinIconoXL(onPressed: () => Get.to(()=> const ItemsScreen()) , contenido: ('CATÁLOGO')),
          const SizedBox(height: 120),
          BotonCustomSinIconoXL(onPressed: () => Get.off(()=> const LoginScreen()), contenido: ('CERRAR SESIÓN')),
          const SizedBox(height: 120),
          BotonCustomSinIconoXL(onPressed: () => (), contenido: 'CAMBIAR CONTRASEÑA'),
          const SizedBox(height: 120),
      ],) ,))));
  }
}