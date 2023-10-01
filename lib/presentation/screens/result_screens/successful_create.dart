import 'package:buscar_app/presentation/screens/items_screen.dart';
import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/successful_template.dart';
import 'package:get/get.dart';

import '../login_screen.dart';

class SuccessfulCreate extends StatelessWidget {
  const SuccessfulCreate({super.key});

  @override
  Widget build(BuildContext context) {
    return SuccessfulTemplate(textoDeResultado: 'REGISTRO EXITOSO', textoIntermedio: 'PODRÁ DETECTARLO EN LAS PRÓXIMAS 4 HORAS', textoDeBoton: 'VOLVER AL CATÁLOGO', onPressed: ()=> Get.off(() => const ItemsScreen()));
  }
}