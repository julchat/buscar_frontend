import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/conector_backend.dart';
import '../objeto.dart';

class ObjectGalleryController extends GetxController {
  void entrenarObjeto(Objeto objeto) {
    String titulo;
    String cuerpo;

    if (objeto.detectable) {
      ConectorBackend conector = ConectorBackend(
          ruta: 'rna_train_flutter/${objeto.nombre}/', method: HttpMethod.get);
      conector.hacerRequest();
      titulo = 'ENTRENAMIENTO INICIADO';
      cuerpo = 'PODRÁ DETECTARLO EN EL LAPSO DE 4 HORAS';
      objeto.detectable = false;
    } else {
      titulo = 'ENTRENAMIENTO EN PROCESO';
      cuerpo = 'ESTE OBJETO YA ESTÁ SIENDO ENTRENADO';
    }

    Get.snackbar(titulo, cuerpo,
        colorText: Colors.black,
        backgroundColor: Colors.cyan,
        messageText: Semantics(
            liveRegion: true,
            child: Text(cuerpo,
                style: const TextStyle(
                    fontWeight: FontWeight.w500, color: Colors.black))),
        duration: const Duration(seconds: 6),
        snackPosition: SnackPosition.BOTTOM);
  }
}
