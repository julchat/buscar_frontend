import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/failure_template.dart';
import 'package:get/get.dart';
import 'package:buscar_app/presentation/screens/login_screen.dart';

class FailedLogin extends StatelessWidget {
  final String? mensajeDeError;
  const FailedLogin({super.key, this.mensajeDeError});

  @override
  Widget build(BuildContext context) {
    String mensajeDeErrorAux;
    String? mensajeMostrado;

    if (mensajeDeError == null) {
      mensajeMostrado = 'ALGO SALIÓ MAL';
    } else {
      mensajeDeErrorAux = mensajeDeError!;
      final contenido = json.decode(mensajeDeErrorAux);
      mensajeMostrado = contenido['usuario'];
    }

    return FailureTemplate(
        textoDeResultado: mensajeMostrado ?? 'ALGO SALIÓ MAL',
        textoDeBoton: 'REGRESAR',
        onPressed: () => Get.off(() => const LoginScreen()));
  }
}
