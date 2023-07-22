import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/failure_template.dart';
import 'package:get/get.dart';

import '../login_screen.dart';

class FailedLogin extends StatelessWidget {
  final String? mensajeDeError;

  const FailedLogin({super.key, this.mensajeDeError});

  @override
  Widget build(BuildContext context) {
    return FailureTemplate(
        textoDeResultado: mensajeDeError ?? 'ALGO SALIÓ MAL',
        textoDeBoton: 'REGRESAR',
        onPressed: () => Get.off(() => const LoginScreen()));
  }
}
