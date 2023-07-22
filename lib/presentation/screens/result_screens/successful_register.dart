import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/successful_template.dart';
import 'package:get/get.dart';

import '../login_screen.dart';

class SuccessfulRegister extends StatelessWidget {
  const SuccessfulRegister({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessfulTemplate(textoDeResultado: 'REGISTRO EXITOSO', textoDeBoton: 'INICIAR SESIÓN', onPressed: ()=> Get.off(() => const LoginScreen()));
  }
}
