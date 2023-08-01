import 'package:flutter/material.dart';
import 'package:buscar_app/presentation/widgets/failure_template.dart';
import 'package:get/get.dart';
import '../../../domain/controllers/item_search_controller.dart';
import '../items_screen.dart';

class FailedSearch extends StatelessWidget {
  final String? mensajeDeError;
  const FailedSearch({super.key, this.mensajeDeError});

  @override
  Widget build(BuildContext context) {
    ItemSearchController controller = Get.find<ItemSearchController>();
    return FailureTemplate(
        textoDeResultado: mensajeDeError ?? 'ALGO SALIÓ MAL',
        textoDeBoton: 'REENVIAR IMAGEN',
        onPressed: () => (controller.iniciarBusqueda()),
        textoDeBoton2: 'NUEVA FOTO',
        onPressedBoton2: () {
          controller.clearImage();
          controller.openCamera();
        },
        textoDeBoton3: 'VOLVER A CATÁLOGO',
        onPressedBoton3: () {
          controller.clearImageAndObjeto();
          Get.off(() => const ItemsScreen());
        });
  }
}
