import 'package:buscar_app/presentation/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/failure_template.dart';
import 'package:get/get.dart';

class FailedLogout extends StatelessWidget {
  final String? mensajeDeError;
  const FailedLogout({super.key, this.mensajeDeError});

  @override
  Widget build(BuildContext context) {
    return FailureTemplate(
        textoDeResultado: mensajeDeError ?? 'ALGO SALIÓ MAL',
        textoDeBoton: 'REGRESAR',
        onPressed: () => Get.off(() => const HomeScreen()));
  }
}