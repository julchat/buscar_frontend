
import 'package:buscar_app/domain/controllers/search_result_controller.dart';
import 'package:buscar_app/presentation/screens/result_screens/failed_search.dart';
import 'package:buscar_app/presentation/widgets/neutral_template.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../domain/controllers/item_search_controller.dart';
import '../../../domain/objeto.dart';
import '../items_screen.dart';

class SearchResultScreen extends GetView<SearchResultController> {
  final Ubicacion ubicacion;
  final double precision;
  final Objeto objeto;
  const SearchResultScreen(
      {super.key,
      required this.ubicacion,
      required this.precision,
      required this.objeto});

  @override
  Widget build(BuildContext context) {
    String nombreObjeto = objeto.nombre.toUpperCase();
    String ubicacionTexto = ubicacion.name;

    ItemSearchController controllerItemSearch =
        Get.find<ItemSearchController>();
    if (ubicacion == Ubicacion.error) {
      Get.off(() => const FailedSearch(
          mensajeDeError: 'HUBO UN PROBLEMA EN LA RESPUESTA DE LA DETECCIÓN'));
      return const SizedBox();
    } else {
      String textoDeResultado;
      if (ubicacion == Ubicacion.noEncontrada) {
        textoDeResultado = 'NO SE ENCONTRÓ EL OBJETO $nombreObjeto';
      } else {
        textoDeResultado =
            'SE ENCONTRÓ $nombreObjeto EN EL SEXTANTE $ubicacionTexto';
      }
      return NeutralTemplate(
          textoDeBoton: 'TOMAR NUEVA FOTO',
          textoDeResultado: textoDeResultado,
          onPressed: () {
            controllerItemSearch.clearImage();
            controllerItemSearch.openCamera();
          },
          textoDeBoton2: 'VOLVER AL CATÁLOGO',
          onPressedBoton2: () {
            controllerItemSearch.clearImageAndObjeto();
            Get.off(() => const ItemsScreen());
          });
    }
  }
}
