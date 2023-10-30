import 'package:buscar_app/presentation/screens/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/successful_template.dart';
import 'package:get/get.dart';

class SuccessfulCreate extends StatelessWidget {
  final bool? chequeado;
  const SuccessfulCreate({super.key, required this.chequeado});

  @override
  Widget build(BuildContext context) {
    String textoIntermedio = 'ENCONTRARÁ EL NUEVO OBJETO EN SU CATÁLOGO';
    if (chequeado != null) {
      if (chequeado == true) {
        textoIntermedio = 'PODRÁ DETECTARLO EN LAS PRÓXIMAS 4 HORAS';
      }
    }
    return SuccessfulTemplate(
        textoDeResultado: 'REGISTRO EXITOSO',
        textoIntermedio: textoIntermedio,
        textoDeBoton: 'VOLVER AL CATÁLOGO',
        onPressed: () => Get.off(() => const ItemsScreen()));
  }
}
