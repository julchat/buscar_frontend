import 'package:buscar_app/domain/controllers/object_confirmation_controller.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/failure_template.dart';
import 'package:get/get.dart';
import '../items_screen.dart';

class FailedCreate extends StatelessWidget {
  final String? mensajeDeError;
  final ObjectConfirmationController controller;
  const FailedCreate({super.key, this.mensajeDeError, required this.controller});

  @override
  Widget build(BuildContext context) {
    return FailureTemplate(
        textoDeResultado: mensajeDeError ?? 'ALGO SALIÓ MAL',
        textoDeBoton: 'REENVIAR OBJETO',
        onPressed: () => (controller.enviarArchivos()),
        textoDeBoton3: 'VOLVER A CATÁLOGO',
        onPressedBoton3: () {
          controller.clear();
          Get.off(() => const ItemsScreen());
        });
  }
}
