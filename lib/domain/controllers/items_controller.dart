import 'dart:convert';

import 'package:get/get.dart';
import '../../infrastructure/conector_backend.dart';
import '../../infrastructure/respuesta.dart';
import '../objeto.dart';
import 'item_create_controller.dart';
import 'item_search_controller.dart';

enum EstadoPantalla { inicial, carga, objetos, error, vacio }

class ItemsController extends GetxController {
  RxList<Objeto> itemsList = RxList<Objeto>.of([]);
  Rx<EstadoPantalla> estadoPantalla = EstadoPantalla.inicial.obs;

  void buscarObjeto(Objeto objeto) {
    ItemSearchController buscador = Get.find<ItemSearchController>();
    buscador.setObjeto(objeto);
    buscador.openCamera();
  }

  void agregarObjeto() {
    ItemCreateController creadorItems = Get.find<ItemCreateController>();
    creadorItems.deletePhotos();
    Get.to(() => const CapturePhotosScreen());
  }

  void conseguirObjetos() async {
    ConectorBackend conector = ConectorBackend(
        ruta: '/mostrar_catalogo_flutter/', method: HttpMethod.get);
    estadoPantalla.value = EstadoPantalla.carga;
    var respuesta = await conector.hacerRequest();
    if (respuesta.estado == EstadoRespuesta.finalizadaOk) {
      final body = json.decode(respuesta.respuestaExistente!.body);
      if (body['vacio']) {
        estadoPantalla.value = EstadoPantalla.vacio;
      } else {
        List<dynamic> objetos = body['objetos'];
        List<Objeto> objetosMapeados =
            objetos.map((objeto) => Objeto.fromJson(objeto: objeto)).toList();
        itemsList.value = objetosMapeados;
        estadoPantalla.value = EstadoPantalla.objetos;
      }
    } else {
      estadoPantalla.value = EstadoPantalla.error;
    }
  }

  void abrirSnackbar(Objeto objeto) {
    Get.snackbar('No detectable', 'ESTE OBJETO TODAVÍA NO ESTÁ LISTO',
    duration: const Duration(seconds: 4),
    snackPosition: SnackPosition.BOTTOM);
  }
}
